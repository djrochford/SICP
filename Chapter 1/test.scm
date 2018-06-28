(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

;A guess is improved by averaging it with the quotient of the radicand and the old guess:

(define (improve guess x)
  (average guess (/ x guess)))

;where

(define (average x y)
  (/ (+ x y) 2))

;We also have to say what we mean by ``good enough.'' The following will do for illustration, but it is not really a very good test. (See exercise 1.7.) The idea is to improve the answer until it is close enough so that its square differs from the radicand by less than a predetermined tolerance (here 0.001):22

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;Finally, we need a way to get started. For instance, we can always guess that the square root of any number is 1:23

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 1000000000000000)

