---
layout: post
title:  "Caching in Docker with Stack"
categories: blog
---

Here are a few tips on how to maximize [Docker's](https://www.docker.com)
caching capabilities when building [Haskell](https://www.haskell.org/)
projects with the [Stack](https://www.stackage.org/) tool.

* Pre-Install some of your project's large dependencies
* Make sure that your default system resolver is the same as your project's config resolver
