;Exercise 1.45.  We saw in section 1.3.3 that attempting to compute square roots by naively finding a fixed point of y -> x/y 
;does not converge, and that this can be fixed by average damping. 
;The same method works for finding cube roots as fixed points of the average-damped y -> x/y^2. 
;Unfortunately, the process does not work for fourth roots -- a single average damp is not enough to make a fixed-point search 
;for y -> x/y^3 converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of y -> x/y^3) 
;the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots 
;as a fixed-point search based upon repeated average damping of y -> x/yn-1. 
;Use this to implement a simple procedure for computing nth roots using fixed-point, average-damp, 
;and the repeated procedure of exercise 1.43. Assume that any arithmetic operations you need are available as primitives.

(define tolerance 0.00001)

(define (fixed-point f first-guess)
        (define (close-enough? v1 v2)
                (< (abs (- v1 v2)) tolerance))
        (define (try guess)
                (display guess)
                (newline)
                (let ((next (f guess)))
                     (if (close-enough? guess next)
                         next
                         (try next))))
        (try first-guess))

(define (average . values)
        (define (average-iter numbers sum n)
                (if (null? numbers)
                    (/ sum n)
                    (average-iter (cdr numbers)
                                  (+ sum (car numbers))
                                  (+ 1 n))))
        (average-iter values 0 0))

(define (average-damp f)
        (lambda (x) (average x (f x))))

(define (compose f g)
        (lambda (x) (f(g x))))

(define (repeated f n)
        (define (compose-iter accumulator f n)
                (if (= n 1) 
                    accumulator
                    (compose-iter (compose f accumulator) f (- n 1))))
        (compose-iter f f n))

;---------

(define (n-map n x)
        (lambda (y) (/ x (expt y (- n 1)))))

(fixed-point (average-damp (n-map 2 10)) 1.0)

(fixed-point (average-damp (n-map 3 100)) 1.0)

;(fixed-point (average-damp (n-map 4 1000)) 1.0) No good

(fixed-point ((repeated average-damp 2) (n-map 4 1000)) 1.0)

(fixed-point ((repeated average-damp 2) (n-map 5 10000)) 1.0)

(fixed-point ((repeated average-damp 2) (n-map 6 1000000)) 1.0)

(fixed-point ((repeated average-damp 2) (n-map 7 10000000)) 1.0)

;(fixed-point ((repeated average-damp 2) (n-map 8 1000000000)) 1.0) No good

"The pattern appears to be: to find the nth root you need to average-damp (floor of log_2 n) times. Hence:"

(define (nth-root n x)
        (define damp-iterations (floor (/ (log n) (log 2))))
        (fixed-point ((repeated average-damp damp-iterations) (n-map n x)) 1.0))

(nth-root 19 1000000) ;2.0691376917233333


