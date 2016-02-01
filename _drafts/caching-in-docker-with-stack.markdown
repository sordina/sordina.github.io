---
layout: post
title:  "Caching in Docker with Stack"
categories: blog
---

Here are a few tips on how to maximize [Docker's](https://www.docker.com)
caching capabilities when building [Haskell](https://www.haskell.org/)
projects with the [Stack](https://www.stackage.org/) tool.

Your docker-file should resemble the following format

* Get your image into a state where there is a Stack installation available
* Pre-Install some of your project's large dependencies
* Make sure that the system resolver is the same as the resolver in your project's configuration
* Copy your project's sources into the docker image
* Stack install your project

This should ensure that you don't have to rebuild your project's dependencies with every
change made to the code-base. This is still less then ideal, as a large codebase will
still have to have it full source built on every change, however at least the dependencies
won't weigh you down...
