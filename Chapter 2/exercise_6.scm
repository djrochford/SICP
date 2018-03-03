(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
        (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (church-to-int n)
        ((n (lambda (x) (+ x 1))) 0))

(= (church-to-int (add-1 zero)) (church-to-int one))
(= (church-to-int (add-1 (add-1 zero))) (church-to-int two))

(define (add n m)
        (lambda (f) (lambda (x) (f ((n (m f)) x)) )))

(church-to-int (add one two))
