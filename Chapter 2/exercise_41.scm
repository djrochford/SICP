;Exercise 2.41.  Write a procedure to find all ordered triples 
;of distinct positive integers i, j, and k less than or equal to 
;a given integer n that sum to a given integer s.



(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate m n)
        (if (> m n)
            ()
            (cons m (enumerate (+ m 1) n))))

(define (flatmap proc seq)
        (accumulate append () (map proc seq)))

(define (enumerate-triples n)
        (flatmap (lambda (k) (flatmap (lambda (j) (map (lambda (i) (list i j k))
                                                       (enumerate 1 n)))
                                      (enumerate 1 n)))
                 (enumerate 1 n)))

(enumerate-triples 5)
;((1 1 1) (2 1 1) (3 1 1) (4 1 1) (5 1 1) 
; (1 2 1) (2 2 1) (3 2 1) (4 2 1) (5 2 1) 
; (1 3 1) (2 3 1) (3 3 1) (4 3 1) (5 3 1) 
; (1 4 1) (2 4 1) (3 4 1) (4 4 1) (5 4 1)
; (1 5 1) (2 5 1) (3 5 1) (4 5 1) (5 5 1) 
; (1 1 2) (2 1 2) (3 1 2) (4 1 2) (5 1 2) 
; (1 2 2) (2 2 2) (3 2 2) (4 2 2) (5 2 2) 
; (1 3 2) (2 3 2) (3 3 2) (4 3 2) (5 3 2)
; (1 4 2) (2 4 2) (3 4 2) (4 4 2) (5 4 2) 
; (1 5 2) (2 5 2) (3 5 2) (4 5 2) (5 5 2) 
; (1 1 3) (2 1 3) (3 1 3) (4 1 3) (5 1 3) 
; (1 2 3) (2 2 3) (3 2 3) (4 2 3) (5 2 3) 
; (1 3 3) (2 3 3) (3 3 3) (4 3 3) (5 3 3) 
; (1 4 3) (2 4 3) (3 4 3) (4 4 3) (5 4 3) 
; (1 5 3) (2 5 3) (3 5 3) (4 5 3) (5 5 3) 
; (1 1 4) (2 1 4) (3 1 4) (4 1 4) (5 1 4) 
; (1 2 4) (2 2 4) (3 2 4) (4 2 4) (5 2 4) 
; (1 3 4) (2 3 4) (3 3 4) (4 3 4) (5 3 4) 
; (1 4 4) (2 4 4) (3 4 4) (4 4 4) (5 4 4) 
; (1 5 4) (2 5 4) (3 5 4) (4 5 4) (5 5 4) 
; (1 1 5) (2 1 5) (3 1 5) (4 1 5) (5 1 5) 
; (1 2 5) (2 2 5) (3 2 5) (4 2 5) (5 2 5) 
; (1 3 5) (2 3 5) (3 3 5) (4 3 5) (5 3 5) 
; (1 4 5) (2 4 5) (3 4 5) (4 4 5) (5 4 5) 
; (1 5 5) (2 5 5) (3 5 5) (4 5 5) (5 5 5))

(define (filter seq predicate)
        (cond ((null? seq) ())
              ((predicate (car seq)) (cons (car seq) (filter (cdr seq) predicate)))
              (else (filter (cdr seq) predicate))))

"Just a little test of filter"
(filter (list 1 2 3 4 5) (lambda (x) (= (remainder x 2) 1))) ;(1 3 5)

(define (triple-sum n s)
        (filter (enumerate-triples n) (lambda (triple) (= (accumulate + 0 triple) s))))

(triple-sum 5 4) ; ((2 1 1) (1 2 1) (1 1 2))
