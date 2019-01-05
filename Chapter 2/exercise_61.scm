;Exercise 2.61.  Give an implementation of `adjoin-set` using the ordered representation.
;By analogy with `element-of-set?` show how to take advantage of the ordering 
;to produce a procedure that requires on the average about half as many steps 
;as with the unordered representation.

(define (adjoin-set element set)
        (if (null? set) 
            (list element)
            (let ((head (car set)))
                 (cond ((= element head) set)
                       ((< element head) (cons element set))
                       ((> element head) (cons head 
                                               (adjoin-set element 
                                                           (cdr set))))))))

(adjoin-set 4 '(1 2 3 5)) ;(1 2 3 4 5)