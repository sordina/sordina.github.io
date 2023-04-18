---
layout: post
title: "What is Software Engineering?"
categories: blog
reddit: "https://www.reddit.com/r/sordina/comments/xth3qa/what_is_software_engineering_bows_and_arrows/"
---

You might think that the term engineering is derived from engine.

<p class="attribution">
	<img src="/images/software-engineering/siphon.jpg" class="image fit" />
	<a href="https://flic.kr/ps/3YEVGj">Marko Lazarevic</a> -
	<a href="https://craftcoffeespot.com/">"Water being Heated in Siphon" - CraftCoffeeSpot.com</a>
</p>

<!--more-->

I was surprised to learn that instead both terms share the common root "ingenium".

> The term engineering is derived from the Latin ingenium, meaning "cleverness" and ingeniare, meaning "to contrive, devise".
>
> *[Wikipedia](https://en.wikipedia.org/wiki/Engineering#cite_note-2)*

Before learning this I'd been dwelling on the metaphor. If engineers build
engines, then what are the engines of the different engineering disciplines? In
some circumstances the answer is more obvious than others. Mechanical,
chemical, these are quite direct. What about software? What is the engine of
software engineering?

Could it be...

> Our engine is the application that we build. It powers an
undertaking such as a business or community by performing tasks autonomously.

It feels right, but maybe this is much too simplistic.


### What is an engine?

The most obvious example of an engine that surely nobody could disagree with
is the motor in your car. You know this is an engine so intuitively that it
doesn't require thought. Abstractly, what does it do? It powers the car and
makes it move along with some trade-offs -

* It is large
* It is heavy
* It is cumbersome
* It is expensive
* It is loud
* It degrades and needs maintenance
* It needs lubrication
* It consumes fuel

Of all these items, the fuel is the most interesting. Fuel rebalances the
trad-offs. It moves them from the physical engine in to liquid commodity form.
Not only does it reduce every downside of the engine, but is also fungible
between many different engines. Like feed for working animals.

So...

> Our engine is our application, and its fuel is the electricity that powers
> it and the data that feeds it.


### What is a metaphor?

A simile draws a comparison. A metaphor asks you to believe. When thinking in
similes you must translate back and forth, but when thinking in metaphors you
let go of the original conception and think about something new. Once you're
done day-dreaming you can collect your notes and see if they revealed something
artistic or maybe something new.

Simply stating our found metaphor is just the start. Where it becomes useful is
to broaden it and see where it leads. Once we have stretched it to the point where
it is saying something surprising it may have led us to a new idea that can be
examined.

So, we build our application and feed it fuel to do business things, then when
it degrades we maintain it, or replace it when it becomes obsolete or defunct.
Well... This doesn't really seem like it fits my experience of writing software.

Firstly, writing software is highly adaptive and incremental. This is not just
incidental. In all but the rarest situations this is its primary mode of operation.
Secondly, and related, while electricity and data could be considered fuel, I think
these are more akin to the actual movement that the engine powers - moving
electrons strategically and plowing through data, adapting and growing over time.

What then are the engine and the fuel in this new metaphor?

> Our engine is our architecture, and its fuel is code changes.

Adaptation and Growth is Movement.

> As you add more fuel features and improvements are developed.


### Code is Fuel or The Commodity of Code

As a sponsor of a software-engineering effort you hope that you can buy code
like you would buy fuel. Cheap, available, and reliable. I great deal of the
conceit of modern software development is pretending that this is the case.
On its own it is not. Some processes like budgeting, agile, scoping, etc. may
help but they aren't a solution of themselves, just optimisations.

*What would real commodification of code look like?*

Here is a vision:

> A product exists in its current state. A team of competent but not outstanding
> developers is assembled or grown. They create new features predictably where
> the rate of delivery is proportional to the size of the team.


### Code vs. *Code*

What then is the distinction between architectural code and feature code?

Architectural code is code that enables the first feature of its class,
combined with the first feature. This could be thought of like a
framework or skeleton. Copy-and-paste coding is not a dirty word. Why
shouldn't a feature be copied and pasted to unsurface a new similar feature?
Enough iterations of this and it can evolve into a data-driven version
where no new code needs to be written at all to "deliver" such a feature.

One of the best examples of this is the plugin architecture. Think about
VSTs from the audio world. Whole communities of developers emerge once the
architecture is in place. Delivery of new VSTs is completely parallel
and requires minimal coordination.


### Meaningful Styles of Contribution

Does this mean that there are first-class and second-class developers?
A dystopian world in which "architects" are the real engineers and
"fuel" coders are just grunts? Well, there does seem to be a concrete
distinction between these two undertakings that can't be denied, but
it is wrong to infer a hierarchy. The competency of the engineer can
be measured in how they elevate the artistry of the feature developer,
and the competency of the feature developer is measured in what they
bring to users.

It's worth remembering that feature development can be done without
architecture but architecture without any features emerging is useless outside
of research. The line is blurrier than I have implied. Feature developers will
wear the architecture hat implicitly, and architects often envision or even
build the first features. I'm suggesting that the distinction of these roles is
very useful and can allow one of the most sought after practises in the
software industry - Development at Scale.


### What Does This Mean? Or... Sounds Great. How do I do That?

* Facilitate explicit "fan-out" patterns in your applications
* Evolve fan-out feature classes into data-driven instances
* Build plugin systems that allow expressive plugin authorship
* Collaborate with feature authors if you're taking the architect role
* Ask yourself "what do I want?" ultimately, envision the perfect evolution of your application
* How abstract is too abstract? Do you just want to end up designing a programming language?

Just a few thoughts.

