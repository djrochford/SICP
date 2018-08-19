;Exercise 2.8.  Using reasoning analogous to Alyssa's, 
;describe how the difference of two intervals may be computed. 

"The minimum value of interval A minus interval B is the lower bound of A minues the upper bound of B.
The maximum value is the upper bound of A minus the lower bound of B."

;Define a corresponding subtraction procedure, called sub-interval.

(define (sub-interval x y)
        (make-interval (- (lower-bound x) (upper-bound y))
                       (- (upper-bound x) (lower-bound y))))