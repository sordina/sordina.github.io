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

From [“All Concepts are Kan Extensions (PDF)”](http://www.math.harvard.edu/theses/senior/lehner/lehner.pdf):

> When Samuel Eilenberg and Saunders MacLane first introduced the concept of a
category in 1942, some mathematicians derided it as “general abstract nonsense” [7].
Categories seemed so theoretical that many doubted they would lend new insights
in any field. Now, however, many category theorists view the “general abstract
nonsense” phrase as a challenge, and have even co-opted the term for their own uses.
They have demonstrated the tremendous power of and universal insights provided
by category theory.

> Category theory offers “a bird’s eye view of mathematics. From high in the
sky, details become invisible, but you can see patterns that were impossible to detect
from ground level” [5]. Category theory provides a mechanism to describe similarities
within and between different branches of mathematics. Advances or constructions
in one branch can be translated into other branches. Category theory focuses on the
abstract structure of objects rather than on the elements of those objects.

### Examples from Programming

Theory aside, `Category` could be considered an interface, or as in Haskell,
a type-class:

{% highlight haskell %}
class Category cat where
  id  :: cat a a
  (.) :: cat b c -> cat a b -> cat a c
{% endhighlight %}

Implementations provide identity, and composition, as well as satisfying
the following laws:

* Associativity: `(f . g) . h = f . (g . h)`
* Left Unit: `id . f = f`
* Right Unit: `f . id = f`


## Why are categories cool?

## Why would a regular programmer be interested in categories?

## The Code Objection...

## The Code Objection Rebuttal

## Example: Refactoring Business Logic

<!-- 
Theory - It's a Functor:
  Changing from one category to another
-->

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

## Complications

Funnily enough, when I presented this talk to the same group who had
raised the inspirational question -

> "How can a Category instance in my program save me from writing at least
  a little code?"

... they asked another -

>  "does this form of abstraction provide much over a scoped definition of composition?"

This is also a good one, but at least I have something of an answer ready
in response.

I believe that, scoping and refifinition boilerplate aside, the advantage that
using category instances gives you over simply redefining a custom composition
operator is the fact that your composition is coherent. This has to be the case
becuase of the very fact that you are using a `Category` where composition
is meaningful and correct by definition.

# Links

* <https://gist.github.com/sordina/6f686baf4997da3e3d40>
* <https://en.wikipedia.org/wiki/Category_theory>
* <https://en.wikipedia.org/wiki/Functor>
* <https://en.wikipedia.org/wiki/Natural_transformation>
* <https://en.wikipedia.org/wiki/Commutative_diagram>
* <https://hackage.haskell.org/package/profunctors-5.2/docs/Data-Profunctor.html>
* <https://ncatlab.org/nlab/show/category>
