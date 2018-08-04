;Exercise 2.2.  Consider the problem of representing line segments in a plane. 
;Each segment is represented as a pair of points: a starting point and an ending point. 
;Define a constructor `make-segment` and selectors `start-segment` and `end-segment` 
;that define the representation of segments in terms of points.

(define (make-segment p1 p2)
        (cons p1 p2))
(define (start-segment segment)
        (car segment))
(define (end-segment segment)
        (cdr segment))

;Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate. 
;Accordingly, specify a constructor `make-point` and selectors `x-point` and `y-point` that define this representation. 
(define (make-point x y)
        (cons x y))
(define (x-point point)
        (car point))
(define (y-point point)
        (cdr point))

;Finally, using your selectors and constructors, define a procedure `midpoint-segment` 
;that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints). 

(define (mean x y)
        (/ (+ x y) 2))
(define (midpoint-segment segment)
        (make-segment (mean (x-point (start-segment segment))
                            (x-point (end-segment segment)))
                      (mean (y-point (start-segment segment))
                            (y-point (end-segment segment)))))

;To try your procedures, you'll need a way to print points:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


(print-point (make-point 2 7)) ; prints "(2,7)"

(print-point(midpoint-segment (make-segment (make-point 2 8) (make-point 1 (- 3))))) ; prints "(3/2, 5/2)"