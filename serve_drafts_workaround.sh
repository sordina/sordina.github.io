#!/bin/bash

CWD=`pwd`

cd ~/Code/jekyll && bundle exec jekyll serve --watch --drafts --source "$CWD"
