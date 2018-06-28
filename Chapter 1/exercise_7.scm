;Exercise 1.7.  The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. 
;Also, in real computers, arithmetic operations are almost always performed with limited precision. 
;This makes our test inadequate for very large numbers. 
;Explain these statements, with examples showing how the test fails for small and large numbers. 
;An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. 
;Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

;The good enough test:
;(define (good-enough? guess x)
;  (< (abs (- (square guess) x)) 0.001))

"This is not a good test for very small numbers because it is too easy to pass for very small numbers -- the constraint is not
tight enough. Suppose you wanted to find the square root of 0.0001; by this measure, .03230844833048122
good enough -- a value about 3 times larger than the actual square root of 0.0001 (i.e., 0.01)"

"This is not a good test for very large numbers because, given the limits of precision in computer arithmetic, successive
iterations of the sqrt procedure are liable to fail to ever produce a number that is good enough, by this test. On my
machine, that happens with 10^15 as input."

"A better sqrt procedure, along the suggested lines:"

(define (sqrt-iter guess x)
  (define improved-guess (improve guess x))
  (if (good-enough? guess improved-guess)
      improved-guess
      (sqrt-iter improved-guess
                 x)))

;A guess is improved by averaging it with the quotient of the radicand and the old guess:

(define (improve guess x)
  (average guess (/ x guess)))

;where

(define (average x y)
  (/ (+ x y) 2))

;We also have to say what we mean by ``good enough.'' The following will do for illustration, but it is not really a very good test. (See exercise 1.7.) The idea is to improve the answer until it is close enough so that its square differs from the radicand by less than a predetermined tolerance (here 0.001):22

(define (good-enough? guess improved-guess)
  (< (abs (- improved-guess guess)) (* guess 0.001)))

;Finally, we need a way to get started. For instance, we can always guess that the square root of any number is 1:23

(define (sqrt x)
  (sqrt-iter 1.0 x))


"This does indeed work better for both very large and very small numbers. Try it:"
(sqrt 0.0001)
(sqrt 100000000000000000)