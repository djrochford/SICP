(define integers 
       (cons-stream 1 (add-streams ones integers)))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (add-streams s1 s2)
        (stream-map + s1 s2))

(define (mul-streams s1 s2)
        (stream-map * s1 s2))

(define (scale-stream stream factor)
        (stream-map (lambda (x) (* x factor)) 
                    stream))

(define (integrate-series stream)
        (stream-map / (stream-cdr stream) integers))

(define cosine-series
        (cons-stream 1 (integrate-series sine-series)))
(define sine-series
        (cons-stream 0 (integrate-series (scale-stream cosine-series -1))))

(define (mul-series s1 s2)
        (cons-stream (* (stream-car s1) (stream-car s2)) 
                     (add-streams (scale-stream (stream-cdr s2) 
                                                (stream-car s1))
                                  (mul-series (stream-cdr s1) 
                                              (stream-cdr s2)))))

(define ones-I-hope (add-streams (mul-series cosine-series cosine-series) (mul-series sine-series sine-series)))

(stream-cdr ones-I-hope)
