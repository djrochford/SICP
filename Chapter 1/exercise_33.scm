;Exercise 1.33.  You can obtain an even more general version of accumulate (exercise 1.32) 
;by introducing the notion of a *filter* on the terms to be combined. 
;That is, combine only those terms derived from values in the range that satisfy a specified condition. 
;The resulting filtered-accumulate abstraction takes the same arguments as accumulate, 
;together with an additional predicate of one argument that specifies the filter. 
;Write filtered-accumulate as a procedure. 

 (define (filtered-accumulate combiner null-value term a next b filter)
        (define (iter a result)
                (if (> a b)
                    result
                    (iter (next a) 
                          (combiner (if (filter a)
                                        (term a)
                                        null-value)
                                    result))))
        (iter a null-value))

;Show how to express the following using filtered-accumulate:

;a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate already written)

(define (inc n)
        (+ n 1))

(define (sum-o-prime-squares a b)
        (filtered-accumulate + 0 square a inc b prime?))

;b. the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1).

(define (gcd n m)
        (if (= m 0)
            n
            (gcd m (remainder n m))))

(define (relative-prime n)
        (lambda (m) (= (gcd n m) 1)))

(define (identity n)
        n)

(define (product-o-relative-primes n)
        (filtered-accumulate * 1 identity 1 inc n (relative-prime n)))

(product-o-relative-primes 1) ; 1
(product-o-relative-primes 2) ; 1
(product-o-relative-primes 3) ; 2
(product-o-relative-primes 4) ; 3
(product-o-relative-primes 5) ; 24
(product-o-relative-primes 6) ; 5