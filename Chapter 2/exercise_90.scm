;Exercise 2.90.  Suppose we want to have a polynomial system that is efficient
;for both sparse and dense polynomials. One way to do this is to allow both kinds
;of term-list representations in our system. The situation is analogous to the
;complex-number example of section 2.4, where we allowed both rectangular and polar
;representations. To do this we must distinguish different types of term lists and
;make the operations on term lists generic. Redesign the polynomial system to implement
;this generalization. This is a major effort, not a local change.

"I won't go through the whole exercise, but the idea in outline is: all of the polynomial
methods both in the book and described in exercise 2.89 should be installed in their own packages,
and each method needs to have a generic version, that lives in a generic polynomial packages,
one level of abstraction up from the poly-dense and poly-sparse packages. The generic procedures
will invoke `apply-generic`."