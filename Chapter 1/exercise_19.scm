(define (fib n)
        (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
        (cond ((= count 0) b)
              ((even? count) (fib-iter a
                                       b
                                       (+ (* p p) (* q q)) ; compute p’
                                       (+ (* 2 p q) (* q q)) ; compute q’
                                       (/ count 2)))
              (else (fib-iter (+ (* b q) (* a q) (* a p))
                              (+ (* b p) (* a q))
                              p
                              q
                              (- count 1)))))

(fib 345)

;a <- bq + aq + ap
;b <- bp + aq

;apply twice

;a <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;b <- (bp + aq)p + (bq + aq + ap)q

;bpq + aq^2 + bq^2 + aq^2 + apq + bpq + apq + ap^2
;b(2pq + q^2) + a(2pq + q^2) + a(q^2 + p^2)

;bp^2 + apq + bq^2 + aq^2 + apq
;b(p^2 + q^2) + a(2pq + q^2)