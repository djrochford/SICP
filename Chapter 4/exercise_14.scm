;Exercise 4.14.  Eva Lu Ator and Louis Reasoner are each experimenting with
;the metacircular evaluator. Eva types in the definition of map, and runs
;some test programs that use it. They work fine. Louis, in contrast, has
;installed the system version of map as a primitive for the metacircular
;evaluator. When he tries it, things go terribly wrong. Explain why Louis's
;map fails even though Eva's works.

"Let us take, for example, attempting to evaluate:"

'(map (lambda (x) (+ 1 x)) (list 1 2 3))

"When the evaluator tries to evaluate this, it will correctly use the
`application` clause in `eval` -- i.e."

((application? exp) (apply (eval (operator exp) env)
                           (list-of-values (operands exp) 
                                           env)))

"Which will evaluate like so:"

(apply (eval ('map env))
       (list-of-values '((lambda (x) (+ 1 x)) (list 1 2 3))))

"`map`, having been correctly installed, this will evaluate to"

(apply ('primitive map) (list 'procedure '(x) '(+ 1 x)) (list 1 2 3))

"When `apply` applies a primitive, it does so via:"

(define (apply-primitive-procedure proc args)
        (apply-in-underlying-scheme (primitive-implementation proc)
                                    args))

"So the above evaluates to"

(apply-in-underlying-scheme map ((list 'procedure '(x) '(+ 1 x)) (list 1 2 3)))

"and here we see the problem: the metarircular implementation of LISP represents
procedures differently to the way the underlying LISP does: they are tagged with
that 'procedure tag. Using the underlying-scheme `apply` to apply `map` to such
a procedure won't work -- the tagged procedure will not be properly intepreted by
the underlying `apply`. Only the metaciruclar `apply` knows wha to do with procedures
represented this way.

Eva Lu Ator's non-primitive `map` procedure is *not* applied using the underlying
scheme's `apply`, but by the metacricular evalutor's `apply`, which is expecting
procedures with those tags attached, and will thus correctly apply `map` to them.

This is a  general feature of our metacircular evaluator: it cannot handle primitive
procedures that take other procedures as arguments."