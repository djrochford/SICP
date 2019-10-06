;Exercise 3.70.  It would be nice to be able to generate streams in which the pairs
;appear in some useful order, rather than in the order that results from an ad hoc
;interleaving process. We can use a technique similar to the merge procedure of
;exercise 3.56, if we define a way to say that one pair of integers is ``less than''
;another. One way to do this is to define a ``weighting function'' W(i,j) and stipulate
;that (i_1,j_1) is less than (i_2,j_2) if W(i_1,j_1) < W(i_2,j_2). Write a procedure
;`merge-weighted` that is like merge, except that `merge-weighted` takes an additional
;argument `weight`, which is a procedure that computes the weight of a pair, and is used
;to determine the order in which elements should appear in the resulting merged stream.


"For referece, here is the original `merge`:"

(define (merge s1 s2)
        (cond ((stream-null? s1) s2)
              ((stream-null? s2) s1)
              (else (let ((s1car (stream-car s1))
                          (s2car (stream-car s2)))
                         (cond ((< s1car s2car)
                                (cons-stream s1car 
                                             (merge (stream-cdr s1) 
                                                    s2)))
                               ((> s1car s2car)
                                (cons-stream s2car 
                                             (merge s1 
                                                    (stream-cdr s2))))
                               (else (cons-stream s1car
                                                  (merge (stream-cdr s1)
                                                         (stream-cdr s2)))))))))
"The weighted version is very similar:"
(define (merge-weighted s1 s2 weight)
        (cond ((stream-null? s1) s2)
              ((stream-null? s2) s1)
              (else (let ((s1car (stream-car s1))
                          (s2car (stream-car s2)))
                         (cond ((<= (weight s1car) (weight s2car))
                                (cons-stream s1car 
                                             (merge-weighted (stream-cdr s1) 
                                                             s2
                                                             weight)))
                               ((> (weight s1car) (weight s2car))
                                (cons-stream s2car 
                                             (merge-weighted s1 
                                                             (stream-cdr s2)
                                                             weight))))))))


;Using this, generalize `pairs` to a procedure `weighted-pairs` that takes two streams,
;together with a procedure that computes a weighting function, and generates the stream
;of pairs, ordered according to weight.

"Here is `pairs`:"

(define (pairs s t)
        (cons-stream (list (stream-car s) 
                           (stream-car t))
                     (interleave (stream-map (lambda (x) 
                                                     (list (stream-car s) x))
                                             (stream-cdr t))
                                 (pairs (stream-cdr s) (stream-cdr t)))))

"And here`weighted-pairs`:"

(define (weighted-pairs s t weight)
        (cons-stream (list (stream-car s) 
                           (stream-car t))
                     (merge-weighted (interleave (stream-map (lambda (x) 
                                                                     (list (stream-car s)
                                                                           x))
                                                             (stream-cdr t))
                                                 (pairs (stream-cdr s)
                                                        (stream-cdr t))))))
"Note this only works on the assumption (made in the text in a footnote) that the weights
increase as you move out along a row and down along a column. This problem is *much* harder
if that assumption is relaxed, and in fact unsolvable in full generality (because things may
be weighted such that for some value v, infinitely many values weigh less than v)."

;Use your procedure to generate

;a. the stream of all pairs of positive integers (i,j) with i < j ordered according to the sum i + j

(define sum-pairs 
       (weighted-pairs integers 
                       integers 
                       (lambda (pair) 
                               (+ (car pair) 
                                  (cdr pair)))))


;b. the stream of all pairs of positive integers (i,j) with i < j, where neither i nor j is
;divisible by 2, 3, or 5, and the pairs are ordered according to the sum 2 i + 3 j + 5 i j.

(define (not-div-by-2-3-5 n)
        (not (or (= (remainder n 2) 0)
                 (= (remainder n 3) 0)
                 (= (remainder n 5) 0))))


(define filtered-ints (stream-filter not-div-by-2-3-5 
                                     integers))

(define (235-weight pair)
        (let ((i (car pair))
              (j (cdr pair)))
             (+ (* 2 i)
                (* 3 j)
                (* 5 i j))))

(define 235-ordered-pairs
        (weighted-pairs filtered-ints
                        filtered-ints
                        235-weight))