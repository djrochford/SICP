(define (rand command)
        (define state (random 1.0))
        (cond ((eq? command 'generate) (rand-update state))
              ((eq? command 'reset) (lambda (new-value) (set! state new-value)))))