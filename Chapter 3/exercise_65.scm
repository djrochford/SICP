(define (partial-sums stream)
        (define ps (add-streams stream (cons-stream 0 ps)))
        ps)

(define (log-2-terms n)
        (cons-stream (* (expt -1 (- n 1)) (/ 1.0 n))
                     (log-2-terms (+ n 1))))

(define log-2-stream
        (partial-sums (log-2-terms 1)))

(define (euler-transform s)
        (let ((s0 (stream-ref s 0))           ; Sn-1
              (s1 (stream-ref s 1))           ; Sn
              (s2 (stream-ref s 2)))          ; Sn+1
             (cons-stream (- s2 
                             (/ (square (- s2 s1))
                                (+ s0 (* -2 s1) s2)))
                          (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
        (cons-stream s
                     (make-tableau transform
                                   (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

(define super-log-2-sequence
        (accelerated-sequence euler-transform log-2-stream))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(display-stream super-log-2-sequence)