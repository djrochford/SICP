(define (compose f g)
        (lambda (x) (f(g x))))

(define (square x)
        (* x x))

(define (inc x)
        (+ x 1))

;((compose square inc) 6)

(define (repeated f n)
        (define (compose-iter accumulator f n)
                (if (= n 1) 
                    accumulator
                    (compose-iter (compose f accumulator) f (- n 1))))
        (compose-iter f f n))

((repeated square 2) 5)
