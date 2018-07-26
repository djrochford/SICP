;Exercise 1.38.  In 1737, the Swiss mathematician Leonhard Euler published a memoir "De Fractionibus Continuis", 
;which included a continued fraction expansion for e - 2, where e is the base of the natural logarithms. 
;In this fraction, the N_i are all 1, and the D_i are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... 
;Write a program that uses your cont-frac procedure from exercise 1.37 to approximate e, based on Euler's expansion.

(define (cont-frac n d k)
        (define (iter i accumulator)
                (if (= i 0)
                    accumulator
                    (iter (- i 1) 
                          (/ (n i) 
                             (+ (d i) 
                                accumulator)))))
        (iter k 0))

(define (numerators i) 1)

(define (denominators i)
        (if (= (remainder (+ i 1) 3) 
               0)
            (* 2 (/ (+ i 1) 3))
            1))

(define e (+ 2
            (cont-frac numerators denominators 10)))

(display e)

;2721/1001 = 2.7182817182...

;True e approx 2.7182818285