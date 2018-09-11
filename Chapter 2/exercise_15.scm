;Exercise 2.15.  Eva Lu Ator, another user, has also noticed the different intervals 
;computed by different but algebraically equivalent expressions. 
;She says that a formula to compute with intervals using Alyssa's system will produce tighter error bounds 
;if it can be written in such a form that no variable that represents an uncertain number is repeated. 
;Thus, she says, par2 is a ``better'' program for parallel resistances than par1. Is she right? Why?

"Eva is indeed right. The fundamental problem is that, in our program, there is no way to distinguish between two intervals
that represent the same value and two intervals that represent values that can vary independently, though our knowledge of them
is similarly hazy -- i.e., is within the same lower and upper bound. Effectively, every reference to an interval is
treated as being able to vary independently of every other reference to an interval, even if the references are
via the same expression.

One consequence of this is that calculations involving two intervals that
are supposed to represent the same value are more uncertain than they have to be. 
Calculations involving two intervals representing the same value are in fact less uncertain than two intervals with the same
upper and lower bound (just consider A/A, for example). But, because all references are treated as varying independently,
our program calculates bigger errors than it should, when the calculation involves two references to the same value."