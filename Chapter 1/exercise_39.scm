;Exercise 1.39.  A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:

;tan x = x / (1 - (x^2 / (3 - (x^2 / (5 - ... )))))

;where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the tangent function 
;based on Lambert's formula. k specifies the number of terms to compute, as in exercise 1.37.

(define (cont-frac n d k)
        (define (iter i accumulator)
                (if (= i 0)
                    accumulator
                    (iter (- i 1) 
                          (/ (n i) 
                             (+ (d i) 
                                accumulator)))))
        (iter k 0))

(define (tan-cf x k)
        (define (numerators i)
                (if (= i 1)
                    x
                    (* x x -1)))
        (define (denominators i)
                (- (* 2 i) 1))
        (cont-frac numerators denominators k))

;pi/4 is approx 0.78539816339
(tan-cf 0.78539816339 10)
;Value: .9999999999851034