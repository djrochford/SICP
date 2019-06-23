;Exercise 3.19.  Redo exercise 3.18 using an algorithm that takes only a constant amount
;of space. (This requires a very clever idea.)

"This uses an idea I did not come up with; it's sometime called the 'Tortoise and Hare'
algorithm. The first appearance in print is in Knuth, though he attributes it to Robert Floyd."

(define (cyclic-list? maybe-cyclic)
        (define (forward-one lst)
                (cdr lst))
        (define (forward-two lst)
                (cddr lst))
        (define (race lst1 lst2)
                (cond ((or (null? lst1) (null? lst2) (null? (cdr lst2))) #f)
                      ((eq? (car lst1) (car lst2)) #t)
                      (else (race (forward-one lst1) (forward-two lst2)))))
        
        (race maybe-cyclic (cdr maybe-cyclic)))

(define A '(a b c))

(cyclic-list? A); #f

(set-cdr! (last-pair A) A)

(cyclic-list? A) ;#t

(define B (cons 'd A))

(cyclic-list? B) ;#t

(define C (cons 'e B))

(cyclic-list? C) ;#t


