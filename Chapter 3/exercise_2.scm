(define (square x)
        (* x x))


(define (make-monitored function)
        (define counter 0)
        (define (mf input)
                (cond ((eq? input 'how-many-calls?) counter)
                      ((eq? input 'reset-counter) (begin (set! counter 0)
                                                          "counter reset"))
                      (else (begin (set! counter (+ counter 1))
                                   (function input)))))
        mf)


(define s (make-monitored square))

(s 100)
;10000

(s 'how-many-calls?)
;1

(s 100)

(s 'how-many-calls?)