;Exercise 3.64.  Write a procedure `stream-limit` that takes as arguments a stream and a number
;(the tolerance). It should examine the stream until it finds two successive elements that differ
;in absolute value by less than the tolerance, and return the second of the two elements. Using this,
;we could compute square roots up to a given tolerance by

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

"Here is my procedure:"

(define (stream-limit stream tolerance)
        (if (< (abs (- (stream-car stream) 
                       (stream-car (stream-cdr stream)))) 
               tolerance)
            (stream-car (stream-cdr stream))
            (stream-limit (stream-cdr stream) tolerance)))

"Here is a test:"

(define (average a b)
        (/ (+ a b) 2))

(define (sqrt-improve guess x)
        (average guess (/ x guess)))

(define (sqrt-stream x)
        (define guesses
                (cons-stream 1.0
                            (stream-map (lambda (guess) (sqrt-improve guess x))
                                        guesses)))
        guesses)


(define (sqrt x tolerance)
        (stream-limit (sqrt-stream x) tolerance))

(sqrt 2 0.001) ;1.4142135623746899