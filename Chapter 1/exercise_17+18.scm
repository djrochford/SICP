;Exercise 1.17.  The exponentiation algorithms in this section are based on performing exponentiation by means of repeated multiplication. In a similar way, one can perform integer multiplication by means of repeated addition. The following multiplication procedure (in which it is assumed that our language can only add, not multiply) is analogous to the expt procedure:

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

;This algorithm takes a number of steps that is linear in b. Now suppose we include, together with addition, operations double, which doubles an integer, and halve, which divides an (even) integer by 2. Using these, design a multiplication procedure analogous to fast-expt that uses a logarithmic number of steps.


(define (halve n)
        (/ n 2))

(define (double n)
        (* n 2))

(define (fast-multiply a b)
        (cond ((= b 0) 0)
              ((even? b) (double (fast-multiply a (halve b))))
              (else (+ a (fast-multiply a (- b 1))))))

(fast-multiply 90 47) ; 4230

(define (fast-multiply-iter a b)
        (define (iter sum a b)
                (cond ((= b 0) sum)
                      ((even? b) (iter sum (double a) (halve b)))
                      (else (iter (+ sum a) a (- b 1)))))
      (iter 0 a b))

(fast-multiply-iter 90 47) ; 4230
