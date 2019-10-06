;Exercise 3.72.  In a similar way to exercise 3.71 generate a stream of all
;numbers that can be written as the sum of two squares in three different ways
;(showing how they can be so written).

(define (merge-weighted s1 s2 weight)
        (cond ((stream-null? s1) s2)
              ((stream-null? s2) s1)
              (else (let ((s1car (stream-car s1))
                          (s2car (stream-car s2)))
                         (if (<= (weight s1car) (weight s2car))
                             (cons-stream s1car 
                                          (merge-weighted (stream-cdr s1) 
                                                          s2
                                                          weight))
                             (cons-stream s2car
                                          (merge-weighted s1 
                                                          (stream-cdr s2)
                                                          weight)))))))

(define (weighted-pairs s t weight)
        (cons-stream (list (stream-car s) 
                           (stream-car t))
                     (merge-weighted (stream-map (lambda (x) 
                                                         (list (stream-car s)
                                                               x))
                                                 (stream-cdr t))
                                     (weighted-pairs (stream-cdr s)
                                                     (stream-cdr t)
                                                     weight)
                                     weight)))

(define (sum-of-squares pair)
        (+ (expt (car pair) 2)
           (expt (cadr pair) 2)))

(define (add-streams s1 s2)
        (stream-map + s1 s2))

(define ones (cons-stream 1 ones))

(define integers (cons-stream 1 (add-streams ones integers)))

(define ordered-pairs (weighted-pairs integers integers sum-of-squares))

(define (find-pseudo-Ramanujan s)
        (let ((first (stream-car s))
              (second (stream-car (stream-cdr s)))
              (third (stream-car (stream-cdr (stream-cdr s)))))
             (if (= (sum-of-squares first)
                    (sum-of-squares second)
                    (sum-of-squares third))
                 (cons-stream (list first second third (sum-of-squares first))
                              (find-pseudo-Ramanujan (stream-cdr (stream-cdr (stream-cdr s)))))
                 (find-pseudo-Ramanujan (stream-cdr s)))))

(define pseudo-Ramanujan (find-pseudo-Ramanujan ordered-pairs))

(stream-ref pseudo-Ramanujan 0) ;((1 18) (6 17) (10 15) 325)
(stream-ref pseudo-Ramanujan 1) ;((5 20) (8 19) (13 16) 425)