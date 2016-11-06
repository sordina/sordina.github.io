---
layout: post
title:  "Uniqhash Machines Implementation"
categories: blog
reddit: "https://www.reddit.com/r/sordina/comments/5ba088/uniqhash_machines_implementation_bows_and_arrows/"
---

<!--
digraph {
  rankdir=LR;
  filename -> name_and_digest;
  filename -> read_if_exists -> digest -> name_and_digest;
  name_and_digest -> cache_delay_one -> if_name_lookup_not_digest;
  name_and_digest -> if_name_lookup_not_digest;
  if_name_lookup_not_digest -> emit_filename;
}
-->


<p class="attribution">
	<img src="/images/uniqhash-machines/graph.png" class="image fit" />
</p>

I have a little program that I implement with various streaming frameworks in order to
test out their capabilities with a range of orthogonal requirements. I call this
program ["Uniqhash"](https://github.com/sordina/uniqhash).

Ostensibly, the program takes in lines of filepaths on STDIN,
and when it reads a new filepath, if the contents are different
from the last time that it read the filepath, then it should
output the filepath to STDOUT.

A use-case for this could be a Unix-pipeline composable piece
of something like [Guard](https://github.com/guard/guard). With
the file-system event listener outputting filepaths, Uniqhash
checking that the files have changed, and a STDIN responding
script performing an action (such as "refresh-browser"). This
isn't purely hypothetical either. I use this workflow with the
three pieces being "Commando", "Uniqhash", and "Conscript"
regularly.

	$ commando -j -p cat | grep --line-buffered -v git \
	                     | uniqhash \
	                     | tee /dev/stderr \
	                     | conscript chromereload uniqhash_machines

The black-box requirements for Uniqhash are simple enough, but there
are several other requirements that I have come up with that
seem to stump whatever implementation I have attempted to design
in the past:

* External Composability (Unix Pipelines)
* Internal Interface Composability (Ideally Categorical)
* Internal Sub-Component Composability (Requiring Least Possible Context)
* Safety (Resource Safety)
* Safety (Exception Handling)
* Idiomatic use of Components
* Computational Lattice Construction (Constructed as a Computation Graph)
* Effect Interleaving Capability Where Required
* Lock-Step Evaluation of Divergent Paths in Computation Graph
* Execution Speed

If these requirements are met then they facilitate testing, sub-component
reuse, expressiveness of implementation, etc. Unfortunately it has been
easy to satisfy many, but not all of these with any particular single attack...
Until now!

* [Lazy-IO](http://stackoverflow.com/questions/5892653/whats-so-bad-about-lazy-i-o)
  met all requirements except for Safety and Idiomaticity, with
  exceptions triggering problems in unexpected locations, resource usage
  being tricky to get right, and several calls to `unsafeInterleaveIO`
  scattered throughout the implementation.
* [Conduit](https://github.com/snoyberg/conduit)
  and
  [Pipes](https://github.com/Gabriel439/Haskell-Pipes-Library#pipes-v420)
  both provide fantastic facilities for streaming, but they
  fall down when composing together components in a graph - requiring
  either large blocks of low-level plumbing code without much
  component reuse, or losing the Lock-Step Evaluation capability
  and requiring regaining divergent association through the use
  of `Eithers` (and possibly tracking IDs to boot).
* [Machines](https://github.com/ekmett/machines/#machines)
  seemed very promising, fulfilling all needs, except for not _quite_
  being able to express graphs. It could express tributary trees
  of computation, but causing a source to diverge, then rejoin in
  lockstep was not possible with the built in components.
  The [Mealy-Machine](https://github.com/ekmett/machines/blob/master/src/Data/Machine/Mealy.hs#L49)
  seemed promising, and could solve the problem in a pure context, but
  then general effects were unable to be executed as the pipeline processed
  data... Still, it was so close, that I decided to try creating an
  upgraded Mealy-Machine - the [MealyM](https://github.com/sordina/uniqhash/blob/master/Data/Machine/MealyM.hs#L18).

```haskell
newtype MealyM m a b = MealyM { runMealyM :: a -> m (b, MealyM m a b) }
```

This has finally solved every one of the requirements that I've come up with
to-date.

* The top-level program can be constructed
* The program can be exposed at the library level as a `Process` Machine
* This can be composed categorically with other libraries
* The sub-graphs of the implementation can also be reused
* The sub-graphs only demand as powerful a context as is required.
* `hashPipe` requires IO, but `cache` is pure...
* Resources are handled safely
* Execution of the graph occurs in lock-step, requiring no special code
  to converge previously diverged paths
* `MealyM` is idiomatic, fitting into the existing `Machines` ecosystem
* Everything runs acceptably quickly

<img src="/images/uniqhash-machines/machines-code.png"
  style="display: block; border: 1px solid blue; margin: 1em auto;" />

I've had some discussions on both the [machines](https://github.com/ekmett/machines/issues/51)
and [concurrent-machines](https://github.com/acowley/concurrent-machines/issues/3)
repositories about what I've been trying to achieve and will hopefully
have a pull request into both of these projects soon to share what
I've made.

As it turns out `MealyM` is [`MStreamF`](https://github.com/ivanperez-keera/dunai/blob/develop/src/Data/MonadicStreamFunction/Core.hs#L35)
from `dunai`, which [has a paper](http://eprints.nottingham.ac.uk/36159/1/paper.pdf)
about it.

Whaddaya know!
