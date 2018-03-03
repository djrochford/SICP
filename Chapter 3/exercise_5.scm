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
;39361/12500 = 3.14088