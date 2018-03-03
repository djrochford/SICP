(define (make-accumulator sum)
        (lambda (n)
                (begin (set! sum (+ sum n))
                       sum)))

(define A (make-accumulator 5))

(A 10)
;15
(A 10)
;25