;Exercise 2.3.  Implement a representation for rectangles in a plane. 
;(Hint: You may want to make use of exercise 2.2.) 

"From earlier..."

(define (make-point x y)
        (cons x y))
(define (x-point point)
        (car point))
(define (y-point point)
        (cdr point))

"Below I cheat a little and anticipate the tagging system described later in the chapter"

(define (make-rectangle bottom-left-corner top-right-corner)
        (cons 'bl-tr-rectangle (cons bottom-left-corner top-right-corner)))
(define (tag rectangle)
        (car rectangle))
(define (bottom-left-corner-rectangle rectangle)
        (cadr rectangle))
(define (top-right-corner-rectangle rectangle)
        (cddr rectangle))

;In terms of your constructors and selectors, 
;create procedures that compute the perimeter and the area of a given rectangle. 

"With the help of some helper procedures..."

(define (height-rectangle rectangle)
        (- (y-point (top-right-corner-rectangle rectangle))
           (y-point (bottom-left-corner-rectangle rectangle))))

(define (width-rectangle rectangle)
        (- (x-point (top-right-corner-rectangle rectangle))
           (x-point (bottom-left-corner-rectangle rectangle))))

"we can define the required procedures as follows..."

(define (perimeter rectangle)
        (+ (* 2 (height-rectangle rectangle))
           (* 2 (width-rectangle rectangle))))

(define (area rectangle)
        (* (height-rectangle rectangle)
           (width-rectangle rectangle)))

;Now implement a different representation for rectangles. 

(define (make-rectangle-alternate top-left-corner bottom-right-corner)
        (cons 'tl-br-rectangle (cons top-left-corner bottom-right-corner)))
(define (top-left-corner-alternate-rectangle alternate-rectangle) 
        (cadr alternate-rectangle))
(define (bottom-right-corner-alternate-rectangle alternate-rectangle)
        (cddr alternate-rectangle))

;Can you design your system with suitable abstraction barriers, 
;so that the same perimeter and area procedures will work using either representation?

"Let's see..."

(define (height-rectangle rectangle)
        (if (eq? (tag rectangle) 'bl-tr-rectangle)
            (- (y-point (top-right-corner-rectangle rectangle))
               (y-point (bottom-left-corner-rectangle rectangle)))
            (- (y-point (top-left-corner-alternate-rectangle rectangle))
               (y-point (bottom-right-corner-alternate-rectangle rectangle)))))

(define (width-rectangle rectangle)
        (if (eq? (tag rectangle) 'bl-tr-rectangle)
            (- (x-point (top-right-corner-rectangle rectangle))
               (x-point (bottom-left-corner-rectangle rectangle)))
            (- (x-point (bottom-right-corner-alternate-rectangle rectangle))
               (x-point (top-left-corner-alternate-rectangle rectangle)))))

"Now the perimeter and area methods should work unchanged. A test:"

(define recty (make-rectangle (make-point 1 3) (make-point 4 4)))
(define alternate-recty (make-rectangle-alternate (make-point 1 4) (make-point 4 3)))


(perimeter recty) ;8
(perimeter alternate-recty) ;8
(area recty) ; 3
(area alternate-recty) ; 3