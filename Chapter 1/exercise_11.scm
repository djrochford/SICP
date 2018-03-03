(define (f n)
        (if (< n 3)
            n
            (+ (f (- n 1))
               (* 2 
                  (f (- n 2)))
               (* 3
                  (f (- n 3))))))

(define (g n)
        (define (f-iter a b c i)
                  (cond ((= i 0) a)
                        ((= i 1) b)
                        ((= i 2) c)
                        (else (f-iter b 
                                      c 
                                      (+ (* 3 a)
                                         (* 2 b)
                                         c)  
                                      (- i 1)))))
        (f-iter 0 1 2 n))

(g 30)
(f 30)

