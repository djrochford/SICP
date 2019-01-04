;Exercise 2.59.  Implement the union-set operation for the unordered-list representation of sets.

"The `element-of-set` function, from the book, will be handy:"
(define (element-of-set? x set)
        (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

"Now here's an answer:"
(define (union-set set1 set2)
        (cond ((null? set2) set1)
              ((null? set1) set2)
              ((element-of-set? (car set1) set2) (union-set (cdr set1) set2))
              (else (cons (car set1) (union-set (cdr set1) set2)))))

(union-set '(1 2 3 4) '(1 3 5 9)) ;(2 4 1 3 5 9)