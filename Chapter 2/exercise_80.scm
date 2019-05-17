;Exercise 2.80.  Define a generic predicate `=zero?` that tests if its 
;argument is zero, and install it in the generic arithmetic package. This
;operation should work for ordinary numbers, rational numbers, and complex numbers.

"The generic procedure:"

(define (=zero? x)
        (apply-generic '=zero x))

"The procedures to install in the ordinary, rational and complex packages, respectively:"

(put '=zero?
     '(scheme-number)
     (lambda (x) (= x 0)))

(put '=zero?
     '(rational)
     (lambda (x) (= (numer x) 0)))

(put '=zero?
    '(complex)
    (lambda (x) (and (= (real-part x) 0)
                     (= (imag-part x) 0))))