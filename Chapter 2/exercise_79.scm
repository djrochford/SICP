;Exercise 2.79.  Define a generic equality predicate `equ?` that tests the 
;equality of two numbers, and install it in the generic arithmetic package.
;This operation should work for ordinary numbers, rational numbers, and
;complex numbers.

"The generic procedure"
(define (equ? x y) (apply-generic 'equ? x y))

"These should appear in the intallation procedures for ordinary, rational and complex
numbers, respectively:"

(put 'equ 
     '(scheme-number scheme-number) 
     =)

(put 'equ
     '(rational rational)
     (lambda (x y) (= (/ (numer x) (denom x))
                      (/ (number y (denom y))))))

(put 'equ
      '(complex complex)
      (lambda (x y) (and (= (real-part x) (real-part y))
                         (= (imag-part x) (imag-part y)))))
