(define (make-let bindings body)
        (cons 'let
               (cons bindings
                     body)))

(define (let*->nested-lets exp)
        (let ((bindings (let-bindings exp))
              (body (let-body exp)))
             (if (null? bindings)
                 body
                 (make-let (car bindings)
                           (let*->nested-lets (cdr bindings)
                                              body))))) 