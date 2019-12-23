;Exercise 4.31.  The approach taken in this section is somewhat unpleasant,
;because it makes an incompatible change to Scheme. It might be nicer to
;implement lazy evaluation as an upward-compatible extension, that is, so
;that ordinary Scheme programs will work as before. We can do this by extending
;the syntax of procedure declarations to let the user control whether or not arguments
;are to be delayed. While we're at it, we may as well also give the user the choice
;between delaying with and without memoization. For example, the definition

(define (f a (b lazy) c (d lazy-memo))
  ...)

;would define f to be a procedure of four arguments, where the first and third
;arguments are evaluated when the procedure is called, the second argument is delayed,
;and the fourth argument is both delayed and memoized. Thus, ordinary procedure
;definitions will produce the same behavior as ordinary Scheme, while adding the
;`lazy-memo` declaration to each parameter of every compound procedure will produce
;the behavior of the lazy evaluator defined in this section. Design and implement
;the changes required to produce such an extension to Scheme. You will have to
;implement new syntax procedures to handle the new syntax for `define`. You must
;also arrange for `eval` or `apply` to determine when arguments are to be delayed,
;and to `force` or `delay` arguments accordingly, and you must arrange for forcing
;to memoize or not, as appropriate.

"Despite all the stuff the text says must be changed, I believe the only places that
require changes are `list-of-values` and `force-it`.

It will be handy to see the immediately evaluating `list-of-arg-values`, and it's
delaying cousin `list-of-delayed-args`, in creating the `list-of-values` version
that can do both."

(define (list-of-arg-values exps env)
        (if (no-operands? exps)
            '()
            (cons (actual-value (first-operand exps) env)
                  (list-of-arg-values (rest-operands exps)
                                      env))))

(define (list-of-delayed-args exps env)
        (if (no-operands? exps)
            '()
            (cons (delay-it (first-operand exps) env)
                  (list-of-delayed-args (rest-operands exps)
                                        env))))

"Here's the new version:"
(define (list-of-values exps env)
        (if (no-operands? exps)
            '()
            (let* ((first (first-operand exps))
                   (first-return (if (symbol? first)
                                     (actual-value first env)
                                     (delay-it first env))))
                  (cons first-return
                        (list-of-values (rest-operands exps env))))))

"And now `force-it`. The old memoizing `force-it` for reference."

(define (force-it obj)
        (cond ((thunk? obj) (let ((result (actual-value (thunk-exp obj)
                                          (thunk-env obj))))
                                 (set-car! obj 'evaluated-thunk)
                                 (set-car! (cdr obj) result)  ; replace exp with its value
                                 (set-cdr! (cdr obj) '())     ; forget unneeded env
                                 result))
              ((evaluated-thunk? obj) (thunk-value obj))
              (else obj)))

"And now the new one."

(define (force-it obj)
        (cond ((thunk? obj) (let ((eval-policy (cdr (thunk-exp obj)))
                                  (result (actual-value (car (thunk-exp obj)) (thunk-env obj))))
                                 (cond ((eq? eval-policy 'lazy) result)
                                       ((eq? eval-policy 'lazy-memo) (begin (set-car! obj 'evaluated-thunk)
                                                                            (set-car! (cdr obj) result)
                                                                            (set-cdr! (cdr obj) '())
                                                                            result))
                                       (else (error "Unknown evaluation policy -- FORCE-IT" eval-policy)))))
              ((evaluated-thunk? obj) (thunk-value obj))
              (else obj)))




