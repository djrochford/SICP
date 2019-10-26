;Exercise 4.13.  Scheme allows us to create new bindings for variables by means
;of `define`, but provides no way to get rid of bindings. Implement for the
;evaluator a special form `make-unbound!` that removes the binding of a given
;symbol from the environment in which the `make-unbound!` expression is evaluated.
;This problem is not completely specified. For example, should we remove only the
;binding in the first frame of the environment? Complete the specification and
;justify any choices you make.

"The syntax I will use is (make-unbound <var1> <var2> ... <var n>) -- that is, 
I will allow an arbitrary number of variables to be unbound in one `make-unbound`
expression; this is to follow general Scheme practice of not restricting the 
number of operands more than necessary.

First a procedure to identify `make-unbound` expressions, and some selectors.
"

(define (make-unbound? exp) (tagge-list? exp 'make-unbound))

(define (make-unbound-vars exp) (cadr exp))

"Now for the procedure `eval-make-unbound!`, to be used in a `make-unbound!` clause.
in the `eval` procedure. I will have `make-unbound!` unbind the first instance
of the var that exists in the environment of execution, and no others. This means that
`var` as it appears in `make-unbound!` expressions refers to the same thing as it
does in all other contexts, and is thus the least surprising behaviour, at least to me.
That's good."

"Some helper:"

;Return #t if it find `var` in `frame`, and then goes ahead with the splice;
;otherwise returns #f.
(define (splice-frame! var frame)
        (define (scan current-vars current-vals previous-vars previous-vals)
                (cond ((null? current-vars) #f)
                      ((eq? (car current-vars) var) (if (null? previous-vars)
                                                        (begin (set-car! frame
                                                                         (cdr current-vars))
                                                               (set-cdr! frame
                                                                         (cdr current-vals))
                                                               #t)
                                                        (begin (set-cdr! previous-vars
                                                                         (cdr current-vars))
                                                               (set-cdr! previous-vals
                                                                         (cdr current-vals))
                                                               #t)))
                      (else (scan (cdr current-vars)
                                  (cdr current-vals)
                                  current-vars
                                  current-vals))))
        (scan (frame-variables frame) (frame-values frame) '() '()))

(define (unbind! var env)
        (if (null? env) 
            (error "Can not `make-unbound!` unbound variable." env)
            (or (splice-frame var (first-frame env))
                (unbind var (enclosing-environment env)))))


"And here's the procedure."
(define (eval-make-unbound! exp env)
       (define (vars-loop vars-to-unbind)
               (if (null? vars)
                   "Done"
                   (begin (unbind! (car vars-to-unbind) env)
                          (vars-loop (cdr vars-to-unbind)))))
        (vars-loop (make-unbound-vars exp)))