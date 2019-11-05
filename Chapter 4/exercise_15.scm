;Exercise 4.15.  Given a one-argument procedure `p` and an object `a`, `p` is said to
;"halt" on `a` if evaluating the expression `(p a)` returns a value (as opposed to
;terminating with an error message or running forever). Show that it is impossible
;to write a procedure `halts?` that correctly determines whether `p` halts on `a`
;for any procedure `p` and object `a`. Use the following reasoning: If you had such
;a procedure `halts?`, you could implement the following program:

(define (run-forever) (run-forever))

(define (try p)
        (if (halts? p p)
            (run-forever)
            'halted))

;Now consider evaluating the expression `(try try)` and show that any possible outcome
;(either halting or running forever) violates the intended behavior of `halts?`.

"
Suppose, for *reductio*, that `(try try)` halts. Then that means that the test of the `if`
clause in `try` evaluated to `false`, when `p` was `try` -- i.e., `(halts? try try)` evaluated
to `false`. Now, if `halts?` has the intended behaviour, `(halts? try try)` evaluates
to `false` only if `(try try)` does not halt. But by hypothesis `(try try)` does halt.
Contadiction! So it cannot be the case that `halts?` has intended behaviour and `(try try)`
halts.

Suppose, on the other hand, that `(try try)` does not halt. Then `(halts? p p)` must
evaluate to `true`. If `halts?` has intended behaviour, than it follows that `(try try)`
must halt. So if `(try try)` does not halt, it halts. Contradiction! So it cannot be
the case that `halts?` has intended behaviour and `(try try)` halts.

So it cannot be the case that `halts?` has intended behvaviour and `(try try)` halts,
and it cannot be the case that `halts?` has intended behaviour and `(try try)` does
not halt. So it cannot be the case that `halts?` has intended behaviour -- i.e., it is
not possible to write a procedure `halts?` such that `(halts? p a)` that returns `true` iff
`(p a)` halts.
"