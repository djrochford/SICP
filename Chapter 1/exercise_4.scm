;Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))

"a-plus-abs-b checks if b is greater than 0; is so, it returns the sum of a and b."
"Otherwise, it returns a minus b. I.e. -- it returns a plus the absolute value of b."
