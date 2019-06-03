;Exercise 2.84.  Using the raise operation of exercise 2.83, modify the `apply-generic`
;procedure so that it coerces its arguments to have the same type by the method of
;successive raising, as discussed in this section. You will need to devise a way to
;test which of two types is higher in the tower. Do this in a manner that is "compatible"
;with the rest of the system and will not lead to problems in adding new levels to the tower.

"This is my way to test which of two types is higher. The procedure returns 1 if the first
parameter is the higher type, 0 if they are the same type, and -1 if the second is higher
than the first."
(define (higher? type1 type2)
        (define tower '(complex, real, rational, integer))
        (define (compare type-list)
                (let ((pivot (car type-list)))
                     (cond ((not pivot) (error "Unknown types: " type1 type2))
                           ((eq? type1 type2) 0)
                           ((eq? pivot type1) 1)
                           ((eq? pivot type2) -1)
                           (else compare (cdr type-list)))))
        (compare tower))


"Here, for reference, is the book's definition of `apply-generic`:"

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


"Here's the new `apply-generic`, using `raise` from exercise 83."

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