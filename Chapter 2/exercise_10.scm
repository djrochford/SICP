;Exercise 2.10.  Ben Bitdiddle, an expert systems programmer, 
;looks over Alyssa's shoulder and comments that it is not clear what it means to divide by an interval that spans zero. 
;Modify Alyssa's code to check for this condition and to signal an error if it occurs.

(define (div-interval x y)
        (if (and (not (> (lower-bound y) 0)) ; `not >`, rather than `<`, to take care of cases where the upper or lower bound equals 0
                 (not (< (upper-bound y) 0)))
            (error "Divisor spans 0 -- DIV-INTERVAL")
            (mul-interval x 
                          (make-interval (/ 1.0 (upper-bound y))
                                         (/ 1.0 (lower-bound y))))))