(define (square-tree tree)
        (cond ((null? tree) ())
              ((not (pair? tree)) (* tree tree))
              (else (cons (square-tree (car tree))
                          (square-tree (cdr tree))))))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (square-tree-map tree)
        (map (lambda (sub-tree)
                     (if (pair? sub-tree)
                         (square-tree-map sub-tree)
                         (* sub-tree sub-tree)))
             tree))

(square-tree-map (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (tree-map proc tree)
        (map (lambda (sub-tree)
                     (if (pair? sub-tree)
                         (tree-map proc sub-tree)
                         (proc sub-tree)))
             tree))

(define (square n)
        (* n n))

(define (square-tree-tree-map tree) (tree-map square tree))

(square-tree-tree-map (list 1 (list 2 (list 3 4) 5) (list 6 7)))