;Exercise 3.52.  Consider the sequence of expressions

(define sum 0)
(define (accum x)
  		(set! sum (+ x sum))
	    sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
(stream-ref y 7)
(display-stream z)

;What is the value of sum after each of the above expressions is evaluated?

"The first two are easy enough:
0
0

Let's evaluate this expression:"

(define seq (stream-map accum (stream-enumerate-interval 1 20)))

(stream-enumerate-interval 1 20) "is equal to"

(cons 1 (delay stream-enumerate-interval 2 20))

"and"
(stream-map accum (cons 1 (delay stream-enumerate 2 20))) "equals"

(cons-stream (accum 1) (stream-map accum (stream-enumerate-interval 2 20))) "equals"
(cons (accum 1) (delay (stream-map accum (stream-enumerate-interval 2 20)))) 
"which results in one invocation of `accum`, with argument `1`, and so after this express
is evalues, sum = 1"

"Now"
(define y (stream-filter even? seq))

"We'll evaluate:"
(stream-filter even? seq)
(stream-filter even? (cons 1 (delay (stream-map accum (stream-enumerate-interval 2 20)))))
(stream-filter even? (stream-map accum (stream-enumerate-interval 2 20)))
(stream-filter even? (stream-map accum (cons 2 (delay (stream-enumerate-interval 3 20)))))
(stream-filter even? (cons (accum 2) (delay (stream-map accum (stream-enumerate-interval 3 20)))))
"`(accum 2)` triggered here, so sum is now 3"
(stream-filter even? (cons 3 (delay (stream-map accum (stream-enumerate-interval 3 20)))))
(stream-filter even? (stream-map accum (stream-enumerate-interval 3 20)))
(stream-filter even? (stream-map accum (cons 3 (delay (stream-enumerate-interval 4 20)))))
(stream-filter even? (cons (accum 3) (delay (stream-map accum (stream-enumerate-interval 4 20)))))
"`(accum 3)` triggered here, so sum is now `6`"
(stream-filter even? (cons 6 (delay (stream-map accum (stream-enumerate-interval 4 20)))))
(cons-stream 6 (stream-filter even? (stream-map accum (stream-enumerate-interval 4 20))))
(cons 6 (delay (stream-filter even? (stream-map accume (stream-enumerate-interval 4 20)))))


"So after"
(define y (stream-filter even? seq))
"executes, sum = 6"

"Similarly,"
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
"will keep working through `seq` until it gets to a multiple of 5. We can tell when that will be.
seq(1) = 1, and seq(n) = seq(n - 1) + n, so the the values of `seq` that will be processed before
`z` delays will be 1, 3, 6, 10. Getting to `10` will involve processing `accum 4`, and thus, afterwards,
`sum` will equal `10`.
Getting to `10` would *also* involve evaluating `accum` of `1`, `2` and `3`, except that memoisation
means that those values of `seq` are available without any futher processing, given that those
values have been calculated previously.

Now"
(stream-ref y 7)
"Involves processing `seq` until we get to the seventh even number -- i.e., going through:
1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105, 120
which involves evaluating the `accum` of all nautral numbers from 2 to 15. With memoisation,
and given the value of `sum` before the executino of `(stream-ref y 7)`, that sum will equal
the sum of numbers from 2 to 15, which is 120. 
"

"As for"
(display-stream z)
"the execution of that will force the evaluation of every member of `seq`, which if you do the
math makes `sum` equal to 210.
"
;What is the printed response to evaluating the `stream-ref` and `display-stream`
;expressions?
"120 and 10, 15, 45, 55, 105, 120"

;Would these responses differ if we had implemented `(delay <exp>)` simply as 
;`(lambda () <exp>)` without using the optimization provided by `memo-proc`? Explain.

"They most definitely would have. Without memoisation, there would be many extra 
invocations of `accum`, each of which would mutate `sum`. The overall effect would
be to make the values of `seq` depend on the history of executions -- exactly
the result we were trying to avoid with streams."