;Exercise 1.44. The idea of *smoothing* a function is an important concept in signal processing. 
;If f is a function and dx is some small number, then the smoothed version of f is the function whose value at a point x 
;is the average of f(x - dx), f(x), and f(x + dx). Write a procedure `smooth` that takes as input 
;a procedure that computes f and returns a procedure that computes the smoothed f. 

(define (average . values)
        (define (average-iter numbers sum n)
                (if (null? numbers)
                    (/ sum n)
                    (average-iter (cdr numbers)
                                  (+ sum (car numbers))
                                  (+ 1 n))))
        (average-iter values 0 0))


(define (smooth f)
        (define dx 0.0000000001)
        (lambda (x) (average (f (- x dx))
                             (f x)
                             (f (+ x dx)))))

;It is sometimes valuable to repeatedly smooth a function (that is, smooth the smoothed function, and so on) 
;to obtained the n-fold smoothed function. Show how to generate the n-fold smoothed function of any given function 
;using smooth and repeated from exercise 1.43.

(define (compose f g)
        (lambda (x) (f(g x))))

(define (repeated f n)
        (define (compose-iter accumulator f n)
                (if (= n 1) 
                    accumulator
                    (compose-iter (compose f accumulator) f (- n 1))))
        (compose-iter f f n))

((repeated (smooth tan) 2) 0.7)