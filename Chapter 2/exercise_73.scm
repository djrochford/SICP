;Exercise 2.73.  Section 2.3.2 described a program that performs symbolic differentiation:

(define (deriv exp var)
        (cond ((number? exp) 0)
              ((variable? exp) (if (same-variable? exp var) 1 0))
              ((sum? exp) (make-sum (deriv (addend exp) var)
                                    (deriv (augend exp) var)))
              ((product? exp) (make-sum (make-product (multiplier exp)
                                                      (deriv (multiplicand exp) 
                                                             var))
                                        (make-product (deriv (multiplier exp) 
                                                             var)
                                                      (multiplicand exp))))
              ;<more rules can be added here>
              (else (error "unknown expression type -- DERIV" exp))))

;We can regard this program as performing a dispatch on the type of the expression 
;to be differentiated. In this situation the "type tag" of the datum is the algebraic 
;operator symbol (such as `+`) and the operation being performed is `deriv`.
;We can transform this program into data-directed style by rewriting the basic derivative
;procedure as

(define (deriv exp var)
        (cond ((number? exp) 0)
              ((variable? exp) (if (same-variable? exp var) 1 0))
              (else ((get 'deriv (operator exp)) (operands exp)
                                                 var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


;a.  Explain what was done above. Why can't we assimilate the predicates `number?` 
;and `same-variable?` into the data-directed dispatch?
"
In the above `deriv` procedure, in the standard case, it looks up the particular `deriv`
procedure appropriate for the relevant expression, using it's operator, and then applies
that procedure to the expression's operands. The two special cases where this does not happen,
when the expression is a number or a variable, cannot be assimilated into the data-directed
approach because these expressions do not contain an operator, and are thus missing the
`deriv` version of a type-tag.
"

;b.  Write the procedures for derivatives of sums and products,
;and the auxiliary code required to install them in the table used by the program above.

"recall these"
(define (make-sum a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list '+ a1 a2))))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

"We can use them to make this"
(define (deriv-sum summation var)
        (make-sum (deriv (addend summation) var)
                  (deriv (augend summation) var)))

"Similarly, we can use these:"
(define (make-product m1 m2)
                (cond ((or (=number? m1 0) (=number? m2 0)) 0)
                      ((=number? m1 1) m2)
                      ((=number? m2 1) m1)
                      ((and (number? m1) (number? m2)) (* m1 m2))
                      (else (list '* m1 m2))))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
"To make this:"
(define (deriv-product product var) 
        (make-sum (make-product (multiplier expression) 
                                (deriv (multiplicand expression) var))
                  (make-product (deriv (multiplier expression) var)
                                       (multiplicand expression))))

"And we install them both like this:"
(define (install-deriv)
        (put 'deriv '+ deriv-sum)
        (put 'deriv '* deriv-product)
        'done)

;c.  Choose any additional differentiation rule that you like, such as the one for exponents
;(exercise 2.56), and install it in this data-directed system.

"
The rule to which the question is alluding is: d(u^n)/dx = nu^(n-1) (du/dx), which I implemented
in a line in `deriv`, back in 2.56, like this:"
((exponentiation? expression) (make-product (make-product (exponent expression) 
                                                          (make-exponentiation (base expression) 
                                                                               (- (exponent expression) 1)))
                                            (deriv (base expression) var)))
"(which uses these:)"
(define (make-exponentiation base exponent)
        (cond ((=number? exponent 0) 1)
              ((=number? exponent 1) base)
              ((and (number? base) (number? exponent)) (expt base exponent))
              (else (list '** base exponent))))
(define (base e) (cadr e))
(define (exponent e) (caddr e))

"This can be easily transformed into the following procedure"

(define (deriv-exponenentiation exponentation var)
        (make-product (make-product (exponent expression) 
                                    (make-exponentiation (base expression) 
                                                         (- (exponent expression) 1)))
                      (deriv (base expression) var)))

"...which we can install along with the other cases of `deriv`:"
(define (install-deriv)
        (put 'deriv '+ deriv-sum)
        (put 'deriv '* deriv-product)
        (put 'deriv '** deriv-exponenentiation)
        'done)

;d.  In this simple algebraic manipulator the type of an expression is the algebraic operator
;that binds it together. Suppose, however, we indexed the procedures in the opposite way,
;so that the dispatch line in `deriv` looked like

((get (operator exp) 'deriv) (operands exp) var)

;What corresponding changes to the derivative system are required?

"The only change needed is to `install-deriv`, which would put the procedures in the table like so:"
(define (install-deriv)
        (put '+ 'deriv deriv-sum)
        (put '* 'deriv deriv-product)
        'done)