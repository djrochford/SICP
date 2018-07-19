;Exercise 1.27.  Demonstrate that the Carmichael numbers listed in footnote 47 really do fool the Fermat test. 
;That is, write a procedure that takes an integer n and tests whether a^n is congruent to a modulo n for every a<n, 
;and try your procedure on the given Carmichael numbers.

(define (expmod base exp m)
        (cond ((= exp 0) 1)
              ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                      m))
              (else (remainder (* base (expmod base (- exp 1) m))
                               m))))

(define (fermat-k-test n k)
        (= (expmod k n n) k))

(define (fermat-test-em-all n)
        (define (fermat-loop k)
                (cond ((= k -1) #t)
                      ((fermat-k-test n k) (fermat-loop (- k 1)))
                      (else #f)))
        (fermat-loop (- n 1)))

(fermat-test-em-all 780) ;#f

(fermat-test-em-all 561) ;#t

(fermat-test-em-all 1105) ;#t

(fermat-test-em-all 1729) ;#t

(fermat-test-em-all 2465) ;#t

(fermat-test-em-all 2821) ;#t

(fermat-test-em-all 6601) ;#t