(define (f n)
        (define state 0)
        (define return-value (if (eq? state 0)
                                 n
                                 0))
        (set! state (+ state 1))
        return-value)

(+ (f 0) (f 1))