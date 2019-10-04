;Exercise 3.69.  Write a procedure `triples` that takes three infinite streams,
;S, T, and U, and produces the stream of triples (S_i,T_j,U_k) such that i < j < k.
;Use `triples` to generate the stream of all Pythagorean triples of positive integers,
;i.e., the triples (i,j,k) such that i < j and i^2 + j^2 = k2.

(define (add-streams s1 s2)
        (stream-map + s1 s2))

(define ones
        (cons-stream 1 ones))

(define integers
        (cons-stream 1 (add-streams ones integers)))

(define (interleave s1 s2)
        (if (stream-null? s1)
            s2
            (cons-stream (stream-car s1)
                         (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
        (cons-stream (list (stream-car s) 
                           (stream-car t))
                     (interleave (stream-map (lambda (x) (list (stream-car s) x))
                                             (stream-cdr t))
                                 (pairs (stream-cdr s) 
                                             (stream-cdr t)))))

(define (triples s t u)
        (cons-stream (list (stream-car s)
                           (stream-car t)
                           (stream-car u))
                     (interleave (stream-map (lambda (x) (cons (stream-car s) x))
                                             (stream-cdr (pairs t u)))
                                 (triples (stream-cdr s)
                                          (stream-cdr t)
                                          (stream-cdr u)))))

(define (pythagorean? triple)
        (define (square n)
                (* n n))
        (let ((i (car triple))
              (j (cadr triple))
              (k (caddr triple)))
             (= (+ (square i) (square j)) (square k))))

(define pythagorean-triples
        (stream-filter pythagorean? (triples integers integers integers)))

(stream-ref pythagorean-triples 1) ;(6 8 10)

(stream-ref pythagorean-triples 2) ;(5 12 13)