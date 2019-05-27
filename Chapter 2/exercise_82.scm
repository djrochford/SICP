;Exercise 2.82.  Show how to generalize `apply-generic` to handle coercion
;in the general case of multiple arguments. One strategy is to attempt to 
;coerce all the arguments to the type of the first argument, then to the 
;type of the second argument, and so on.

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

"Here is a generalisation of the above proedure for multiple arguments that follows
the suggested strategy:"

(define (apply-generic op . args)

        (define (coercion-factory target-type)
                (lambda (source-type) (get-coercion source-type 
                                                    target-type)))

        (define (get-coercions target-type type-tags)
                (let ((coercion-getter (coercion-factory target-type)))
                     (map coercion-getter type-tags)))

        (define (list-apply procs values)
                (if (not (null? procs))
                    (cdr ((car procs) (car values))
                         (list-apply (cdr procs) (cdr values)))))

        (define (no-falsies some-list)
                (or (null? some-list)
                    (not (car some-list))
                    (no-falsies (cdr some-list))))

        (define (list-equals? list1 list2)
                (if (not (eq? (car list1) (car list2)))
                    #f
                    (list-equals? (cdr list1) (cdr list2))))

        (define (coerce-in-turn type-tags contents)
                (define (try target-type)
                        (let ((coercions (get-coercions type-tags)))
                             (if (no-falsies coercions)
                                 (list-apply coercions contents)
                                 #f)))
                (define (loop tags-to-try)
                        (if (null? tags-to-try)
                            (error "No method for these types"
                                   (list op type-tags))
                            (let ((maybe-coerced (try (car tags-to-try))))
                                 (if (and maybe-coerced
                                          (not (list-equals? contents maybe-coerced)))
                                     (apply-generic op maybe-coerced)
                                     (loop (cdr tags-to-try))))))
                (loop type-tags))

        (let ((type-tags (map type-tag args)))
             (let ((proc (get op type-tags))
                   (contents (map contents args)))
                  (if proc
                      (apply proc contents)
                      (coerce-in-turn type-tags contents)))))

"(Note that this code assumes that we *do* have coercion-prcoedures in the table for coercing
a value to it's own type, à la Louis Reasoner's idea in exercise 81. The `list-equals?` check
is to stop the end-less loop that can cause.)"

;Give an example of a situation where
;this strategy (and likewise the two-argument version given above) is not
;sufficiently general. (Hint: Consider the case where there are some suitable 
;mixed-type operations present in the table that will not be tried.)
"Suppose we have argument of types A, A and B. Suppose there exists a procedure
for types A, B and B. That procedure will not be found by the above strategy; finding
it requires treating the first and second parameters differently, and the strategy
never does that."

