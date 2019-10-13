;Exercise 3.82.  Redo exercise 3.5 on Monte Carlo integration in terms of streams.
;The stream version of `estimate-integral` will not have an argument telling how many
;trials to perform. Instead, it will produce a stream of estimates based on successively
;more trials.

"Here is my solution to 3.5, for reference"

(define (monte-carlo trials experiment)
        (define (iter trials-remaining trials-passed)
                (cond ((= trials-remaining 0) (/ trials-passed trials))
                      ((experiment) (iter (- trials-remaining 1) (+ trials-passed 1)))
                      (else (iter (- trials-remaining 1) trials-passed))))
        (iter trials 0))

(define (random-in-range low high)
        (let ((range (- high low)))
             (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 n)
        (define (in-or-out?)
                (P (random-in-range x1 x2)
                   (random-in-range y1 y2)))
        (monte-carlo n in-or-out?))

(define (in-unit-circle x y)
        (<= (sqrt (+(* x x) (* y y))) 1))


(* 4 (estimate-integral in-unit-circle 0.0 1.0 0.0 1.0 50000)) ; 3917/1250 = 3.1336

"And here is a stream version"

(define (monte-carlo-stream experiment)
        (define (next passed failed)
                (cons-stream (/ passed (+ passed failed))
                             (if (experiment)
                                 (next (+ passed 1) failed)
                                 (next passed (+ failed 1)))))
        (next 1 1)) ;(`1`s instead of `0`s just to avoid division by 0)

(define (estimate-integral-stream P x1 x2 y1 y2)
        (define (in-or-out?)
                (P (random-in-range x1 x2)
                   (random-in-range y1 y2)))
        (monte-carlo-stream in-or-out?))

(define (in-unit-circle x y)
        (<= (sqrt (+(* x x) (* y y))) 1))

(define (scale-stream stream factor)
        (stream-map (lambda (x) (* x factor)) stream))

(define pi-stream (scale-stream (estimate-integral-stream in-unit-circle 0.0 1.0 0.0 1.0) 4))

(stream-ref pi-stream 50000) ; 78528/25001 = 3.14099436...
