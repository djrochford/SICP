;Exercise 2.1.  Define a better version of make-rat that handles both positive and negative arguments. 
;Make-rat should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, 
;and if the rational number is negative, only the numerator is negative.

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (numer x) (car x))

(define (denom x) (cdr x))


"old make-rat"

(define (gcd a b)
        (if (= b 0)
            a
            (gcd b (remainder a b))))

(define (old-make-rat n d)
        (let ((g (gcd n d)))
             (cons (/ n g) (/ d g))))

"better make-rat"
(define (make-rat n d)
        (if (< (* n d) 0)
            (old-make-rat (* -1 (abs n)) (abs d))
            (old-make-rat (abs n) (abs d))))


(define two-thirds-a (make-rat 2 3))

(print-rat two-thirds-a); prints "2/3"

(define two-thirds-b (make-rat -2 -3))

(print-rat two-thirds-b) ;prints "2/3"

(define negative-two-thirds-a (make-rat -2 3))

(print-rat negative-two-thirds-a); prints "-2/3"

(define negative-two-thirds-b (make-rat 2 -3))

(print-rat negative-two-thirds-b) ;prints "-2/3"