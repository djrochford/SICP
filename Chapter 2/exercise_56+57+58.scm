"Needed for the below exercises: the differentation code:"

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
        (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? expression num)
        (and (number? expression) (= expression num)))

(define (make-sum a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list '+ a1 a2))))

(define (make-product m1 m2)
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (list '* m1 m2))))

(define (sum? x)
        (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
        (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (deriv expression var)
        (cond ((number? expression) 0) 
              ((variable? expression) (if (same-variable? expression var) 1 0))
              ((sum? expression) (make-sum (deriv (addend expression) var)
                                    (deriv (augend expression) var)))
              ((product? expression) (make-sum (make-product (multiplier expression) 
                                                      (deriv (multiplicand expression) var))
                                        (make-product (deriv (multiplier expression) var)
                                                      (multiplicand expression))))
              (else (error "unknown expression type -- DERIV" expression))))

;Exercise 2.56.  Show how to extend the basic differentiator to handle more kinds of expressions.
;For instance, implement the differentiation rule

;d(u^n)/dx = nu^(n-1) (du/dx)

;by adding a new clause to the `deriv` program and defining appropriate procedures `exponentiation?`,
;`base`, `exponent`, and `make-exponentiation`. 
;(You may use the symbol ** to denote exponentiation.)
;Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.

(define (make-exponentiation base exponent)
        (cond ((=number? exponent 0) 1)
              ((=number? exponent 1) base)
              ((and (number? base) (number? exponent)) (expt base exponent))
              (else (list '** base exponent))))


(define (exponentiation? x)
        (and (pair? x) (eq? (car x) '**)))

(define (base p) (cadr p))

(define (exponent p) (caddr p))

"Now to add a clause to `deriv`:"

(define (deriv expression var)
        (cond ((number? expression) 0)
              ((variable? expression) (if (same-variable? expression var) 1 0))
              ((sum? expression) (make-sum (deriv (addend expression) var)
                                    (deriv (augend expression) var)))
              ((product? expression) (make-sum (make-product (multiplier expression) 
                                                      (deriv (multiplicand expression) var))
                                        (make-product (deriv (multiplier expression) var)
                                                      (multiplicand expression))))
              ((exponentiation? expression) (make-product (make-product (exponent expression) 
                                                                        (make-exponentiation (base expression) 
                                                                                             (- (exponent expression) 1)))
                                                          (deriv (base expression) var)))
              (else (error "unknown expression type -- DERIV" expression))))

(deriv '(+ (** x 2) (* x 2)) 'x) ; (+ (* 2 x) 2)

;Exercise 2.57. Extend the differentiation program to handle sums and products of arbitrary numbers of 
;(two or more) terms. Then the last example above [`(deriv '(* (* x y) (+ x 3)) 'x)`] could be expressed as

;(deriv '(* x y (+ x 3)) 'x)

;Try to do this by changing only the representation for sums and products,
;without changing the deriv procedure at all.
;For example, the addend of a sum would be the first term, and the augend would be the sum of the rest of the terms.

(define (augend s)
        (let ((last-bit (cddr s)))
             (if (null? (cdr last-bit))
                 (car last-bit)
                 (make-sum (car last-bit) (cadr last-bit)))))

(define (multiplicand m)
        (let ((last-bit (cddr m)))
             (if (null? (cdr last-bit))
                 (car last-bit)
                 (make-product (car last-bit) (cadr last-bit)))))

(deriv '(* x y (+ x 3)) 'x) ; (+ (* x y) (* y (+ x 3)))


;Exercise 2.58.  Suppose we want to modify the differentiation program so that it works with ordinary mathematical notation, 
;in which + and * are infix rather than prefix operators. 
;Since the differentiation program is defined in terms of abstract data, 
;we can modify it to work with different representations of expressions solely by changing the predicates, 
;selectors, and constructors that define the representation 
;of the algebraic expressions on which the differentiator is to operate.

;a. Show how to do this in order to differentiate algebraic expressions presented in infix form,
;such as `(x + (3 * (x + (y + 2))))`. 
;To simplify the task, assume that + and * always take two arguments and that expressions are fully parenthesized.

(define (make-sum a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list a1 '+ a2)))) ; change here

(define (make-product m1 m2)
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (list m1 '* m2)))) ; change here

(define (sum? x)
        (and (pair? x) (eq? (cadr x) '+))) ;note `cadr`, not `car`

(define (addend s) (car s)) ;note `car`, not `cadr`

(define (product? x)
        (and (pair? x) (eq? (cadr x) '*))) ;`cadr` for `car`

(define (multiplier p) (car p)) ;`car` for `cadr`


(deriv '(x + (3 * (x + (y + 2)))) 'x) ;4


;b. The problem becomes substantially harder if we allow standard algebraic notation, 
;such as `(x + 3 * (x + y + 2))`, which drops unnecessary parentheses 
;and assumes that multiplication is done before addition.
;Can you design appropriate predicates, selectors, and constructors for this notation
;such that our derivative program still works?

"Certainly!"

"Some helper functions"
(define (singleton? thing)
        (and (pair? thing) (null? (cdr thing))))

(define (maybe-pop-singleton thing)
        (if (singleton? thing)
            (car thing)
            thing))

"And now the predicates and selectors (no need for new constructors, on my implementation at least)."
(define (sum? x)
        (and (pair? x) (memq '+ x)))

(define (product? x)
        (and (pair? x) (not (memq '+ x))))

(define (addend s)
        (define (iter thusfar remaining)
                (if (eq? (car remaining) '+)
                    (maybe-pop-singleton thusfar)
                    (iter (append thusfar (list (car remaining))) 
                          (cdr remaining))))
        (iter (list (car s)) (cdr s)))

(define (augend s)
        (maybe-pop-singleton (cdr (memq '+ s))))

(deriv '(x + 3 * (x + y + 2)) 'x) ;4
