---
layout: post
title:  "Is there a trend towards more downvoting on /r/haskell?"
categories: blog
---

Something which I thought I noticed over the last year-or-so was that there
seemed to be more posts on [/r/haskell](http://www.reddit.com/r/haskell)
getting downvoted to 0 points.

Was this just my imagination?

I built a small set of tools to help provide a definitive answer.

<!--more-->

A look at votes over time:

	NOTOTAL=true get-subreddit-posts.sh haskell \
	| xargs -n 1 cat \
	| tee >(jq -r '.data.children
	       | .[] | .data
	       | (.score | tostring) + " " + .title' 1>&2) \
	| jq '.data.children | .[] | .data.score' \
	| plot-columns.py \
	| tee /dev/stderr \
	| xargs open

<img src="/images/haskell-downvoting/haskell_votes_per_post_over_time.png" class="fit image" />

Groups of 0-votes:

	cat /tmp/subreddit-posts/haskell/81542/postset-all.json \
	  | jq -r '.data.children | .[] | .data | (.created | tostring) + " " + (.ups | tostring)' \
	  | sqlbong "select
	               strftime('%Y-%m', datetime(c1, 'unixepoch')) as ym,
	               count(*) as cs
	               from data
	               where CAST(c2 as integer) < 2
	               group by ym" \
	  | sed 's/.* //' \
	  | plot-columns.py \
	  | tee /dev/stderr \
	  | xargs open

<img src="/images/haskell-downvoting/low-votes-by-month.png" class="fit image" />

Unfortunately reddit seems to impose a limit on the amount of posts that can be
downloaded using this method...

	cat /tmp/subreddit-posts/haskell/81542/postset-all.json \
	  | jq -r '.data.children | .[] | .data | (.created | tostring) + " " + (.ups | tostring)' \
	  | sqlbong "select
	               strftime('%Y-%m', datetime(c1, 'unixepoch')) as ym,
	               count(*) as cs
	               from data
	               where CAST(c2 as integer) < 2
	               group by ym"

<!-- -->

	  2015-09 12
	  2015-10 13
	  2015-11 17
	  2015-12 19
	  2016-01 8

/r/haskell has certainly been around for more than five months, so let's see if we
can fix the scraping script:

	cat ~/bin/get-subreddit-posts.sh

{% highlight shell %}
	#!/bin/bash
	
	SUBREDDIT=${SUBREDDIT-"$1"}
	OUTDIR=${OUTDIR-"/tmp/subreddit-posts/$SUBREDDIT/$$"}
	OUTALL="${OUTDIR}/postset-all.json"
	
	if [ ! "$SUBREDDIT" ]
	then
		echo "Must Define SUBREDDIT"
		exit 1
	fi
	
	BEFORE=""
	PAGESIZE=100
	INDEX=0
	
	mkdir -p "$OUTDIR"
	
	while true
	do
		OUTFILE="$OUTDIR/postset-${INDEX}.json"
		curl -s "https://www.reddit.com/r/${SUBREDDIT}/search.json?restrict_sr=on&show=all&sort=new&t=all&limit=${PAGESIZE}&after=${BEFORE}" \
			| jq . > "$OUTFILE"
		echo "$OUTFILE"
		cat "$OUTFILE" >> "$OUTALL"
		BEFORE=$(jq -r '.data.after' < "$OUTFILE")
		if [ ! "$BEFORE" ] || [ "$BEFORE" == "null" ]; then break; fi
		((INDEX++))
	done
{% endhighlight %}
