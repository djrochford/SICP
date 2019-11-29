;Exercise 4.27.  Suppose we type in the following definitions to the lazy evaluator:

(define count 0)
(define (id x)
        (set! count (+ count 1))
        x)

;Give the missing values in the following sequence of interactions, and explain
;your answers.

(define w (id (id 10)))
;;; L-Eval input:
count
;;; L-Eval value:
<response>
;;; L-Eval input:
w
;;; L-Eval value:
<response>
;;; L-Eval input:
count
;;; L-Eval value:
<response>

"This is slightly more subtle than you think; it's worth working through slowly.
Let's see exactly what happens when you `(define w (id (id 10)))`. Recall the
prcodure the evalutor executes when it finds a deinition:"

(define (eval-definition exp env)
        (define-variable! (definition-variable exp)
                          (eval (definition-value exp) env)
                          env)
        'ok)

=> (define-variable! 'w (eval '(id (id 10)) env) env)

"The `(eval '(id (id 10)) env)` uses the new, lazy-evalution caluse of `eval`:"

((application? exp) (apply (actual-value (operator exp) env)
                           (operands exp)
                           env))

"So the `apply` here uses the `actual-value` of `id`; retrieving that value
involves, apparently (I learn from the internet) evaluating the body of `id`.
This is the thing I found unobvious.

Evaluating the body of `id` involves evaluating that `set!` expression once.
The operand `(id 10)`, on the other hand, is delayed, and so the body of `id`
is evaluated only that once. So after `(define w (id (id 10)))` is evaluated
`count` has value `1`."

"w, on the other hand has value `10`, and no code defined here can change that."

"To recover the value of `w`, we had to evaluate the operand of `(id (id 10)))`, which
meant evaluating `id` a second time, and thus increment count once more, so the inputting
`count` the second time to the REPL returns `2`.

