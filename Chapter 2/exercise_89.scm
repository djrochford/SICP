;Exercise 2.89.  Define procedures that implement the term-list representation described
;above as appropriate for dense polynomials.

"The main difference is that we can't tell the order of an element of the term list 
just by looking at that element; we need the whole list. "

"This procedure tells us the order of the first term in a term-list."
(define (order term-list)
        (- (length term-list) 1))

"To adjoin a term, we must pass in both the coefficient and the order, seperately."
(define (adjoin-term term-coeff term-order term-list)
        (cond ((=zero? term-coeff) term-list)
              ((= term-order (+ (order term-list) 1)) (cons term-coeff term-list))
              (else (adjoin-term term-coeff term-order (cons 0 term-list)))))

"The rest of the necessary changes follow..."

(define (add-terms L1 L2)
        (cond ((empty-termlist? L1) L2)
              ((empty-termlist? L2) L1)
              (else (let ((t1 (first-term L1)) 
                          (t2 (first-term L2)) 
                          (o1 (order L1))
                          (o2 (order L2)))
                         (cond ((> o1 o2) (adjoin-term t1 
                                                       o1 
                                                       (add-terms (rest-terms L1)
                                                                  L2)))
                               ((< o1 o2) (adjoin-term t2 
                                                       o2 
                                                       (add-terms L1
                                                                  (rest-terms L2))))
                               (else (adjoin-term (add t1 t2) 
                                                  o1
                                                  (add-terms (rest-terms L1)
                                                             (rest-terms L2)))))))))


(define (mul-terms L1 L2)
        (if (empty-termlist? L1)
            (the-empty-termlist)
            (add-terms (mul-term-by-all-terms (first-term L1) (order L1) L2)
                       (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 o1 L)
        (if (empty-termlist? L)
            (the-empty-termlist)
            (let ((t2 (first-term L)) (o2 (order L)))
                 (adjoin-term (mul t1 t2)
                              (+ o1 o2)
                              (mul-term-by-all-terms t1
                                                     (rest-terms L))))))