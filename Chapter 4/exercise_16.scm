;Exercise 4.16.  In this exercise we implement the method just described for
;interpreting internal definitions. We assume that the evaluator supports `let`
;(see exercise 4.6).

;a.  Change `lookup-variable-value` (section 4.1.3) to signal an error if the value
;it finds is the symbol *unassigned*.

"The original `lookup-variable-value`, for reference:"

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

"With the added behaviour for `*unassigned*`:"

(define (lookup-variable-value var env)
        (define (env-loop env)
                (define (scan vars vals)
                        (cond ((null? vars) (env-loop (enclosing-environment env)))
                              ((eq? var (car vars)) (if (eq? (car vals) '*unassigned*')
                                                        (error "Unassigned value" val)
                                                        (car vars)))
                              (else (scan (cdr vars) (cdr vals)))))
                (if (eq? env the-empty-environment)
                    (error "Unbound variable" var)
                    (let ((frame (first-frame env)))
                         (scan (frame-variables frame)
                               (frame-values frame)))))
        (env-loop env))

;b.  Write a procedure `scan-out-defines` that takes a procedure body and returns an
;equivalent one that has no internal definitions, by making the transformation described
;above.

"This implementation is somewhat inefficient but it's clean."
(define (scan-out-defines proc-body)
        (let* ((definitions (filter definition? proc-body)))
              (if (null? definitions)
                  proc-body
                  (let* ((rest-of-body (filter (lambda (clause) (not (definition? clause)))))
                         (def-variables (map definition-variable definitions))
                         (def-values (map definitions-value definitions))
                         (variable-assignments (map (lambda (var) (cons var '*unassigned*)) def-variables))
                         (set-statements (map (lambda (var-val-pair) (make-assignment (car var-val-pair) (cdr var-val-pair))) 
                                              (zip def-variables def-values)))
                         (let-body (append set-statements rest-of-body)))
                        (make-let variable-assignments let-body)))))
"Where 
 - `(zip list1 list2)` returns a list of the pair of the first elements of `list1` and `list2`, followed by
the pair of the second elements of `list1` and `list2`, and so on. (Definition is an exercise for the reader.)
 - `make-let` makes a let-expression in the object-language, and
 - `make-assignment` makes an assignment expression in the object-language.
"

;c.  Install scan-out-defines in the interpreter, either in `make-procedure` or in
;`procedure-body` (see section 4.1.3). 

(define (make-procedure parameters body env)
        (list 'procedure parameters (scan-out-defines body) env))

;Which place is better? Why?
"I prefer `make-procedure` because it means that `scan-out-defines` will only be run once per procedure,
when the procedure is defined, wheras, if `scan-out-defines` were installed in `procedure-body`, it would
run every time the body of a procedure were accessed."


                         