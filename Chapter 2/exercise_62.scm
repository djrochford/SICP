;Exercise 2.62.  Give a Theta(n) implementation of `union-set` for sets represented as ordered lists.

(define (union-set set1 set2)
        (cond ((null? set2) set1)
              ((null? set1) set2)
              (else (let ((head1 (car set1)) (head2 (car set2)))
                         (cond ((= head1 head2) (cons head1
                                                      (union-set (cdr set1) 
                                                                 (cdr set2))))
                               ((< head1 head2) (cons head1
                                                      (union-set (cdr set1)
                                                                 set2)))
                               ((> head1 head2) (cons head2
                                                      (union-set set1
                                                                 (cdr set2)))))))))

(union-set '(1 3 7 9) '(1 2 4 7 8)) ;(1 2 3 4 7 8 9)
