;Exercise 2.4.  Here is an alternative procedural representation of pairs. 

(define (cons x y)
        (lambda (m) (m x y)))

(define (car z)
        (z (lambda (p q) p)))

;For this representation, verify that (car (cons x y)) yields x for any objects x and y.
;(Hint: To verify that this works, make use of the substitution model of section 1.1.5.)

(car (cons x  y))
(car (lambda (m) (m x y)))
((lambda (m) (m x y)) (lambda (p q) p))
((lambda (p q) p) x y)
x

;What is the corresponding definition of cdr? 

(define (cdr z)
        (z (lambda (p q) q)))