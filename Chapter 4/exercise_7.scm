;Exercise 4.7.  `Let*` is similar to `let`, except that the bindings of the
;`let` variables are performed sequentially from left to right, and each
;binding is made in an environment in which all of the preceding bindings are
;visible. For example

(let* ((x 3)
       (y (+ x 2))
       (z (+ x y 5)))
      (* x z))

;returns 39. Explain how a `let*` expression can be rewritten as a set of nested
;`let` expressions, and write a procedure `let*->nested-lets` that performs this
;transformation.

"`(let* (<binding1> <binding2> ... <binding n>) <body>)` is equivalent to 
`(let (<binding1>) (let (<binding2>) (let ... (let <binding n)) ...)) <body>)`
I won't offer a proof -- just stare at it for a while.

Here is `let*->nested-lets`:"

(define (make-let bindings body)
        (cons 'let
               (cons bindings
                     body)))

(define (let*->nested-lets exp)
        (define (make-nested-lets bindings body)
                (if (null? bindings)
                    body
                    (make-let (car bindings)
                              (make-nested-lets (cdr bindings)
                                                body))))
        (let ((bindings (let-bindings exp))
              (body (let-body exp)))
             (make-nested-lets bindings body)))

;If we have already implemented `let` (exercise 4.6) and we want to
;extend the evaluator to handle `let*`, is it sufficient to add a clause to eval
;whose action is

(eval (let*->nested-lets exp) env)

;or must we explicitly expand let* in terms of non-derived expressions?

"Adding that clause is, I believe, sufficient; `(let*->nested-lets exp)` will
evaluate to a `let` expression, which `eval` will evaluate the same way it evaluates
all `let` expressions, which is what we want."

