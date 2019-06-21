;Exercise 3.8.  When we defined the evaluation model in section 1.1.3, we said that the
;first step in evaluating an expression is to evaluate its subexpressions. But we never
;specified the order in which the subexpressions should be evaluated (e.g., left to right
;or right to left). When we introduce assignment, the order in which the arguments to a
;procedure are evaluated can make a difference to the result. Define a simple procedure
;`f` such that evaluating `(+ (f 0) (f 1))` will return `0` if the arguments to `+` are
;evaluated from left to right but will return `1` if the arguments are evaluated from
;right to left.

(define (f n)
        (define state 0)
        (define return-value (if (eq? state 0)
                                 n
                                 0))
        (set! state (+ state 1))
        return-value)

(+ (f 0) (f 1))

"If arguments are evaluated left-to-right, then `(f 0)` will evaluate to 0, and then `(f 1)` will 
evaluate to 0, so `(+ (f 0) (f 1))` returns 0. On the other hand, if values are evaluated
right-to-left, `(f 1)` will evaluate to 1, and then `(f 0)` to 0, so `(+ (f 0) (f 1))` returns
`1`.

As a matter of fact, my evaluator returns `1`, so it appears that it is evaluating
right-to-left."