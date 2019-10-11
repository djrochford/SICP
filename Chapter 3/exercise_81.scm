;Exercise 3.81.  Exercise 3.6 discussed generalizing the random-number generator
;to allow one to reset the random-number sequence so as to produce repeatable sequences
;of "random" numbers. Produce a stream formulation of this same generator that operates
;on an input stream of requests to generate a new random number or to reset the sequence
;to a specified value and that produces the desired stream of random numbers. Don't use
;assignment in your solution.

"This, for reference, is the exercise 3.6 solution:"
(define (rand command)
        (define state (random 1.0))
        (cond ((eq? command 'generate) (rand-update state))
              ((eq? command 'reset) (lambda (new-value) (set! state new-value)))))

"Here is a stream version:"
(define (stream-rand command-stream)
        (define (make-random-stream seed)
                (cons-stream seed (make-random-stream (rand-update seed))))
        (define (make-return-stream commands numbers)
                (let (command (stream-car commands))
                     (cond ( (eq? command 'generate) 
                             (cons-stream (stream-car numbers)
                                          (make-return-stream (stream-cdr commands)
                                                              (stream-cdr numbers))) )
                           ( (and (pair? command) 
                                 (eq? (car command) 'reset)) 
                             (let (new-numbers (make-random-stream (cdr command)))
                                  (cons-stream (stream-car new-numbers)
                                               (make-return-stream (stream-cdr commands)
                                                                   (stream-cdr new-numbers)))) )
                           ((null? command) the-empty-stream)
                           (else (error "bad command -- " command)))))
        (make-return-stream command-stream (make-random-stream 1.0)))


"(It assumes commands are either `'generate` or a pair of the form `'reset n`, where `n` is
the seed to be used for further generations."
  