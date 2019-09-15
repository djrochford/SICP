;Exercise 3.57.  How many additions are performed when we compute the nth Fibonacci number using
;the definition of `fibs` based on the `add-streams` procedure?



"Here, for reference, is the `fibs` procedure:"

(define fibs
  		(cons-stream 0
               		(cons-stream 1
                            	 (add-streams (stream-cdr fibs)
                                              fibs))))

"When n = 1 or 2, no additions are performed. With memoisation, n > 2 involves 
n - 2 additions -- each increment of n takes one more addition to calculate."


;Show that the number of additions would be exponentially greater if we had implemented `(delay <exp>)`
;simply as `(lambda () <exp>)`, without using the optimization provided by the `memo-proc` procedure
;described in section 3.5.1.

"Without memoisation, calculating Fib(n) when n = 3 would require 1 addition -- same as before.
But to calculate Fib(n) when n = 4, you could need to again calcualte n = 3, then do one more addition -- that's
a total of two additions. And then to calculate Fib(n) for n = 5 requires requires re-calculating Fib(4)
Fib(3), plus an extra addition, so that's 4. In general calculating Fib(n) requires all the additions required
to calculate Fib(n-1), Fib(n-2), ... Fib(3), and one more.

Let FibAdd(n) be the number of additions required to calculate Fib(n). Here is a proof by induction that
FibAdd(n) = 2^(n-3) for n>2.

Base case: we know already that FibAdd(3) = 1 = 2^(3-3), so the result is true for n = 3.

Inductive step. Suppose it is true for all values of n less than some aribitrary value k. We know that:
FibAdd(k) = FibAdd(k-1) + FibAdd(k-2) + ... + FibAdd(3) + 1
By the inductive hypothesis:
FibAdd(k) = 2^(k-4) + 2^(k-5) + ... + 1 + 1 = 2(k)

= 2 (2 ^(k-5) + 2^(k-6) + ... + 1)
= 2 * FibAdd(k-4)
= 2 * 2^(k-4)
= 2 ^ (k-3)

That proves the result.

Thus, the number of additions grows exponentially with n, without memoisation.
"