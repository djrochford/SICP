(load "procedures.scm")

(define the-empty-environment '())

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define (make-frame variables values)
        (cons variables values))

(define (first-frame env) (car env))

(define (frame-variables frame) (car frame))

(define (frame-values frame) (cdr frame))

(define (extend-environment vars vals base-env)
        (if (= (length vars) (length vals))
            (cons (make-frame vars vals) base-env)
            (if (< (length vars) (length vals))
                (error "Too many arguments supplied" vars vals)
                (error "Too few arguments supplied" vars vals))))


(define (add-binding-to-frame! var val frame)
        (set-car! frame (cons var (car frame)))
        (set-cdr! frame (cons val (cdr frame))))

(define (define-variable! var val env)
        (let ((frame (first-frame env)))
             (define (scan vars vals)
                     (cond ((null? vars) (add-binding-to-frame! var val frame))
                           ((eq? var (car vars)) (set-car! vals val))
                           (else (scan (cdr vars) (cdr vals)))))
             (scan (frame-variables frame)
                   (frame-values frame))))

(define (set-variable-value! var val env)
        (define (env-loop env)
                (define (scan vars vals)
                        (cond ((null? vars) (env-loop (enclosing-environment env)))
                              ((eq? var (car vars)) (set-car! vals val))
                              (else (scan (cdr vars) (cdr vals)))))
                (if (eq? env the-empty-environment)
                    (error "Unbound variable -- SET!" var)
                    (let ((frame (first-frame env)))
                         (scan (frame-variables frame)
                               (frame-values frame)))))
        (env-loop env))

(define (setup-environment)
        (let ((initial-env (extend-environment (primitive-procedure-names)
                                               (primitive-procedure-objects)
                                               the-empty-environment)))
             (define-variable! 'true true initial-env)
             (define-variable! 'false false initial-env)
             initial-env))

(define (lookup-variable-value var env)
        (define (env-loop env)
                (define (scan vars vals)
                        (cond ((null? vars) (env-loop (enclosing-environment env)))
                              ((eq? var (car vars)) (car vals))
                              (else (scan (cdr vars) (cdr vals)))))
                (if (eq? env the-empty-environment)
                    (error "Unbound variable" var)
                    (let ((frame (first-frame env)))
                         (scan (frame-variables frame)
                               (frame-values frame)))))
        (env-loop env))