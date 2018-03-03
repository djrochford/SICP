(define (square x)
        (* x x))

(define (fast-expt b n)
        (define (fast-expt-iter a b n)
                (cond ((= n 0) a)
                      ((even? n)
                       (fast-expt-iter (* b (/ n 2) a) 
                                       b 
                                       (/ n 2))) 
                      (else (fast-expt-iter (* b a) 
                                            b 
                                            (- n 1)))))
        (fast-expt-iter 1 b n))

(fast-expt 2 89)