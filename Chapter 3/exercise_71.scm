;Exercise 3.71.  Numbers that can be expressed as the sum of two cubes in more
;than one way are sometimes called Ramanujan numbers, in honor of the mathematician
;Srinivasa Ramanujan. Ordered streams of pairs provide an elegant solution to the
;problem of computing these numbers. To find a number that can be written as the sum
;of two cubes in two different ways, we need only generate the stream of pairs of
;integers (i,j) weighted according to the sum i^3 + j^3 (see exercise 3.70), then search
;the stream for two consecutive pairs with the same weight. Write a procedure to generate
;the Ramanujan numbers.

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

(define (sum-of-cubes pair)
        (+ (expt (car pair) 3)
           (expt (cadr pair) 3)))

(define (add-streams s1 s2)
        (stream-map + s1 s2))

(define ones (cons-stream 1 ones))

(define integers (cons-stream 1 (add-streams ones integers)))

(define ordered-pairs (weighted-pairs integers integers sum-of-cubes))

(define (find-Ramanujan s)
        (let ((first (stream-car s))
              (second (stream-car (stream-cdr s))))
             (if (= (sum-of-cubes first)
                    (sum-of-cubes second))
                 (cons-stream (sum-of-cubes first)
                              (find-Ramanujan (stream-cdr (stream-cdr s))))
                 (find-Ramanujan (stream-cdr s)))))



(define Ramanujan (find-Ramanujan ordered-pairs))

(stream-ref Ramanujan 0) ; 1729

;The first such number is 1,729. What are the next five?

(stream-ref Ramanujan 1) ; 4104
(stream-ref Ramanujan 2) ; 13832
(stream-ref Ramanujan 3) ; 20683
(stream-ref Ramanujan 4) ; 32832
(stream-ref Ramanujan 5) ; 39312


