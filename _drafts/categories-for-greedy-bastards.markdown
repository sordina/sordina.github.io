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

* What are categories?
* Why are categories cool?
* How do categories differ from modules?
* Why would a regular programmer be interested in categories?
* The Code Objection...
* The Code Objection Rebuttal
* Example: How can categories actually _save someone code_ in real life?

Read on!

<!--more-->

Refactoring!

Classical Example:

Categorical Example:

{% highlight haskell %}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE KindSignatures #-}

import Control.Category    ((>>>), Category())
import Control.Arrow       (Kleisli(..))
import Control.Monad.State (runState, modify, State)

-- Our composition is abstract
--
gen :: forall (cat :: * -> * -> *) a b c b1.
       Category cat =>
       cat a b -> cat b b1 -> cat b1 c -> cat a c
gen a b c = a >>> b >>> c

-- Our implementation, and implementation context can be swapped out
--
-- Here - Pure:
--
pipeline :: Int -> String
pipeline = gen a b c
  where
  a = (+1)
  b = (+2)
  c = show

-- Here - IO:
--
pipeline' :: Kleisli IO Int String
pipeline' = gen a b c
  where
  a = Kleisli $ return . (+1)
  b = Kleisli $ \x -> print x >> return (x + 2)
  c = Kleisli $ return . show

-- Here - State:
--
pipeline'' :: Kleisli (State Int) Int String
pipeline'' = gen a b c
  where
  a = tally (+1)
  b = tally (+2)
  c = tally show
  tally f = Kleisli $ \x -> modify (+x) >> return (f x)

-- Execution differs:
--
main :: IO ()
main = do
  return     (pipeline   1)                         >>= print
  (runKleisli pipeline'  2)                         >>= print
  return     (runState (runKleisli pipeline'' 3) 0) >>= print


{% endhighlight %}


Categories for Greedy Bastards

	Functor:
		Changing from one category to another

	Examples:
		* Switch from a pure to an impure implementation
		* ...

<!--more-->

Links:

* <https://gist.github.com/sordina/6f686baf4997da3e3d40>
* <https://en.wikipedia.org/wiki/Category_theory>
* <https://en.wikipedia.org/wiki/Natural_transformation>
* <https://en.wikipedia.org/wiki/Commutative_diagram>
