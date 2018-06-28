;Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
(define (some-procedure x y z)
        (define (sum-of-squares a b)
                (+ (* a a)
                   (* b b)))
        (cond ((and (<= x y) (<= x z)) (sum-of-squares y z))
              ((and (<= y x) (<= y z)) (sum-of-squares x z))
              ((and (<= z x) (<= z y)) (sum-of-squares x y))))

(some-procedure 3 4 5) ;41