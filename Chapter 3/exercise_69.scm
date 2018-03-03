(define (display-line x)
  (newline)
  (display x))

(define (display-stream s)
  (stream-for-each display-line s))

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

(stream-ref pythagorean-triples 4)