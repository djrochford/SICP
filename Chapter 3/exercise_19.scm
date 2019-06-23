;Exercise 3.19.  Redo exercise 3.18 using an algorithm that takes only a constant amount
;of space. (This requires a very clever idea.)

"I'm not sure this qualifies as a very clever idea, but it works:"

(define (cyclic-list? maybe-cyclic)
        (define first (car maybe-cyclic))
        (define (traverse lst)
                (cond ((null? lst) #f)
                      ((eq? (car lst) first) #t)
                      (else (traverse (cdr lst)))))
        (traverse (cdr maybe-cyclic)))

(define A '(a b c))

(cyclic-list? A); #f

(set-cdr! (last-pair A) A)

(cyclic-list? A) ;#t