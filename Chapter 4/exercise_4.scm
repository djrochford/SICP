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