---
layout: post
title: "Social Media as an Index"
categories: blog
reddit: "http://sordina.github.io/blog/2016/02/29/1456693366-social_media_as_an_index.html"
---

<p class="attribution">
	<img src="/images/social-media-index/archives3.png" class="image fit" />
	<a href="https://www.flickr.com/photos/kulturarvsprojektet/">DRs Kulturarvsprojekt</a> -
	<a href="https://www.flickr.com/photos/kulturarvsprojektet/6498637005/in/photolist-aUgdnB-7MD3dV-fmtgQn-aUg5p6-eLz2Kp-9gUzi2-Mhc6H-6zikYQ-aUg8cx-8JPib7-vgdVXn-fApYgF-8uDviZ-bwuDC4-2X7KSR-aGir6R-pexZnJ-eEdNHe-bH8xmk-fJiYY-3nsq5E-c5eEWw-gj3Qe-dSNCNT-6HeRMk-FeWvD-5a4ToF-rhTooD-hSrqbk-Mhc6R-dZjb2j-6HeTWv-Mhc7n-5a97Nu-rTD13u-Mh1of-8FHHAJ-Mh1pq-8BFk82-5dRGcb-Mh1oQ-jL2Khe-tqvvXr-cS9Lx5-mhCYtN-FeWxg-bDwVD8-qBVcyE-2XevxG-ry6kbL">"Video tape archive storage"</a>
</p>

Social media is fun - We love sharing our thoughts with our friends,
and looking at what our friends are thinking about too, but
social-media has the power to be more than just an ephemeral stream
of current thoughts and events. And that power is being vastly
underutilised by existing networks.

All that's required to change this is better search...

<!--more-->

## Why?

This empowers social media to be more than just a stream. With a good search
interface you can use it for note-taking, archiving, referencing, etc.

## Use-Cases

| Desire | Frustration |
| ------ | ----------- |
| I want to find that great thing posted last year... | I can't easily search my own Facebook! |
| I want to look at all my close friend's pictures, oldest-first ... | I can't customize the results view. |
| I want all the post-titles on one page... | I can't cmd-f effectively. |

## My Current Work-Arounds

Since I don't have the time to spend crafting custom web-interfaces for
this purpose at the moment; Command-line apps will have to do :)

### [Searching my own posts - Google Plus](https://gist.github.com/sordina/0159bafd3e5fbc0c2f0c)

It's ironic that google provides such a bad experience for searching
your own posts, but there you are.

In order to quickly track something down in Google-Plus, I've put
this script together that will quickly scrape a user's posts.
It saves the results, so that you can execute multiple searches
quickly, then I just grep through the data:

<https://gist.github.com/sordina/0159bafd3e5fbc0c2f0c>
