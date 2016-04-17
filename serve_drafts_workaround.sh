#!/bin/bash

CWD=`pwd`

cd ~/Sites/sordina.github.io_drafts_workaround/ && bundle exec jekyll serve --watch --drafts --source "$CWD"
