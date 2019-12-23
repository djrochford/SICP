;Exercise 4.32.  Give some examples that illustrate the difference between the
;streams of chapter 3 and the "lazier" lazy lists described in this section. How
;can you take advantage of this extra laziness?

"A relatively obvious way to take advantage of this is to make an infinite tree:"

(define (make-tree left-tree node right-tree)
        (list left-tree node right-tree))

(define one-tree (make-tree one-tree 1 one-tree))


"Fancier:"

(define (left tree) (car tree))
(define (node tree) (cadr tree))
(define (right tree) (caddr tree))

(define (tree-map proc tree)
        (make-tree (tree-map proc (left tree))
                   (proc (node tree))
                   (tree-map proc (right tree))))


(define power-of-two-fractions (make-tree (tree-map (lambda (x) (/ x 2))
                                                    power-of-two-fractions)
                                          (/ 1 2)
                                          (tree-map (lambda (x) (/ (* 3 x) 2))
                                                    power-of-two-fractions)))

