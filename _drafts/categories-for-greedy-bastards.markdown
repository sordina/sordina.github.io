---
layout: post
title:  "Categories for Greedy Bastards"
categories: blog
---

<p class="attribution">
	<img src="/images/categories-greedy-bastards/sunset.png" class="image fit" />
	<a href="https://www.flickr.com/photos/magnusl3d/">Magnus Larsson</a> -
	<a href="https://www.flickr.com/photos/magnusl3d/6044910841/in/photolist-dmqo1k-3YZgPn-adaKoH-cJaJt7-dxUvSk-dDwcqL-b5jvN6-gtu2M-8CijDG-8CijF5-9GKKWa-9aq6sY-5VE1v5-pgqYaf-6b3H9z-53CH1r-9aq6y1-9aq6vj-8ZXg6f-E9454-9amXga-9amXiz-9amXsZ-9aq6Ju-9amXcP-oMbPWZ-bWWwyo-ddafLx-a9ucd3-byAttU-dqoz7g-dsh314-7nHEhW-cYZaF1-cKGyL5-55S2Ty-pK93nD-nBwAz3-donk6s-dBvmeN-dhmDET-9amXq2-j5NXvx-bDUaHS-62aNkd-626z8v-9L46aG-dz6GRX-nuQFRn-626z9n">"Downtown Vancouver Sunset"</a>
</p>

I've really like the idea of Categories. They boil down one of the most essential
aspects of programming - "composition" - into a concrete interface, and with
their laws, give rise to logically intuitive behaviour. Categories start out
extreemely simply, with only two laws, and two operations, but the subject
queickly becomes highly theoretical through many ideas about sub-categories,
transformations between categories, isomorphic behaviors, etc. Still, just
using the basics is very satisfying!

While categories may be intellectually stimulating, there was a question
asked recently that I thought I would be able to easily answer, but the
more I thought about it, the more I was stumped...

"How can a Category instance in my program save me from writing at least
a little code?"

<!--more-->

## What Are Categories?

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Commutative_diagram_for_morphism.svg/200px-Commutative_diagram_for_morphism.svg.png" />

### Examples

## Why are categories cool?

## How do categories differ from modules?

## Why would a regular programmer be interested in categories?

## The Code Objection...

## The Code Objection Rebuttal

## Example: Refactoring Business Logic


	Examples:
		* Switch from a pure to an impure implementation
		* ...

	Theory - It's a Functor:
		Changing from one category to another

### Classically

### Categorically

Now we come to the punch-line.

Here is an example of what the refactoring would have looked like
if Category instances were used to express the business pipeline.

Imports:

{% highlight haskell %}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE KindSignatures #-}

import Control.Category    ((>>>), Category())
import Control.Arrow       (Kleisli(..))
import Control.Monad.State (runState, modify, State)
{% endhighlight %}

Pure Implementation:

{% highlight haskell %}
main = print (pipeline 1)

pipeline :: Int -> String
pipeline = a >>> b >>> c
  where
  a = (+1)
  b = (+2)
  c = show
{% endhighlight %}

Here - IO:

{% highlight haskell %}
main = (runKleisli pipeline' 2) >>= print

pipeline :: Kleisli IO Int String
pipeline = a >>> b >>> c
  where
  a = Kleisli $ return . (+1)
  b = Kleisli $ \x -> print x >> return (x + 2)
  c = Kleisli $ return . show
{% endhighlight %}

Here - State:

{% highlight haskell %}
main = print (runState (runKleisli pipeline'' 3) 0)

pipeline :: Kleisli (State Int) Int String
pipeline = a >>> b >>> c
  where
  a = tally (+1)
  b = tally (+2)
  c = tally show
  tally f = Kleisli $ \x -> modify (+x) >> return (f x)
{% endhighlight %}

# Links

* <https://gist.github.com/sordina/6f686baf4997da3e3d40>
* <https://en.wikipedia.org/wiki/Category_theory>
* <https://en.wikipedia.org/wiki/Functor>
* <https://en.wikipedia.org/wiki/Natural_transformation>
* <https://en.wikipedia.org/wiki/Commutative_diagram>
* <https://hackage.haskell.org/package/profunctors-5.2/docs/Data-Profunctor.html>
