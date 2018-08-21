;Exercise 2.11.  In passing, Ben also cryptically comments: "By testing the signs of the endpoints of the intervals, 
;it is possible to break mul-interval into nine cases, only one of which requires more than two multiplications." 
;Rewrite this procedure using Ben's suggestion.

"For reference, here is `mul-interval`":
(define (old-mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

"There are 3 possibilities for a given interval: it can be either wholly non-negative, span 0, or wholly non-positive; 
so, on this way of dividing logical space, there are 3*3 = 9 possibilities for the pair of intervals. 
These are the possibilities Ben has in mind."

(define (mul-interval x y)
        (define (non-negative? interval)
                (>= (lower-bound interval) 0))
        (define (spans-zero? interval)
                (and (< (lower-bound interval) 0)
                     (> (upper-bound interval) 0)))
        (define (non-positive? interval)
                (<= (upper-bound interval 0)))
        (let ((x1 (lower-bound x))
              (x2 (upper-bound x))
              (y1 (lower-bound y))
              (y2 (upper-bound y)))
             (cond ((and (non-negative? x) (non-negative? y))
                    (make-interval (* x1 y1) (* x2 y2)))
                   ((and (non-negative? x) (spans-zero? y))
                    (make-interval (* x2 y1) (* x2 y2)))
                   ((and (non-negative? x) (non-positive? y))
                    (make-interval (* x2 y1) (* x1 y2)))
                   ((and (spans-zero? x) (non-negative? y))
                    (make-interval (* x1 y2) (* x2 y2)))
                   ((and (spans-zero? x) (spans-zero? y)) ; this is the special case, that takes more than two multiplications
                    (make-interval (min (* x1 y2) (* x2 y1))
                                   (max (* x1 y1) (* x2 y2))))
                   ((and (spans-zero? x) (non-positive? y))
                    (make-interval (* x2 y1) (* x1 y1)))
                   ((and (non-positive? x) (non-negative? y))
                    (make-interval (* x1 y2) (* x2 y1)))
                   ((and (non-positive? x) (spans-zero? y))
                    (make-interval (* x1 y2) (* x1 y1)))
                   ((and (non-positive? x) (non-positive? y))
                    (make-interval (* x2 y2) (* x1 y1))))))



