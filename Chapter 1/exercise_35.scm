;Exercise 1.35.  Show that the golden ratio phi (section 1.2.2) is a fixed point of the transformation x -> 1 + 1/x, 
;and use this fact to compute phi by means of the fixed-point procedure.

"To show: phi is a fixed point of x -> 1 + 1/x

  phi = (1 + sqrt(5))/2
so
  1 + 1/phi = 1 + 2/(1+sqrt(5))
            = (3 + sqrt(5)) / (1 + sqrt(5))
            = (3 + sqrt(5)) / (1 + sqrt(5)) * (1 - sqrt(5)) / (1 - sqrt(5))
            = (3 - 3*sqrt(5) + sqrt(5) - 5) / (1 - sqrt(5) + sqrt(5) - 5)
            = -(2 + 2sqrt(5)) / -4
            = (1 + sqrt(5))/2
            = phi
So phi is a fixed point of x -> 1 + 1/x"

(define tolerance 0.00001)

(define (fixed-point f first-guess)
        (define (close-enough? v1 v2)
                (< (abs (- v1 v2)) tolerance))
        (define (try guess)
                (let ((next (f guess)))
                     (if (close-enough? guess next)
                         next
                         (try next))))
        (try first-guess))

(define (1-plus-inverse x)
        (+ 1 (/ 1 x)))

(define phi (fixed-point 1-plus-inverse 1.0))

(display phi) ;1.6180327868852458

"That is indeed within tolerance of the golden ratio."