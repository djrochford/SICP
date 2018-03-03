(define (halve n)
        (/ n 2))

(define (double n)
        (* n 2))

(define (fast-multiply a b)
        (cond ((= b 0) 0)
              ((even? b) (double (fast-multiply a (halve b))))
              (else (+ a (fast-multiply a (- b 1))))))

(fast-multiply 90 47)

(define (fast-multiply-iter a b)
        (define (iter sum a b)
                (cond ((= b 0) sum)
                      ((even? b) (iter sum (double a) (halve b)))
                      (else (iter (+ sum a) a (- b 1)))))
      (iter 0 a b))

(fast-multiply-iter 90 47)
