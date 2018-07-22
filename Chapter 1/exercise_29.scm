;Simpson's Rule is a more accurate method of numerical integration than the method illustrated above. 
;Using Simpson's Rule, the integral of a function f between a and b is approximated as

;h/3 (y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 ... + 2y_(n-2) + 4y_(n-1) + y_n)

;where h = (b - a)/n, for some even integer n, and y_k = f(a + kh). 
;(Increasing n increases the accuracy of the approximation.) Define a procedure that takes as arguments f, a, b, 
;and n and returns the value of the integral, computed using Simpson's Rule. 
;Use your procedure to integrate `cube` between 0 and 1 (with n = 100 and n = 1000), 
;and compare the results to those of the `integral` procedure shown above.

(define (cube x) (* x x x))

(define (Simpson f a b n)
        (define h (/ (- b a) n))
        (define (y k) (f (+ a (* k h))))
        (define (coefficient k)
                (cond ((or (= k 0) (= k n)) 1)
                      ((odd? k) 4)
                      (else 2)))
        (define (Simpson-iter k)
                (if (= k 0)
                    (y 0)
                    (+ (* (coefficient k)
                          (y k))
                       (Simpson-iter (- k 1)))))
        (* (/ h 3)
           (Simpson-iter n)))

(Simpson cube 0 1 100) ; 1/4

(Simpson cube 0 1 1000) ; 1/4

"For comaprison:
(integral cube 0 1 0.01) is .24998750000000042
(integral cube 0 1 0.001) is .249999875000001"
