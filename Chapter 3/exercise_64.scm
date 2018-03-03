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

(define (stream-limit stream tolerance)
        (if (< (abs (- (stream-car stream) (stream-car (stream-cdr stream)))) tolerance)
            (stream-car (stream-cdr stream))
            (stream-limit (stream-cdr stream) tolerance)))

(define (sqrt x tolerance)
        (stream-limit (sqrt-stream x) tolerance))

(sqrt 2 0.001)