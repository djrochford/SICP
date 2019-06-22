;Exercise 3.9.  In section 1.2.1 we used the substitution model to analyze two procedures
;for computing factorials, a recursive version

(define (factorial n)
        (if (= n 1)
            1
            (* n (factorial (- n 1)))))

;and an iterative version

(define (factorial n)
        (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
        (if (> counter max-count)
            product
            (fact-iter (* counter product)
                       (+ counter 1)
                       max-count)))

;Show the environment structures created by evaluating (factorial 6) using each version
;of the factorial procedure.

"First, the recursive version

The execution of `(factorial 6)` involves 6 new frames of execution. In the first, `n`
bound to 6; in the second, it's bound to 5, and so on, until the 6th new frame, in
which `n` is bound to 1. All these frames and children of the global frame --
i.e., the in which `factorial` is bound.

The iterative version:
In the global frame there are two procedures defined, not one. `(factorial 6`)
creates a frame where `n` is bound to 6. That is the only frame created by an invocation
`factorial`; the rest of the frames involved are created by applications of `fact-iter`.
There are seven such frames; the first has `product` bound to `1`, `counter` bound to `1`,
and `max-counter` bound to `6`, the second has bindings 1 2 6, then 2 3 6, then 6 4 6, then
24 5 6, then 120 6 7, then 720 7 6. The parent frame for all these frames is the global frame."

