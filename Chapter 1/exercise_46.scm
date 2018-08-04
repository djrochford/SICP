;Exercise 1.46.  Several of the numerical methods described in this chapter 
;are instances of an extremely general computational strategy known as "iterative improvement". 
;Iterative improvement says that, to compute something, we start with an initial guess for the answer, 
;test if the guess is good enough, and otherwise improve the guess and continue the process 
;using the improved guess as the new guess. Write a procedure `iterative-improve` that takes two procedures as arguments: 
;a method for telling whether a guess is good enough and a method for improving a guess. 
;Iterative-improve should return as its value a procedure that takes a guess as argument and keeps improving the guess 
;until it is good enough. Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 1.3.3 
;in terms of `iterative-improve`.

(define (iterative-improve good-enough? improve)
        (lambda (parameter first-guess)
                (define (try guess)
                        (let ((next (improve guess parameter)))
                             (if (good-enough? guess next)
                                  next
                                 (try next))))
                (try first-guess)))

;------------

(define (average . values)
        (define (average-iter numbers sum n)
                (if (null? numbers)
                    (/ sum n)
                    (average-iter (cdr numbers)
                                  (+ sum (car numbers))
                                  (+ 1 n))))
        (average-iter values 0 0))


(define (sqrt-good-enough? guess next)
        (< (abs (- next guess)) (* guess 0.0001)))

(define (sqrt-improve guess radicand)
        (average guess (/ radicand guess)))

((iterative-improve sqrt-good-enough? sqrt-improve) 10 1.0) ;3.162277665175675

;-------------

(define (fixed-point-good-enough? guess next)
        (< (abs (- guess next)) 0.00001))

(define (fixed-point-improve guess f)
        (f guess))

((iterative-improve fixed-point-good-enough? fixed-point-improve)
 (lambda (y) (average y (/ 10 y)))
 1.0) ; 3.162277660168379



