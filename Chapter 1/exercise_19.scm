;Exercise 1.19.   There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps. Recall the transformation of the state variables a and b in the fib-iter process of section 1.2.2: a <- a + b and b <- a. 
;Call this transformation T, and observe that applying T over and over again n times, starting with 1 and 0, produces the pair Fib(n + 1) and Fib(n). 
;In other words, the Fibonacci numbers are produced by applying T^n, the nth power of the transformation T, starting with the pair (1,0). 
;Now consider T to be the special case of p = 0 and q = 1 in a family of transformations T_pq, where T_pq transforms the pair (a,b) according to a <- bq + aq + ap and b <- bp + aq. 
;Show that if we apply such a transformation T_pq twice, the effect is the same as using a single transformation T_p'q' of the same form, and compute p' and q' in terms of p and q. 
;This gives us an explicit way to square these transformations, and thus we can compute T_n using successive squaring, as in the fast-expt procedure. 
;Put this all together to complete the following procedure, which runs in a logarithmic number of steps.

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

(fib 345) ;563963353180680437428706474693749258212475354428320807161115873039415970
;(this is the 346th Fib number, on some ways of counting, if you're trying to verify with google)

"Where did the values for p' and q' come from, you ask?
Consider those transforms:
  a <- bq + aq + ap
  b <- bp + aq

Applying those twice we get

a <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
b <- (bp + aq)p + (bq + aq + ap)q
that is
a <- bpq + aq^2 + bq^2 + aq^2 + apq + bpq + apq + ap^2
which is to say
a <- b(2pq + q^2) + a(2pq + q^2) + a(q^2 + p^2)

Similarly
b <- bp^2 + apq + bq^2 + aq^2 + apq
so
b <- b(p^2 + q^2) + a(2pq + q^2)

If you let p` = p^2 + q^2 and q` = 2pq + q^2, and substitute into the above,
you can see that T_pq^2 = Tp`q` -- i.e. another tranform in the T family of transforms."