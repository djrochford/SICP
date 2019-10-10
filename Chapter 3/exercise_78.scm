;Exercise 3.78.  


;Figure 3.35:  Signal-flow diagram for the solution to a second-order linear
;differential equation.

;Consider the problem of designing a signal-processing system to study the 
;homogeneous second-order linear differential equation

;d^2y/dt^2 - a dy/dt - by = 0

;The output stream, modeling y, is generated by a network that contains a loop.
;This is because the value of d^2y/dt^2 depends upon the values of y and dy/dt
;and both of these are determined by integrating d2y/dt2. The diagram we would
;like to encode is shown in figure 3.35. Write a procedure `solve-2nd` that takes
;as arguments the constants a, b, and dt and the initial values y0 and dy0 for y
;and dy/dt and generates the stream of successive values of y.

(define (solve-2nd a b dt y0 dy0)
        (define y (integral (delay dy) y0 dt))
        (define dy (integral (delay ddy) dy0 dt))
        (define ddy (add-streams (scale-stream dy a)
                                 (scale-stream y b)))
        y)