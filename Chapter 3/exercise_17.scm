;Exercise 3.17.  Devise a correct version of the count-pairs procedure of exercise 3.16
;that returns the number of distinct pairs in any structure. (Hint: Traverse the structure,
;maintaining an auxiliary data structure that is used to keep track of which pairs have
;already been counted.)

(define (count-pairs structure)
        (define seen '())
        (define (traverse sub-structure)
                (if (or (memq sub-structure seen)
                        (not (pair? sub-structure)))
                    0
                    (begin (set! seen (cons sub-structure seen))
                            (+ 1 
                               (traverse (car sub-structure))
                               (traverse (cdr sub-structure))))))
        (traverse structure))

"To test:"

(define threefer '(a b c))
(count-pairs threefer) ;3

(define end '(a))
(define middle (cons end end))
(define fourbee (list middle))
(count-pairs fourbee); 3

(define sevens (cons middle middle))
(count-pairs sevens); 3