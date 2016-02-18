---
layout: post
title: "Everything but the Last Step"
categories: blog
reddit: "https://www.reddit.com/r/sordina/comments/46coj7/everything_but_the_last_step_bows_and_arrows/"
---

I write a lot of convenience scripts day-to-day. These usually take the form of
a visualisation, text-processing, html-generation, you get the idea.
In the past I would usually have the convenience script also perform the action
that I fundamentally wanted to achieve.
For example, I wrote a small python script to plot two columns of CSV input
and then display them to me called
[plot-columns.py](https://gist.github.com/sordina/5de735198c3250538075).

<!--more-->

This script takes in numeric columns of CSV input and then renders a PNG
of the values in a line-chart. As a last-step this script used to open the file
with OS-X's Preview, because that's what I use to view PNGs.
This is bad. It presumes the auxiliary programs that the user has on their system,
it complicates the script with unnecessary paraphernalia, and is inflexible
if you want to perform a different action.

	cat data.csv | plot-columns.py

> Bad Behaviour - Implicit finalising action - Display the PNG

There is a better way!

Just print the last output to STDOUT and then pick it up with xargs to run your
preview.

	cat data.csv | plot-columns.py | xargs open

> Good Behaviour - Explicit Open

Or write it to a file, copy to your clipboard, have it pasted into your
text editor, etc. etc. The principle is that you allow your scripts
to be used in the middle of a pipeline, rather than just at the end.

This principle applies to many things, not just visualization scripts.
