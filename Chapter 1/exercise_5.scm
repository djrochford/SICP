;Exercise 1.5.  Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

;(define (p) (p))

;(define (test x y)
;  (if (= x 0)
;      0
;      y))

;Then he evaluates the expression

;(test 0 (p))

;What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)

"If the interpreter uses applicative order evaluation, then `(test 0 (p))` will never return a value, but rather loop forever."
"It will do this because, before applying `test` to `(p)`, it will attempt to evaluate `(p)`, which will involve an infinite regression."
"On the other hand, if the interpreter uses normal order, `(test 0 (p))` will return 0."
"This is because `(p)` will never be evaluated; it isn't evaluated when it is passed into `test`,"
"and it isn't evaluated when the body of test is evaluated (because the predicate of the `if` expression is true)."
