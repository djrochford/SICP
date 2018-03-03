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


(* 4 (estimate-integral in-unit-circle 0.0 1.0 0.0 1.0 50000))

;-----------------------

(define (monte-carlo-stream experiment-stream passed failed)
        (define (next passed failed)
                (cons-stream (/ passed (+ passed failed))
                             (monte-carlo (stream-cdr experiment-stream) passed failed)))
        (if (stream-car experiment-stream)
            (next (+ passed 1) failed)
            (next passed (+ failed 1))))

(define (random-in-range-stream low high)
        (define (make-stream seed)
                (cons-stream (+ low (* seed (- high low)))
                             (make-stream rand-update seed)))
        (make-stream rand-init))

(define (map-successive-pairs f s)
        (cons-stream (f (stream-car s) (stream-car (stream-cdr s)))
                      (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define experiments
        (map-successive-pairs in-unit-circle (random-in-range-stream 0.0 1.0)))

(define pi-stream (* 4 (monte-carlo-stream experiments )))
