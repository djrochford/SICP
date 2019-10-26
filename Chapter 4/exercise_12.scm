;Exercise 4.12.  The procedures `set-variable-value!`, `define-variable!`,
;and `lookup-variable-value` can be expressed in terms of more abstract
;procedures for traversing the environment structure. Define abstractions 
;that capture the common patterns and redefine the three procedures in terms
;of these abstractions.

"For reference, the non-abstractified procedures are:"

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

(define (define-variable! var val env)
        (let ((frame (first-frame env)))
             (define (scan vars vals)
                     (cond ((null? vars) (add-binding-to-frame! var val frame))
                           ((eq? var (car vars)) (set-car! vals val))
                           (else (scan (cdr vars) (cdr vals)))))
             (scan (frame-variables frame)
                   (frame-values frame))))

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

"Here are some abstracted procedures for traversing the environment structure:"

; This returns #f if it can't find `var` in `frame`, otherwise it returns the
; sublist of vals where the head of the list is the val corresponding to `var`.
(define (scan-frame var frame)
        (let ((vars (frame-variables frame)) (vals (frame-variables frame)))
             (cond ((null? vars) #f)
                   ((eq? var (car vars)) vals)
                   (else (scan (cdr vars) (cdr vals))))))

; Similarly, this returns #f if it can't find `var` in `env`, otherwise it
; returns the sublist of vals where the head of the list is the val corresponding to
; `var` in `env`.
(define (scan-env var env)
        (if (eq? env the-empty-environment)
            #f
            (let ((vals (scan-frame var (first-frame env))))
                 (or vals
                     (scan-env (enclosing-environment env))))))

"Now, those original procedures defined in terms of the ones for traversing the environment:"

(define (set-variable-value! var val env)
        (let ((vals (scan-env var env))
             (if vals
                 (set-car! vals val)
                 (error "Unbound variable -- SET!" var)))))

(define (define-variable! var val env)
        (let ((vals (scan-frame var (first-frame env))))
             (if vals
                 (set-car! vals val)
                 (add-binding-to-frame! var val (first-frame env)))))

(define (lookup-variable-value var env)
        (let ((vals (scan-env var env)))
             (if vals
                 (car vals))
                 (error "Unbound variable" var)))



