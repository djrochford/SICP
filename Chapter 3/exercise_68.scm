;Exercise 3.68.  Louis Reasoner thinks that building a stream of pairs from three
;parts is unnecessarily complicated. Instead of separating the pair (S0,T0) from
;the rest of the pairs in the first row, he proposes to work with the whole first
;row, as follows:

(define (pairs s t)
        (interleave (stream-map (lambda (x) 
                                        (list (stream-car s) x))
                                t)
                    (pairs (stream-cdr s) (stream-cdr t))))

;Does this work? Consider what happens if we evaluate `(pairs integers integers)`
;using Louis's definition of pairs.

"`(pairs integers integers)` will never return a value. Returning a value requires
evaluating the arguments of the `interleave`, and the second argument of the `interleave`
is a recursive call to pairs, which will itelf require a recursive call to pairs to
be evaluated before it can return a value, which will itself require a recursive
call to pairs, which will...

Note this is *unlike* the original `pairs` procedure, because you *do not* need to evaluate
a recrusive call to `pairs` in order to get the *first* value of `(pairs s t)`.
"