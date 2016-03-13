---
layout: post
title:  "Weaponizing Haskell - Part Two: Deployment"
categories: blog
reddit: "https://www.reddit.com/r/sordina/comments/4a7wf5/weaponizing_haskell_part_two_deployment_bows_and/"
---

<p class="attribution">
	<img src="/images/weaponizing-haskell-2-deploy/haskell-canyon.png" class="image fit" />
	<a href="https://www.flickr.com/photos/respres/">Jeff Turner</a> -
	<a href="https://www.flickr.com/photos/respres/15521877344/in/photolist-pDBFmU-fgKGkX-dcWKv-5AQKjW-fbjcYX-3dwYH-8NYiMC-dCBVwr-bX7MhW-brXao6-dCHkSL-6HBnE-fRZep-dCHkHG-eDvn5o-98fiuy-98fiFS-98c9Qk-dCHkGd-erjQPL-brXaoi-98c9Ex-dhaQi-dCHkhG-pZLQXP-dCBV6i-98c9N2-pVNtsG-hkGJP-dCBVLn-fRZct-98fiDN-dCBVSi-3oZkgc-brXaor-brXanz-pDR64g-dCHkw5-brXann-bps6j8-98fiwA-dCHkbY-6LgetG-86fcYs-dCBVQF-dCESAV-8ABw6-4Kcme2-hkGGN-pDBGod">"Haskell Canyon Sunrise"</a>
</p>

Following on from [Weaponizing Haskell - Part One](/blog/2016/03/03/1457007650-weaponizing_haskell.html),
which left us on a stable footing with regards to Continuous Integration, but mired in the marshes
of Elastic Beanstalk deployment woes... We now have a running EB deployment!

This post will detail what this looks like, and what was involved in getting here.

<!--more-->

# Links

* [tl;dr](#tldr)
* [Issues with Dockerrun.aws.json](#issues-with-dockerrunawsjson)
* [Dockerrun Debugging](#dockerrun-debugging)
* [Dockerrun The Right Way](#dockerrun-the-right-way)
* [Issues with Authentication Details Access](#issues-with-authentication-details-access)
* [Auth-Access Debugging](#auth-access-debugging)
* [Auth-Access the Right Way](#auth-access-the-right-way)
* [Summary](#summary)

## tl;dr

I'm now at a point where I have 3 services, one written by me, two by others running and
communicating on AWS Elastic Beanstalk. My service is builD through a two-stage
CI process on DockerHub, with the first stage being public, and the second private.
The private docker images are pulled by Beanstalk through an S3-hosted encrypted permissions
file that the EC2 instances are granted permissions to read.

If you want to make this happen too, then...

* You must have a pedantically-correct Dockerrun.aws.json file
* Your authentication block must point to an S3 bucket that your instances have permission to read
* Your encrypted authentication data must be in the right format


## Issues with Dockerrun.aws.json

The biggest time-waster that we faced in deploying the services was getting `Dockerrun.aws.json`
just right. The format itself is quite simple, and similar to, but subtly different from
the `docker-compose` format. This in itself was not too much of a bother...
Once we figured out just where the two differed. Unfortunately, Elastic Beanstalk exacerbates
the issue but providing worse-than-useless debugging output when you get the format wrong.

### Dockerrun Debugging

If you see the following when you deploy your source-bundle to beanstalk...

> ECS Application sourcebundle validation error: We expected a VALUE token but got: START_OBJECT

This is an indication that your `Dockerrun.aws.json` file is wrong (or missing!). But do NOT expect
it to be an indication of _how_ it is wrong. In-fact, the message is just about the opposite of what
I had wrong.

One of the main issues I had was that my `command` property for one of my services was a string,
but it should have been an array. Docker-Compose allows this, but Dockerrun doesn't.
I ended up reading the [ECS Task-Definition Parameters](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html)
manual with much more scrutiny and realizing my mistake, but part of why it took me so long to
do so was because of the misleading error message.

Beanstalk error message:

> ECS Application sourcebundle validation error: We expected a VALUE token but got: START_OBJECT

What it should have been:

> ECS Application sourcebundle validation error: We expected an ARRAY token but got: STRING

Ideally also including:

> Error found in the "command" property of the "promises_backend" service-definition.

Prior to my discovery of the solution, if you had told me that you were getting this error, then
I would have said "give up". Now I have some better advice!

### Dockerrun The Right Way

I've created a preliminary [JSON schema for validating Dockerrun.aws.json files.](https://gist.github.com/sordina/6094aca9bde8acc15158)

I'm sure that this has some bugs, and is missing definitions for various properties, but at least
it will stop me from making the same mistake again!

You can validate against this schema online [here](http://jsonschemalint.com/draft4/), but
I've now created a [JSEN](https://github.com/bugventure/jsen#getting-started) backed validator
for the project that runs before deployment.


## Issues with Authentication Details Access

If you wish to pull privately hosted images with Beanstalk, then you must include an
authentication section in your Dockerrun.aws.json.

### Auth-Access Debugging

The authentication section can go wrong in the following ways:

* Incorrect JSON format in Dockerrun
* Incorrect Bucket
* Incorrect Key
* Incorrect Permissions granted to EC2 Instances
* Incorrect Format of encrypted credentials on S3
* Incorrect Credentials for your repository

Once again, the debugging story is pretty sub-par for diagnosing why your
images aren't working when the issue is related to the authentication section.
During diagnosis, the first thing to note is that public images are being
fetched and run, but your private images aren't.

A good way to check this is to ssh onto your instance using `eb ssh`,
then show what images have run by using `sudo docker ps -a`. If you are suffering from
authentication problems, then your private images will be conspicuously missing
from the listing.

Then just step through all of the reasons why your credentials could be borked, and
eliminate them one by one. That's about all you can do. The logs were next to useless.

### Auth-Access the Right Way

The config block will look something like the following:

	{ "authentication": {
			"bucket": "myspecialbucket",
			"key":    "myapp/myapp.config.json" } }

And the payload on S3 should take the following format:

	{ "https://index.docker.io/v1/": {
			"auth": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
			"email": "mydockerhubloginemail@gmail.com" } }

The block can be derived from your `~/.docker/config.json`, however, you need
the old-style format for the credentials, which if you're using a recent version
of docker, then you will not have. This is noted
[in the documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker.html#docker-images-private)...
But, unfortunately for me, I missed it.

## Summary

I'm serious blown away by the immaturity of the debugging story for Beanstalk. I wasted an ungodly amount
of time fixing what were trivial mistakes, simply because of vague, misleading and sometimes withheld error messages
from the Beanstalk deployment and runtime logs.

If Amazon wants to call Beanstalk "Heroku for AWS", then they must be targeting Heroku's worst qualities.

Overall, I can't say I wasn't warned, but I decided to give it a go and power-through anyway.
I got there in the end, and now I'd like to help ensure that other people don't have to go through
the same pain that I did.

Now that the Ops steps are somewhat taken care of, I'm back to working on the application itself.
I'll follow up with a third "Weaponizing Haskell" post with more details and a set of templates,
tools, and a roadmap once it is at a public-beta stage.

Stay tuned!


# Links

* [JSON schema for validating Dockerrun.aws.json files.](https://gist.github.com/sordina/6094aca9bde8acc15158)
* [Weaponizing Haskell - Part One](/blog/2016/03/03/1457007650-weaponizing_haskell.html)
* [ECS Task-Definition Parameters](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html)
* [Online JSON Schema Validator](http://jsonschemalint.com/draft4/)
* [JSEN](https://github.com/bugventure/jsen#getting-started)
* [Beanstalk Authentication Documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker.html#docker-images-private)...
