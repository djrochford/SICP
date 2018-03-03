;Problem 1: Some simple physics 

(define square
        (lambda (x) (* x x)))

(define position
        (lambda (a v u t)
                ; a = initial acceleration
                ; v = initial velocity
                ; u = initial position
                ; t = elapsed time
                ; output = position after t
                 (+ (* (/ a 2) (square t)) 
                    (* v t)
                    u)))

(position 0 0 0 0) ; -> 0
(position 0 0 20 0) ; -> 20
(position 0 5 10 10) ; -> 60
(position 2 2 2 2) ; -> 10
(position 5 5 5 5) ; ->  185/2


;Problem 2: Basic Math 

(define root1
        ; one of the roots of quadratic ax^2 + bx + c
        (lambda (a b c)
                (/ (+ (* -1 b) 
                      (sqrt (- (square b) 
                               (* 4 a c))))
                   (* 2 a))))

(define root2
        ; the other root
        (lambda (a b c)
              (/ (- (* -1 b) 
                    (sqrt (- (square b) 
                             (* 4 a c))))
                 (* 2 a))))

(root1 1 0 -1) ; -> 1
(root2 1 0 -1) ; -> -1
(root1 1 0 1) ; -> i
(root2 1 0 1) ; -> -i

(root1 -21 -10 24) ; -> -4/3
(root2 -21 -10 24) ; -> 6/7

(root1 -1.1 4.95 0) ; -> 0
(root2 -1.1 4.95 0) ; -> 4.5


;Problem 3: Flight Time 

(define time-to-impact
        (lambda (vertical-velocity elevation)
                ;output: time-elpased before impact
                (let ((first-root (root1 -9.8 vertical-velocity elevation)))
                     (if (> first-root 0)
                         first-root
                         (root2 -9.8 vertical-velocity elevation)))))

(time-to-impact 0 0) ; -> 0
(time-to-impact 0 9.8) ; -> 1
(time-to-impact 9.8 0) ; -> 1
(time-to-impact 407 45) ; -> 41.6408845597932

(define time-to-height
        (lambda (vertical-velocity elevation target-elevation)
                ;output: time-elpased before reaching the target-elevation
                (let ((first-root (root1 -9.8 vertical-velocity (- elevation target-elevation))))
                     (if (> first-root 0)
                         first-root
                         (root2 -9.8 vertical-velocity (- elevation target-elevation))))))


(time-to-height 0 0 0) ; -> 0
(time-to-height 0 9.8 0) ; -> 1
(time-to-height 407 47 2) ; -> 41.6408845597932

(define time-to-impact
        (lambda (vertical-velocity elevation)
                ;output: time-elpased before impact -- i.e., before reaching elevation 0
                (time-to-height vertical-velocity elevation 0)))

(time-to-impact 0 0) ; -> 0
(time-to-impact 0 9.8) ; -> 1
(time-to-impact 9.8 0) ; -> 1
(time-to-impact 407 45) ; -> 41.6408845597932


;Problem 4: Flight Distance 

(define degree2radian
        (lambda (deg)
                (/ (* deg pi) 180.))) 


