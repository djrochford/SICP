;Exercise 4.25.  Suppose that (in ordinary applicative-order Scheme) we define
;`unless` as shown above and then define `factorial` in terms of `unless` as

(define (factorial n)
        (unless (= n 1)
                (* n (factorial (- n 1)))
                1))

;What happens if we attempt to evaluate `(factorial 5)`?
"This procedure would never terminate. Each call to `factorial` requires `(* n (factorial (- n 1)))`
to be evaluated, including the call when `(= n 1)` evaluates to `#t`. So for every call to
`factorial`, there is another call to `factorial`."

;Will our definitions work in a normal-order language?

"Yes it would; the recrusive calls to `factorial` will be evaluated only  if they need to be,
and the call when `(= n 1)` is `#t` does *not* require the recursive call to `factorial`
to be evaluated. Hence, in that case, there is no further call to `factorial` -- it acts
as a base case, as intended."