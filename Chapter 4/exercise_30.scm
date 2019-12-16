;Exercise 4.30.  Cy D. Fect, a reformed C programmer, is worried that some side
;effects may never take place, because the lazy evaluator doesn't force the
;expressions in a sequence. Since the value of an expression in a sequence other
;than the last one is not used (the expression is there only for its effect, such
;as assigning to a variable or printing), there can be no subsequent use of this
;value (e.g., as an argument to a primitive procedure) that will cause it to be forced.
;Cy thus thinks that when evaluating sequences, we must force all expressions in the
;sequence except the final one. He proposes to modify `eval-sequence` from section
;4.1.1 to use `actual-value` rather than `eval`:

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

;a. Ben Bitdiddle thinks Cy is wrong. He shows Cy the `for-each` procedure described
;in exercise 2.23, which gives an important example of a sequence with side effects:

(define (for-each proc items)
        (if (null? items)
            'done
            (begin (proc (car items))
                   (for-each proc (cdr items)))))

;He claims that the evaluator in the text (with the original `eval-sequence`) handles
;this correctly:

;;; L-Eval input:
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
57
321
88
;;; L-Eval value:
done

;Explain why Ben is right about the behavior of `for-each`.
"
The prcedures with side-effects in Ben's `for-each` example are primitive,
and primitive procedures are never delayed.
"

;b. Cy agrees that Ben is right about the `for-each` example, but says that that's
;not the kind of program he was thinking about when he proposed his change to
;`eval-sequence`. He defines the following two procedures in the lazy evaluator:

(define (p1 x)
        (set! x (cons x '(2)))
        x)

(define (p2 x)
        (define (p e)
                e
                x)
        (p (set! x (cons x '(2)))))

;What are the values of (p1 1) and (p2 1) with the original `eval-sequence`? What
;would the values be with Cy's proposed change to `eval-sequence`?

"With the original: `(p1 1)` evaluats to `1`, `(p2 1)` evalueates to `'(1 2)`. With Cy's proposed
changes, `(p1 1)` evaluates to `'(1 2)`, as does `(p2 1)`."

;c. Cy also points out that changing `eval-sequence` as he proposes does not affect
;the behavior of the example in part a. Explain why this is true.

"Using both Cy's `eval-sequence` and the original, every expression in the part a example
gets evaluated. In general, Every expression evaluated using the original `eval-sequence
will be evaluated by Cy's `eval-sequence`, so  cases in which they differ will
involve expressions that are not evaluated using the original `eval-sequence`."

;d. How do you think sequences ought to be treated in the lazy evaluator? Do you like
;Cy's approach, the approach in the text, or some other approach?

"I choose Cy's approach and the approach. As Cy points out, the only reason to have
sequences of expressions is for the side-effects of the non-terminal expression, and
only Cy ensures thos side efects occur, so only Cy's approach aligns with the intent
of a sane programmer."

