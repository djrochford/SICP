(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
        (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? expression num)
        (and (number? expression) (= expression num)))

(define (make-sum a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list a1 '+ a2))))

(define (make-product m1 m2)
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (list m1 '* m2))))

(define (make-exponentiation base exponent)
        (cond ((=number? exponent 0) 1)
              ((=number? exponent 1) base)
              ((and (number? base) (number? exponent)) (expt base exponent))
              (else (list base '** exponent))))

(define (sum? x)
        (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (caddr s))

(define (product? x)
        (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p) (caddr p))

(define (exponentiation? x)
        (and (pair? x) (eq? (cadr x) '**)))

(define (base p) (car p))

(define (exponent p) (caddr p))

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

(deriv '((x ** 2) + (x * 2)) 'x)