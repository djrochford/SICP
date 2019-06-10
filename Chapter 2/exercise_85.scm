;Exercise 2.85.  This section mentioned a method for "simplifying" a data object
;by lowering it in the tower of types as far as possible. Design a procedure `drop`
;that accomplishes this for the tower described in exercise 2.83. The key is to
;decide, in some general way, whether an object can be lowered. For example, the
;complex number 1.5 + 0i can be lowered as far as real, the complex number 1 + 0i
;can be lowered as far as integer, and the complex number 2 + 3i cannot be lowered at all.
;Here is a plan for determining whether an object can be lowered: Begin by defining
;a generic operation `project` that "pushes" an object down in the tower.
;For example, projecting a complex number would involve throwing away the imaginary part.


(define (project number)
        (apply-generic 'project number))

(put 'project 'complex (lambda (z) (make-real (real-part z))))

(put 'project 
     'real 
     (lambda (x) (let* ((integer-part (floor x))
                        (fractional-part (- x integer-part))
                        (up-to-thousandth (floor (* fractional-part 1000)))) ;we lose anything after the third decimal))
                       (make-rational (+ (* integ-part 1000) up-to-thousandth) 1000))))
"The real version of project a) maps all real numbers that are the same after the third decimal place
to the same rational number, and b) always maps a real number to rational with 1000 as the
denominator. This is liabel to not be the simplest form of the rational. But such is life."

(put 'project 'rational (lambda (q) (round (/ (numerator q) (denominator q)))))

;Then a number can be dropped if, when we project it and raise the result back to the
;type we started with, we end up with something equal to what we started with.
;Show how to implement this idea in detail, by writing a `drop` procedure that drops
;an object as far as possible. You will need to design the various projection operations
;and install `project` as a generic operation in the system.
;You will also need to make
;use of a generic `equality` predicate, such as described in exercise 2.79.

(define (drop x)
        (define (try-project y)
                (let* ((projected (project y))
                       (unprojected (raise projected)))
                      (if (equals? unprojected y)
                          projected
                          #f)))
        (let ((maybe-projected (try-project x)))
             (if maybe-projected
                 (drop maybe-projected)
                 x)))

;Finally, use `drop` to rewrite `apply-generic` from exercise 2.84 so that it ``simplifies''
;its answers.

"Here's `apply-generic`, as of last time we saw it in 2.84."

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
                                (cond ((eq? (higher? a1 a2) 1)
                                       (apply-generic op a1 (raise a2)))
                                      ((eq? (higher a1 a2) -1)
                                       (apply-generic op (raise a1) a2))
                                      (else (error "No method for these types"
                                                   (list op type-tags)))))
                          (error "No method for these types"
                                 (list op type-tags)))))))

"To make it simplify it's answer, we just add something to line 58, where the answer gets spit out":

(define (apply-generic op . args)
        (let ((type-tags (map type-tag args)))
             (let ((proc (get op type-tags)))
                  (if proc
                      (drop (apply proc (map contents args))) ;change here.
                      (if (= (length args) 2)
                          (let ((type1 (car type-tags))
                                (type2 (cadr type-tags))
                                (a1 (car args))
                                (a2 (cadr args)))
                                (cond ((eq? (higher? a1 a2) 1)
                                       (apply-generic op a1 (raise a2)))
                                      ((eq? (higher a1 a2) -1)
                                       (apply-generic op (raise a1) a2))
                                      (else (error "No method for these types"
                                                   (list op type-tags)))))
                          (error "No method for these types"
                                 (list op type-tags)))))))

