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
Fib(3), plus an extra addition, so that's 4. In general the Fib(n) requires calculating Fib(n-1)
and Fib(n-2), and one more addition.

Let FibAdd(n) be the number of additions required to calculate Fib(n) without memoisation. In general:
	FibAdd(n) = FibAdd(n-1) + FibAdd(n-2) + 1
Obviously, FibAdd(n) grows like Fib(n), which satisfied almost the same recurrent formula. And we know
from exercise 1.13 that Fib(n) has exponential growth. So FibAdd(n) grows exponentially.
"