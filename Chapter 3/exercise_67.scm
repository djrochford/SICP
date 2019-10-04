;Exercise 3.67.  Modify the pairs procedure so that (pairs integers integers)
;will produce the stream of all pairs of integers (i,j) (without the condition i < j).
;Hint: You will need to mix in an additional stream.

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
                           (stream-car t)) ; top left-hand corner of table
                     (interleave (interleave (stream-map (lambda (x) (list (stream-car s) x))
                                                         (stream-cdr t)); top row of table
                                             (stream-map (lambda (x) (list x (stream-car t)))
                                                         (stream-cdr s))) ; left column of table
                                 (pairs (stream-cdr s)
                                        (stream-cdr t))))) ; rest of table

(define all-pairs (pairs integers integers))

(stream-ref all-pairs 40) ;(7 2)

