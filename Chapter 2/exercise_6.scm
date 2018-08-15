;In case representing pairs as procedures wasn't mind-boggling enough, 
;consider that, in a language that can manipulate procedures, 
;we can get by without numbers (at least insofar as nonnegative integers are concerned) 
;by implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
        (lambda (f) (lambda (x) (f ((n f) x)))))

;This representation is known as Church numerals, after its inventor, Alonzo Church, 
;the logician who invented the  calculus.

;Define one and two directly (not in terms of zero and add-1). (
;(Hint: Use substitution to evaluate (add-1 zero)). 

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

;Give a direct definition of the addition procedure + (not in terms of repeated application of add-1).

"This was pretty tricky"

(define (add n m)
        (lambda (f) (lambda (x) (f ((n (m f)) x)) )))

"For testing purposes:"

(define (church-to-int n)
        ((n (lambda (x) (+ x 1))) 0))

(= (church-to-int (add-1 zero)) (church-to-int one)) ;#t
(= (church-to-int (add-1 (add-1 zero))) (church-to-int two)) ;#t


(church-to-int (add one two)) ;3
