;Exercise 2.88.  Extend the polynomial system to include subtraction of polynomials.
;(Hint: You may find it helpful to define a generic negation operation.)

(define (negate number) (apply-generic 'negate number))

"Installing in scheme number, rational and complex packages:"

(put 'negate '(scheme-number) (lambda (x) (make-scheme-number -x)))

(put 'negate '(rational) (lambda (q) (make-rational (- (numer q)) (denom q))))

(put 'negate '(complex) (lambda (z) (make-from-real-imag (- (real-part z) (imag-part z)))))

"Now to negate polynomials:"

(define (negate-terms term-list)
        (if (=zero term-list)
            (term-list)
            (cons (negate (first-term term-list)) 
                  (negate-terms (rest-terms term-list)))))

(put 'negate '(polynomial) (lambda (p) (make-polynomial (variable p) (negate-terms (term-list p))))

"Now subtraction"

(put 'sub '(polynomial polynomial) (lambda (p1 p2) (add p1 (negate p2))))