(define (fringe tree)
        (define (tree-traverse tree accumulator)
                (cond ((null? tree) accumulator)
                      ((not (pair? tree)) (cons tree accumulator))
                      (else (tree-traverse (car tree) (tree-traverse (cdr tree) accumulator)))))
        (tree-traverse tree ()))


(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x x))
