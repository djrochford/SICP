;Exercise 3.79.  Generalize the `solve-2nd` procedure of exercise 3.78 so that it can
;be used to solve general second-order differential equations d^2y/dt^2 = f(dy/dt, y).

"For reference, here is `solve-2nd`, when last we saw it:"

(define (solve-2nd a b dt y0 dy0)
        (define y (integral (delay dy) y0 dt))
        (define dy (integral (delay ddy) dy0 dt))
        (define ddy (add-streams (scale-stream dy a)
                                 (scale-stream y b)))
        y)

"Also helpful to see is the procedure for solving, in general dy/dt = f(y)":
(define (solve f y0 dt)
        (define y (integral dy y0 dt))
        (define dy (stream-map f y))
        y)

"The solution:"

(define (solve-2nd f f0 dy0 dt)
        (define y (integral (delay dy) y0 dt))
        (define dy (integral (delay ddy) dy0 dt))
        (define ddy (stream-map f dy y))
        y)