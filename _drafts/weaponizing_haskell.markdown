---
layout: post
title:  "Weaponizing Haskell - Part One"
categories: blog
hidden: true
---

<p class="attribution">
	<img src="/images/weaponizing-haskell/missile.png" class="image fit" />
	<a href="https://www.flickr.com/photos/53384689@N06/">marycat879</a> -
	<a href="https://www.flickr.com/photos/53384689@N06/4972941858/in/photolist-8zrCmS-bqaHcf-FSUAG-bD5wnF-NoPtt-bD5Mc8-amRUX5-azQe61-5CFfGm-bqaLxJ-6sqvJy-7yMw2W-bqaL2u-9B59nU-6c8qgE-dKzH8E-6sqvVU-bqaNvY-9dZWSf-dEGyzU-6smkyX-gGdzHd-6p57rh-bqaCvS-9B5erY-8vyVq2-6sqviw-6smker-dEB46B-6smkqr-FihPF-6smkXc-6squyf-6smjRX-6dME7p-fTq2Uw-fTq4uo-4r4cJp-dKzHcq-dkyPaj-fCgfQf-9NNAkt-5RjCW7-8BSZvS-5FdFB8-Fi4DQ-q68q5g-Fib4h-onZDmp-onZ6T6">"Missile"</a>
</p>

This is a set of notes summarizing the trials and tribulations involved in getting a
small Haskell application building, running, and scaling in the cloud on a budget!

The outcome is that the app still isn't running, but we are on the bring of having
it running on AWS through Elastic Beanstalk. Stay tuned for Part-Two, where
I'll speak in more detail about the final step, and guide you down the happy-path
towards building and running your own Haskell services in the cloud...

<!--more-->

## What I Want

### Simple

* Conceptually clear architecture
* Seperation of responsibilities by service

### Builds

* Automated builds in the cloud
* For cheap!
* With limited access to my accounts

### Deployments

* Dockerized
* Deployable with multi-container support
* Ideally platform agnostic
* Running on AWS for now

### Scalable

* Expand the capability of the platform
* Grow users
* Grow services
* Grow volume

## Where I am Now

* Pre-Prod
* CI pipeline is working fine
* Still having issues with Elastic Beanstalk
* HALP

## How I Got There

* Docker
* Multi-Stage Containers
* Proxy Version Control Accounts

## Problems I Encountered

* Credential Greed
* Build Times
* Beanstalk Errors

## What's Left

### Production Services

* AWS Beanstalk Deployment
* or AWS ECS
* or AWS EC2 manual deploys

### App Changes Left

* Subscriptions
* Web-Interface
* Email gateway
* Privelaged Use-cases

### Ops Changes Left

* HTTPS
* Zero-Downtime Deploys
* Ansible Ops
* VPCs

# Links

* [Slides](http://sordina.presentations.s3.amazonaws.com/mfug_weaponized_haskell_20160303/index.html#/)
* [Melbourne Haskell Meetup](http://www.meetup.com/Melbourne-Haskell-Users-Group/events/228578673/)
* [Melbourne Functional Meetup](http://www.meetup.com/Melbourne-Functional-User-Group-MFUG/events/228116766/)
* [Melbourne Functional Presentation](https://github.com/sordina/mfug_weaponizing_haskell)
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose)
* [Docker Hub](https://hub.docker.com)
* [AWS Elastic Beanstalk](https://aws.amazon.com/documentation/elastic-beanstalk/)
* [AWS ECS](https://aws.amazon.com/ecs/getting-started)
