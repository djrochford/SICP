;Exercise 4.11.  Instead of representing a frame as a pair of lists, we can represent a
;frame as a list of bindings, where each binding is a name-value pair. Rewrite the
;environment operations to use this alternative representation.

(define (add-binding-to-frame! var val frame)
        (cons (cons var val)
              frame))

(define (lookup-variable-value var env)
        (define (env-loop env)
                (define (scan frame)
                        (cond ((null? frame) (env-loop (enclosing-environment env)))
                              ((eq? (caar frame) var) (cdar vals))
                              (else (scan (cdr frame))))
                (if (eq? env the-empty-environment)
                    (error "Unbound variable" var)
                    (scan (first-frame env))))
        (env-loop env))

(define (set-variable-value! var val env)
        (define (env-loop env)
                (define (scan frame)
                        (cond ((null? frame) (env-loop (enclosing-environment env)))
                              ((eq? (caar frame) var) (set-cdr! (car frame) val))
                              (else (scan (cdr frame)))))
                (if (eq? env the-empty-environment)
                    (error "Unbound variable -- SET!" var)
                    (scan (first-frame frame))))
        (env-loop env))

(define (define-variable! var val env)
        (let ((frame (first-frame env)))
             (define (scan frame)
                     (cond ((null? frame) (add-binding-to-frame! var val frame))
                           ((eq? (caar frame) var) (set-cdr! (car frame) val))
                           (else (scan (cdr frame)))))
             (scan frame)))

(define (extend-environment frame base-env)
        (cons frame base-env))

(define (frame-variables frame)
        (define (loop frame accumulator)
                (if (null? frame)
                    accumulator
                    (loop (cdr frame) (cons (caar frame) accumulator))))
        (loop frame '()))

(define (frame-values frame))
        (define (loop frame accumulator)
                (if (null? frame)
                    accumulator
                    (loop (cdr frame) (cons (cdar frame) accumulator))))
        (loop frame '()))



