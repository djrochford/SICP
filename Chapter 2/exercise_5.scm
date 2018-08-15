;Exercise 2.5.  Show that we can represent pairs of nonnegative integers
; using only numbers and arithmetic operations if we represent the pair a and b as 
;the integer that is the product 2^a * 3^b. 

"This follows from the fundamental theorem of arithmetic. (That's all your going to get from me by way of proof.)"

;Give the corresponding definitions of the procedures cons, car, and cdr.

(define (cons a b) (* (expt 2 a) (expt 3 b)))

(define (division-count n m)
        (define (iter dividend accumulator)
                (define result (/ dividend m))
                (cond ((not (integer? result)) accumulator)
                      ((= result 0) (+ accumulator 1))
                      (else (iter result (+ accumulator 1)))))
        (iter n 0))


(define (car n) (division-count n 2))
(define (cdr n) (division-count n 3))

(define pair (cons 8 22))
(car pair) ; 8
(cdr pair) ; 22