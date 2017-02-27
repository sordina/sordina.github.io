---
layout: post
title:  "Running a 'Haskell for .Net-Users' Workshop"
categories: blog
reddit: "https://www.reddit.com/r/sordina/comments/5wehnf/running_a_haskell_for_netusers_workshop_bows_and/"
---

<style>

.half-image {
	max-width: 100%;
}

@media screen and (min-width: 480px) {
	.half-image {
		max-width: 45% !important;
		padding: 4px;
	}
}

.center-contents {
	text-align: center;
}
</style>

On Saturday I helped run a [one-day Haskell workshop](https://sordina.github.io/alt_dot_net_haskell_workshop/)
for the members of the
[Melbourne Alt .Net user-group](https://www.meetup.com/Melbourne-ALT-NET/?chapter_analytics_code=UA-58562077-1).
This idea had actually been in the works for close to two-years but since I'd put on
a Haskell workshop at [Compose :: Melbourne](http://www.composeconference.org/2016-melbourne/)
at the end of last-year, it was a no-brainer to repurpose the material and finally get this event done.

<div class="center-contents">
<img class="half-image" src="/images/haskell-for-dot-net/altnet.png" />
<img class="half-image" src="/images/haskell-for-dot-net/trello.png" />
</div>

<div class="center-contents">
	<a href="https://sordina.github.io/alt_dot_net_haskell_workshop">
		<em>Workshop Materials</em>
	</a>
</div>

<br />

Organising and running this event was a pretty smooth exercise overall, with
the only real work required being a gathering of volunteers to help assist,
the tweaking of the materials, and obviously running the workshop on the day.
The venue was graciously provided by [SEEK](https://www.seek.com.au/) and we
ran the workshop in their lunch/presentation area - with the crowd of roughly
50 fitting comfortably in a relaxed atmosphere.

<!--more-->

<div class="center-contents">
<img class="half-image" src="/images/haskell-for-dot-net/jim/IMG_2620.JPG" />
<img class="half-image" src="/images/haskell-for-dot-net/jim/IMG_2622.JPG" />
</div>

When chatting to Jim who runs the Alt .Net Melbourne meetup one time, he mentioned
that the members of his community might be interested attending a session of
the Haskell workshop that I'd previously run in 2013. This sounded like a great
idea and we were very keen, but a combination of the fact that the materials
needed updating, and also being very busy at work ensured that we (or at least I)
promptly put the idea on the back-burner!

The Alt .Net crowd are a community of developers who are interested in exploring
"non-mainstream" languages on the .Net runtime. Since there has been a renascence
of functional-programming recently, this obviously also manifested on the Microsoft
ecosystem, with Microsoft languages like F# and F\*, but also other languages
developed by external authors ([List of CLI Languages](https://en.wikipedia.org/wiki/List_of_CLI_languages)).
Haskell isn't a .Net language by any means, but the interest in the
functional-paradigm was great enough that we could fill up a workshop none-the-less.
Jim anticipated about 50 attendees from the Alt .Net meetup.

While running the workshop appealed to me on its own merits, I was particularly
interested in cross-pollinating the communities - seeing if I could get some of
the .Net crowd to mingle with the other functional communities in town through
meetups, etc. While I spruiked a few of the options during the workshop I feel
we won't be able to measure the impact for at least a couple of months.

<div class="center-contents">
<img class="half-image" src="/images/haskell-for-dot-net/20170225_104115.jpg" />
<img class="half-image" src="/images/haskell-for-dot-net/20170225_111724.jpg" />
</div>

We ran the workshop on Saturday - from 10:30am to 5pm - with instructions about
how to install the prerequisites emailed to attendees a few days beforehand.
Usually if you ask a crowd to install something ahead of time you'll be lucky
to get even half of the people doing it. For whatever reason, be it
our communication style or this crowd in particular, we hit about 95% arriving
on the day with everything they needed already set up! This let us get going
on time with a minimum of delays.

While I ran through the preliminary setup chapter and exercises to get people's
fingers moving, our other 10 volunteers
(thanks Andrew, John, Noon, Adel, Jim, Richard, Simon, Krishna, Alexey and Alan!)
patrolled the room seeing if anyone was having any technical or conceptual
difficulties. This was a key component of the success of the workshop the previous
times that it has run. It's very common for people to be reluctant to jump up with
issues in the middle of a session, or for the presenter to be able to pay close
attention at the same time as delivering content, so having helpers to keep an
eye out is critical!

Some of the problems that were encountered during the workshop were inherent, and
some incidental. The most unavoidable problem of all is keeping a large, diverse
group interested with a brisk pace, but also avoid leaving other people behind.
This workshop was no exception, with some of the attendees racing ahead while
others had issues preventing them from making early progress. The approach we
took was to cater as best as possible for the slowest 30% of attendees, with
instructions for how to jump ahead so that the faster members wouldn't get too
bored. The difficulty-curve of the material was also designed to help, so that
as people progressed ahead of the group quickly to begin with, the pace and
novelty of new concepts provided enough friction to help bring the group back
together towards the end.

The amount of new concepts covered during the workshop was actually quite large,
so it was an ambitious task to cover it all during a single day. There were a few
compromises made in order to tackle the challenge. We tried reasonably hard to
introduce each new concept with as few oblique dependencies as possible, but
would sometimes pragmatically mention that something would be explained later,
even though we were using it now. The most obvious example that comes to mind
was the "Num" type-class that appears very early due to numerics, but isn't
explained until the type-classes chapter in the last sections of the workshop.

Another issue that we had was the use of the "pointfree" package as a demonstration
of the Haskell ecosystem. Since I hadn't tested this with the latest version
of Stack it worked for me, but not the attendees. We suggested trying the
"hlint" package instead and while this worked, the servers were running sluggishly
in the morning, so it downloaded slowly and we had to leave the installation
in the background and come back to it later rather than stare at a progress-bar
together. Not a show-stopper, but I should have tested this example properly
before the day.

In order to keep up with the pace of concepts and also empower attendees to
tackle real code after leaving, we explicitly favoured "practical" understanding
and cookbook-style examples and exercises over a rigorous and theoretical
delivery. Weather this is the ideal way to teach Haskell - I'm not sure, but
given the time-constraints it certainly seems like the most effective way to
motivate those who come along. As much as possible I tried to link to external
resources so that people could build their theoretical understanding after
they finished the workshop, but had their practical concerns addressed in-person
so that they wouldn't give up before they could begin their Haskell journeys
in earnest.

<div class="center-contents">
<img class="half-image" src="/images/haskell-for-dot-net/IMG_20170225_155755.jpg" />
<img class="half-image" src="/images/haskell-for-dot-net/jim/IMG_2617.JPG" />
</div>

There are a few ideas floating around about what we might like to do for
workshops in the future... There is some demand for an intermediate/advanced
workshop, but I almost feel that this isn't really a great idea, since the
Haskell ecosystem is just so large that trying to cover all intermediate
concepts would be totally untenable. A better idea may be to pick a single
intermediate topic for a workshop, such as "lenses" or "template-haskell".
For learning the more advanced concepts in Haskell, I feel that the best approach is to
try to tackle some personal projects and seek help, online or at user-groups,
with confusing concepts as they naturally arise. I am interested in running
further beginner workshops, but I'm toying with a change of format -
a totally exercise based workshop with 100 broken programs to debug!

Thanks again to everyone who contributed to putting on the workshop, and
if you want to learn more about Haskell then please consider coming along
to the [Melbourne Haskell User's Group!](https://www.meetup.com/Melbourne-Haskell-Users-Group/)
