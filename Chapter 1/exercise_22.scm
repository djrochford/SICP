(define (smallest-divisor n)
        (find-divisor n 2))

(define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
              ((divides? test-divisor n) test-divisor)
              (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
        (= (remainder b a) 0))

;We can test whether a number is prime as follows: n is prime if and only if n is its own smallest divisor.

(define (prime? n)
        (= n (smallest-divisor n)))




;Exercise 1.22.  Most Lisp implementations include a primitive called runtime that returns an integer that specifies the amount of time the system has been running 
;(measured, for example, in microseconds). The following timed-prime-test procedure, when called with an integer n, prints n and checks to see if n is prime. 
;If n is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

(define (timed-prime-test n)
        (newline)
        (display n)
        (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
        (if (prime? n)
            (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
        (display " *** ")
        (display elapsed-time))

;Using this procedure, write a procedure search-for-primes that checks the primality of consecutive odd integers in a specified range. 
;Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. 
;Note the time needed to test each prime. Since the testing algorithm has order of growth of (n), you should expect that testing for primes around 10,000 should take about 10 times as long as testing for primes around 1000. 
;Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the n prediction? 
;Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

(define (search-for-primes n m)
        (timed-prime-test n)
        (if (<= n m)
             (search-for-primes (+ n 1) m)))

"My computer is too fast to notice much happening at the recommended scale (SICP was writen a while ago),
 so we have to go a bit bigger."

(search-for-primes 1000000000 1000000030)
"1000000007, 0.04 seconds
1000000009, 0.03 seconds
10000103, 0.03 seconds"

(search-for-primes 10000000000 10000000070)
"10000000019 0.11 seconds
10000000033 0.1 seconds
10000000061 0.11 seconds"

(search-for-primes 100000000000 10000000006)
"100000000003 0.35 seconds
100000000019 0.33 seconds
100000000057 0.34 seconds"

"The data doesn't bear out the hypothesis that the growth in the run time for these algorithms, on my computer, is linear in the number of steps
it takes to perform the algorithm.
You need to multiply the input, and hence the number of steps, by 100 to get a 10 fold increase in the run time, 
above, so the growth is more like O(n^(1/2)). I suspect my hardware or intepreter is doing something clever to be more efficient."
