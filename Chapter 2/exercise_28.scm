;Exercise 2.28.  Write a procedure `fringe` that takes as argument a tree 
;(represented as a list) and returns a list whose elements are all the leaves of the tree 
;arranged in left-to-right order.

(define (fringe tree)
        (define (tree-traverse tree accumulator)
                (cond ((null? tree) accumulator)
                      ((not (pair? tree)) (cons tree accumulator))
                      (else (tree-traverse (car tree) (tree-traverse (cdr tree) accumulator)))))
        (tree-traverse tree ()))


(define x (list (list 1 2) (list 3 4)))
(fringe x) ; (1 2 3 4)
(fringe (list x x)) ; (1 2 3 4 1 2 3 4)
