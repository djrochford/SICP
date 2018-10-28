;Exercise 2.30.  Define a procedure `square-tree` analogous to the `square-list` procedure of exercise 2.21. 
;Define square-tree both directly (i.e., without using any higher-order procedures) 
;and also by using map and recursion.

(define (square-tree tree)
        (cond ((null? tree) ())
              ((not (pair? tree)) (* tree tree))
              (else (cons (square-tree (car tree))
                          (square-tree (cdr tree))))))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))) ;(1 (4 (9 16) 25) (36 49))

(define (square-tree-map tree)
        (map (lambda (sub-tree)
                     (if (pair? sub-tree)
                         (square-tree-map sub-tree)
                         (* sub-tree sub-tree)))
             tree))

(square-tree-map (list 1 (list 2 (list 3 4) 5) (list 6 7))) ;(1 (4 (9 16) 25) (36 49))

;Exercise 2.31.  Abstract your answer to exercise 2.30 to produce a procedure tree-map 
;with the property that `square-tree `could be defined as

;(define (square-tree-tree-map tree) (tree-map square tree))

(define (tree-map proc tree)
        (map (lambda (sub-tree)
                     (if (pair? sub-tree)
                         (tree-map proc sub-tree)
                         (proc sub-tree)))
             tree))

(define (square n)
        (* n n))

(define (square-tree-tree-map tree) (tree-map square tree))

(square-tree-tree-map (list 1 (list 2 (list 3 4) 5) (list 6 7))) ; (1 (4 (9 16) 25) (36 49))