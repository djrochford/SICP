;Exercise 3.33.  Using primitive multiplier, adder, and constant constraints, define a procedure `averager`
;that takes three connectors a, b, and c as inputs and establishes the constraint that the value of c is
;the average of the values of a and b.

(define (averager a b c)
		(define (process-new-value)
				(cond ((and (has-value? a) (has-value? b))
					   (set-value! c (/ (+ a b) 2))
					   me)
					  ((and (has-value? a) (has-value c?))
					   (set-value! b (- (* 2 c) a))
					   me)
					  ((and (has-value? b) (has-value? c))
					   (set-value! a (- (* 2 c) b))
					   me)))
		(define (process-forget-value)
				(forget-value! a me)
				(forget-value! b me)
				(forget-value! c me)
			    (process-new-value))
		(define (me request)
				(cond ((eq? request 'I-have-a-value)
				       (process-new-value))
					  ((eq? request 'I-lost-my-value)
					   (process-forget-value))
					  (else (error "Unknown request -- AVERAGER" request))))
		(connect a me)
		(connect b me)
		(connect c me)
	    me)
