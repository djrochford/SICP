;Exercise 1.34.  Suppose we define the procedure

(define (f g)
  (g 2))

;Then we have

(f square)
;4

(f (lambda (z) (* z (+ z 1))))
;6

;What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.

"We get an error: 2 is not applicable.

Let us use the substitution model of procedure application. (f f) is evaluated to the body of f with `f` substituted for `g` -- 
i.e. (f 2). (f 2) is again evaluated to the body of f with `2` substituted for `g` -- i.e. (2 2). The evaluator then tries
to apply the procedure named by `2` to the value of `2`, but `2` doesn't name a procedure and therefor cannot be applied.
Hence the error."

