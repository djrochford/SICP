;Exercise 2.92.  By imposing an ordering on variables, extend the polynomial package
;so that addition and multiplication of polynomials works for polynomials in different
;variables. (This is not easy!)


"This really isn't easy. First we need a way to expand polynomials into an alternate
representation in which no polynomial appears as a coefficient of a term; all
variables need to be out at the same level. Then we need a way to collect terms. Then
we need a way to convert that representation back into our standard polynomial representation
expressing it as a polynomial in a given variable.

Task 1: expanding polynomials into an alternate representation.

What representaiton will that be? We'll need a new data-structure, `expanded-term`,
which be a list. The first member of that list will be the coefficient of the term.
The remaining members of the list are pairs, the first member of which is a variable,
the second of which represent the order of that variable."

(define (make-expanded-term coefficient . variables)
        (cons coefficient variables))

(define coefficient car)

(define variables cdr)

"The 'variables' above are the aforementioned pair of indefinite and it's order; we'll
make a data-structure especialy for that, too:"

(define make-expanded-variable cons)

(define indefinite car)

(define expanded-variable-order cdr)

"Our alternative polynomial representaiton will be a list of expanded terms."

(define (make-expanded-poly . exp-terms)
        exp-terms)

"How to convert from the usual (sparse) representation to the expanded representation?
The general case is a bit tricky."

(define (add-var-to-vars new-var old-vars)
        (if (null? old-vars)
            (list new-var)
            (let* ((first-old (car old-vars))
                   (first-indefinite (indefinite first-old))
                   (first-order (expanded-variable-order first-old))
                   (new-indefinite (indefinite new-var))
                   (new-order (expanded-variable-order new-var)))
                  (if (same-variable? first-indefinite new-indefinite)
                      (cons (make-expanded-variable first-indefinite
                                                    (+ first-order new-order))
                            (cdr old-vars))
                      (cons first-old 
                            (add-var-to-vars new-var (cdr old-vars)))))))

(define (mul-term-by-var exp-var exp-term)
        (make-expanded-term (coefficient exp-ter)
                            (add-var-to-vars exp-var (variables exp-term))))

(define (mul-through exp-var exp-poly)
        (map (lambda (exp-term) (mul-term-by-var exp-var exp-term))
             exp-poly))

(define (sparse-term->expanded-term var sparse-term)
        (let ((expanded (make-expanded-variable var (order sparse-term))))
             (mul-through expanded (sparse-poly->expanded-poly (coeff sparse-term)))))

(define (flatten l) ;just flattening one level, unlike some other `flatten`s you might have seen.
        (if (null? l)
            '()
            (append (car l) (flatten (cdr l)))))

(define (sparse-poly->expanded-poly sparse-poly)
        (if (not (is-polynomial? sparse-poly))
            (make-expanded-poly (make-expanded-term sparse-term '()))
            (flatten (map (lambda (sparse-term) 
                         (sparse-term->expanded-term (variable sparse-poly) 
                                                     sparse-term))
                          sparse-poly))))

"Now to collect terms. Warning -- this is untested code. I'm pretty sure it doesn't
exactly work as written. But you get the idea."

(define (all truth-value-list)
        (if (null? truth-value-list)
            #t
            (and (car truth-value-list)
                 (all (cdr truth-value-list)))))

(define (includes-var? var-list var)
        (if (null? var-list)
            #f
            (let* ((sourse-indefinite (indefinite var))
                   (source-order (order var))
                   (first (car var-list))
                   (target-indefinite (indefinite first))
                   (target-order (order first)))
                  (if (and (same-variable? target-indefinite
                                           source-indefinite)
                           (= target-order source-order))
                      #t
                      (includes-var (cdr var-list) var)))))

(define (term-match? exp-term1 exp-term2)
        (let ((vars1 (variables exp-term1))
              (vars2 (variables exp-term2)))
             (if (not (= (length vars1) (length vars 2)))
                 #f 
                 (all (map (lambda (var) (includes-var? vars2 var))
                           vars1)))))

(define (collect-termwise exp-term expanded-poly)
        (define (collect-iter term poly accumulator anti-accumulator)
                (cond ((null? poly) (cons accumulator anti-accumulator))
                      ((term-match? exp-term (car poly))
                       (collect-iter term 
                                    (cdr poly)
                                    (make-expanded-term (add (coefficient accumulator)
                                                             (coefficient (car poly)))
                                                        (variables term))
                                    anti-accumulator))
                      (else collect-iter term
                                        (cdr poly)
                                        accumulator 
                                        (cons (car poly) anti-accumulator))))
        (collect-iter exp-term expanded-poly exp-term '()))

(define (collect expanded-poly)
        (if (null? expanded-poly)
            '()
            (let* ((collected (collect-termwise (car expanded-poly) (cdr expanded-poly)))
                   (first-collected (car collected))
                   (poly-minus-collected (cdr collected)))
                  (cons first-collected
                        (collect-termwise (car poly-minus-collected)
                                          (cdr poly-minus-collected))))))

"Part 3: convert back to sparse-poly form. Again, not easy. To be continued..."

(define (expanded-term->sparse-term var expanded-term)
        (let ((vars (variables expanded-term)))
             (if (includes vars var)
                 ())))

(define (expanded-poly->sparse-poly variable expanded-poly))