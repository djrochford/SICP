;Exercise 4.4.  Recall the definitions of the special forms `and` and `or` 
;from chapter 1:

;`and`: The expressions are evaluated from left to right. If any expression
;evaluates to false, false is returned; any remaining expressions are not 
;evaluated. If all the expressions evaluate to true values, the value of the
;last expression is returned. If there are no expressions then true is returned.

;`or`: The expressions are evaluated from left to right. If any expression evaluates
;to a true value, that value is returned; any remaining expressions are not evaluated.
;If all expressions evaluate to false, or if there are no expressions, then false is
;returned.

;Install `and` and `or` as new special forms for the evaluator by defining appropriate
;syntax procedures and evaluation procedures `eval-and` and `eval-or`. Alternatively,
;show how to implement `and` and `or` as derived expressions.

"Here I used the derived-expression approach; `and` and `or` expressions get transformed
to `if` expressions."

(define (and? exp) (tagged-list? exp 'and))
(define (conjuncts exp) (cdr exp))
(define (last-conjunct? conjuncts)
        (and (pair? conjuncts) 
             (not (null? (car conjuncts)))
             (null? (cdr conjuncts))))
(define (and->if exp) (expand-conjuncts (conjuncts exp)))
(define (expand-conjuncts conjuncts)
        (cond ((null? conjuncts) 'true)
              ((last-conjunct? conjuncts) (make-if (car conjuncts) 
                                                   (car conjuncts) 
                                                   'false))
              (else make-if (car conjuncts)
                            (expand-conjuncts (cdr conjuncts))
                            'false)))

(define (or? exp) (tagged-list? exp 'or))
(define (disjuncts exp) (cdr exp))
(define (or->if exp) (expand-disjuncts (disjuncts exp)))
(define (expand-disjuncts disjuncts)
        (if (null? disjuncts)
            'false
            (make-if (car disjuncts)
                     (car disjuncts)
                     (expand-disjuncts (cdr disjuncts)))))