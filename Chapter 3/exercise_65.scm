;Exercise 3.65.  Use the series

; ln 2 = 1 - 1/2 + 1/3 - 1/4 + ...

;to compute three sequences of approximations to the natural logarithm of 2,
;in the same way we did above for. How rapidly do these sequences converge?

"For reference: ln 2 is 0.69314718056"

"First sequence:"

(define (add-streams s1 s2)
        (stream-map + s1 s2))

(define (partial-sums stream)
        (define ps (add-streams stream (cons-stream 0 ps)))
        ps)

(define (log-2-terms n)
        (cons-stream (* (expt -1 (- n 1)) (/ 1.0 n))
                     (log-2-terms (+ n 1))))

(define log-2-stream
        (partial-sums (log-2-terms 1)))

(stream-ref log-2-stream 10) ; .7365440115440116

(stream-ref log-2-stream 100) ; .6980731694092049

"Not very fast."

(define (euler-transform s)
        (let ((s0 (stream-ref s 0))           ; Sn-1
              (s1 (stream-ref s 1))           ; Sn
              (s2 (stream-ref s 2)))          ; Sn+1
             (cons-stream (- s2 
                             (/ (square (- s2 s1))
                                (+ s0 (* -2 s1) s2)))
                          (euler-transform (stream-cdr s)))))

(define super-log-2-stream (euler-transform log-2-stream))

(stream-ref super-log-2-stream 10) ;.6932106782106783

"Way faster"

(define (make-tableau transform s)
        (cons-stream s
                     (make-tableau transform
                                   (transform s))))

(define (accelerated-sequence transform s)
        (stream-map stream-car
                    (make-tableau transform s)))

(define super-duper-log-2-stream
        (accelerated-sequence euler-transform log-2-stream))

(stream-ref super-duper-log-2-stream 4) ;.6931471960735491

"Really very fast."