;Exercise 1.6.  Alyssa P. Hacker doesn't see why if needs to be provided as a special form. ``Why can't I just define it as an ordinary procedure in terms of cond?'' she asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5)
;5

;(new-if (= 1 1) 0 5)
;0

;Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

;What happens when Alyssa attempts to use this to compute square roots? Explain.

"As soon as `new-if` is invoked inside `sqrt-iter`, the interpretor will attempt to evaluate all three parameters -- 
the predicate, the then-clause and the else-clause. Evaluating the else clause involves evaluating another applicaiont
of `sqrt-iter`, which involves another invocation of `new-if`, which requires the immediate evaluation of *it's* else clause,
which... involves an infinite series of `sqrt-iter` applications, which will not get done. soon
Alyssa will wait forever for her method to complete (or the interpertor will reach the max stack size)."