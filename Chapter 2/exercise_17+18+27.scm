;Exercise 2.17.  Define a procedure `last-pair` that returns the list that contains 
;only the last element of a given (nonempty) list:

(define (last-pair chain)
        (if (null? (cdr chain))
            chain
            (last-pair (cdr chain))))

(last-pair (list 23 72 149 34)); (34)

;Exercise 2.18.  Define a procedure `reverse` that takes a list as argument and returns 
;a list of the same elements in reverse order,

(define (reverse chain)
        (define (reverse-iter anti-chain chain)
                (if (null? chain)
                    anti-chain
                    (reverse-iter (cons (car chain) anti-chain) (cdr chain))))
        (reverse-iter () chain))

(reverse (list 1 4 9 16 25)) ;(25 16 9 4 1)


;Exercise 2.27.  Modify your reverse procedure of exercise 2.18 
;to produce a deep-reverse procedure that takes a list as argument 
;and returns as its value the list with its elements 
;reversed and with all sublists deep-reversed as well.

(define (deep-reverse chain)
        (define (reverse-iter anti-chain chain)
                (cond ((null? chain) anti-chain)
                      ((not (pair? chain)) chain)
                      (else (reverse-iter (cons (reverse-iter () (car chain)) anti-chain) (cdr chain)))))
        (reverse-iter () chain))

(define x (list (list 1 2) (list 3 4)))

x ;((1 2) (3 4))

(reverse x) ;((3 4) (1 2))

(deep-reverse x) ;((4 3) (2 1))