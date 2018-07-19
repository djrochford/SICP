;Exercise 1.25.  Alyssa P. Hacker complains that we went to a lot of extra work in writing expmod. After all, she says, since we already know how to compute exponentials, we could have simply written

(define (fast-expt b n)
        (cond ((= n 0) 1)
              ((even? n) (square (fast-expt b (/ n 2))))
              (else (* b (fast-expt b (- n 1))))))


(define (expmod base exp m)
        (remainder (fast-expt base exp) m))

;Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

"For comparison, the other expmod, which Alyssa is complaining about, is"
(define (expmod base exp m)
        (cond ((= exp 0) 1)
              ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                      m))
              (else (remainder (* base (expmod base (- exp 1) m))
                               m))))  

"Alyssa procedure is not as good as the original `expmod` procedure for large inputs. Alyssa's expmod involves calculating
the entirety of base^exp, before finding the modulus; that could, potentially, mean that Alyssa's expomd is dealing with huge
numbers. The original expmod, on the other hand, reduces the number it is modding as it goes, and never needs to calculate
with numbers a lot bigger than m.

The reduction in the original expmod is making use of the fact that xy modulo m = ((x modulo m) * (y modulo m)) modulo m, as footnote
46 says."