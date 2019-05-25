"For reference, here is `apply-generic`:"
(define (apply-generic op . args)
        (let ((type-tags (map type-tag args)))
             (let ((proc (get op type-tags)))
                  (if proc
                      (apply proc (map contents args))
                      (if (= (length args) 2)
                          (let ((type1 (car type-tags))
                                (type2 (cadr type-tags))
                                (a1 (car args))
                                (a2 (cadr args)))
                               (let ((t1->t2 (get-coercion type1 type2))
                                     (t2->t1 (get-coercion type2 type1)))
                                    (cond (t1->t2 (apply-generic op 
                                                                 (t1->t2 a1) 
                                                                 a2))
                                          (t2->t1 (apply-generic op
                                                                 a1
                                                                 (t2->t1 a2)))
                                          (else (error "No method for these types"
                                                       (list op type-tags))))))
                          (error "No method for these types"
                                 (list op type-tags)))))))

;Exercise 2.81.  Louis Reasoner has noticed that `apply-generic` may try to coerce the 
;arguments to each other's type even if they already have the same type. Therefore,
;he reasons, we need to put procedures in the coercion table to "coerce" arguments of
;each type to their own type. For example, in addition to the `scheme-number->complex`
;coercion shown above, he would do:

(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)

(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)

(put-coercion 'complex 'complex complex->complex)

;a. With Louis's coercion procedures installed, what happens if `apply-generic` is
;called with two arguments of type `scheme-number` or two arguments of type `complex`
;for an operation that is not found in the table for those types? For example,
;assume that we've defined a generic exponentiation operation:

(define (exp x y) (apply-generic 'exp x y))

;and have put a procedure for exponentiation in the Scheme-number package but not in
;any other package:

  ;; following added to Scheme-number package
(put 'exp '(scheme-number scheme-number)
     (lambda (x y) (tag (expt x y)))) ; using primitive expt

;What happens if we call `exp` with two complex numbers as arguments?

"Let's see..."

(exp z1 z2)

(apply-generic 'exp z1 z2)

"There is no relevant `proc`, so we take the alternative route in the first `if` clause in `apply-generic`..."

(if (= (length args) 2)
    (let ((type1 (car type-tags))
          (type2 (cadr type-tags))
          (a1 (car args))
          (a2 (cadr args)))
         (let ((t1->t2 (get-coercion type1 type2))
               (t2->t1 (get-coercion type2 type1)))
              (cond (t1->t2 (apply-generic op 
                                           (t1->t2 a1) 
                                           a2))
                    (t2->t1 (apply-generic op
                                           a1
                                           (t2->t1 a2)))
                    (else (error "No method for these types"
                                 (list op type-tags))))))
    (error "No method for these types"
           (list op type-tags)))

"Length does equal 2, so..."

(let ((type1 (car type-tags))
      (type2 (cadr type-tags))
      (a1 (car args))
      (a2 (cadr args)))
     (let ((t1->t2 (get-coercion type1 type2))
           (t2->t1 (get-coercion type2 type1)))
          (cond (t1->t2 (apply-generic op 
                                       (t1->t2 a1) 
                                       a2))
                (t2->t1 (apply-generic op
                                       a1
                                       (t2->t1 a2)))
                (else (error "No method for these types"
                             (list op type-tags))))))

"`t1->t2` exists -- it's our new complex->complex procedure, so..."

(apply-generic op 
               (t1->t2 a1) 
               a2)

"which, substituting for the operands, is..."

(apply-generic 'exp (complex->complex z1) z2)

(apply-generic 'exp z1 z2)

"Which is what we have up on line 59. We are stuck in a loop; our procedure will not finish executing."


;b. Is Louis correct that something had to be done about coercion with arguments of the
;same type, or does `apply-generic` work correctly as is?

"As it, `apply-generic` will error with the 'No method for these types' error, when it tries to apply
a procedure on two arguments of the same type for which the procedure is not defined. That is the
desired behaviour. So in that sense, no, it is not the case that something has to be done, and `aply-generic`
works correctly as it is.

On the other hand, it is a tad wasteful, computationally, to try coercing when we can know that there no
coercion will succeed before we try, as in this case. So Louis is right that there is room for improvement."

;c. Modify apply-generic so that it doesn't try coercion if the two arguments have
;the same type.

"I'd change the `if` test on line 7 above like so:"

(and (= (length args) 2) (not (eq? (car args) (cdr args))))

