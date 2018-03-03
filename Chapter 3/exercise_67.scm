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

(define (some-pairs s t)
        (cons-stream (list (stream-car s) 
                           (stream-car t))
                     (interleave (stream-map (lambda (x) (list (stream-car s) x))
                                             (stream-cdr t))
                                 (some-pairs (stream-cdr s) 
                                             (stream-cdr t)))))


(define (pairs s t)
        (cons-stream (list (stream-car s) 
                           (stream-car t))
                     (interleave (interleave (stream-map (lambda (x) (list (stream-car s) x))
                                                         (stream-cdr t))
                                             (stream-map (lambda (x) (list x (stream-car t)))
                                                         (stream-cdr s)))
                                 (pairs (stream-cdr s)
                                        (stream-cdr t)))))

(display-stream (pairs integers integers))

