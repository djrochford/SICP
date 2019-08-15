;Exercise 3.34.  Louis Reasoner wants to build a squarer, a constraint device with two terminals such that the value
;of connector `b` on the second terminal will always be the square of the value `a` on the first terminal. He
;proposes the following simple device made from a multiplier:

(define (squarer a b)
  		(multiplier a a b))

;There is a serious flaw in this idea. Explain.

"Take a look at how `process-new-value` in `multiplier` is defined:"
(define (process-new-value)
		(cond ((or (and (has-value? m1) (= (get-value m1) 0))
	   		   	   (and (has-value? m2) (= (get-value m2) 0)))
				   (set-value! product 0 me))
				  ((and (has-value? m1) (has-value? m2))
				   (set-value! product
	           			   (* (get-value m1) (get-value m2))
	           			   me))
				  ((and (has-value? product) (has-value? m1))
				   (set-value! m2	
	           			   (/ (get-value product) (get-value m1))
	           			   me))
				  ((and (has-value? product) (has-value? m2))
				   (set-value! m1
	           				   (/ (get-value product) (get-value m2))
	           				   me))))

"The last two conditions will never execute in `squarer`, if it is defined as above.
Why not? For those conditions to be reached, it muse be the case that at least one
of `m1` and `m2` have no value. But, in `squarer`, `m1` and `m2` bothe equal `a`.
So if one of `m1`, `m2` have no value, then they both have no value, in which case
the last two conditions will not be met.

Those last two conditions are the only places in `process-new-value` where either of `m1`
or `m2` are set. So the fact that neither will ever run in `squarer` means that `squarer`
has no mechanism for setting `a`. The upshot is that `squarer` will fail to change `a`
when `b` changes, making the values out of sync.

What `squarer`, defined this way, is failing to take into account is that knowing `b` by
itself is sufficient for setting `a`. As written, `squarer` will always act like there
is insufficient information to set `a`, whenever the question arises."