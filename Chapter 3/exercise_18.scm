;Exercise 3.18.  Write a procedure that examines a list and determines whether it
;contains a cycle, that is, whether a program that tried to find the end of the list
;by taking successive cdrs would go into an infinite loop. Exercise 3.13 constructed
;such lists.

(define (cyclic-list? maybe-cyclic)
        (define (traverse lst seen)
                (if (null? lst)
                    #f
                    (let ((current (car lst)))
                         (if (memq current seen) 
                             #t
                             (traverse (cdr lst)
                                       (cons current seen))))))
        (traverse maybe-cyclic '()))

(define A '(a b c))

(cyclic-list? A); #f

(set-cdr! (last-pair A) A)

(cyclic-list? A) ;#t

