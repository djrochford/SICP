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
                (let ((first-root (root1 -4.9 vertical-velocity elevation)))
                     (if (> first-root 0)
                         first-root
                         (root2 (/ -9.8 2) vertical-velocity elevation)))))

(time-to-impact 0 0) ; -> 0
(time-to-impact 0 9.8) ; -> 1
(time-to-impact 9.8 0) ; -> 1
(time-to-impact 407 45) ; -> 41.6408845597932

(define time-to-height
        (lambda (vertical-velocity elevation target-elevation)
                ;output: time-elpased before reaching the target-elevation
                (let ((first-root (root1 -4.9 vertical-velocity (- elevation target-elevation))))
                     (if (> first-root 0)
                         first-root
                         (root2 -4.9 vertical-velocity (- elevation target-elevation))))))


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

(define pi 3.141592653589793)

(define travel-distance-simple
        (lambda (elevation velocity angle)
                (let* ((vy (* (sin angle) velocity))
                       (vx (* (cos angle) velocity))
                       (t (time-to-impact vy elevation)))
                      (* vx t))))

(travel-distance-simple 1 45 0) ; approx 20
(travel-distance-simple 1 45 (/ pi 4)) ; -> approx 207
(travel-distance-simple 1 45 (/ pi 2)) ; -> 0, more or less

;Problem 5: What’s the best angle to hit? 

(define (find-biggest-in-stream stream transform iteration limit biggest)
        (cond ((> iteration limit) biggest)
              ((> (transform (stream-car stream)) (transform biggest)) 
               (find-biggest-in-stream (stream-cdr stream) 
                                       transform
                                       (+ iteration 1) 
                                       limit 
                                       (stream-car stream)))
              (else (find-biggest-in-stream (stream-cdr stream)
                                            transform
                                            (+ iteration 1)
                                            limit
                                            biggest))))

(define find-best-angle
        (lambda (velocity elevation)
                (define angles (cons-stream 0 (stream-map (lambda (angle) (+ 0.1 angle))
                                                         angles)))
                (define (angle-to-distance angle) 
                        (travel-distance-simple elevation 
                                                velocity 
                                                angle))
        (find-biggest-in-stream angles 
                                angle-to-distance
                                0 
                                16 
                                0)))
(find-best-angle 45 1) ; -> about 45


;Problem 6: So why aren’t baseball outfields 600 feet deep? 

(define g 9.8)

(define (system-over-time x_0 y_0 u_0 v_0 beta m)
        (define dt 0.01)
        (define (step x-y-u-v)
                (let* ((x (car x-y-u-v))
                       (y (cadr x-y-u-v))
                       (u (caddr x-y-u-v))
                       (v (cadddr x-y-u-v))
                       (velocity-term (* (/ -1 m)
                                         beta
                                         (sqrt (+ (square u) 
                                                  (square v)))))
                       (dx (* u dt))
                       (dy (* v dt))
                       (du (* velocity-term u dt))
                       (dv (- (* velocity-term v dt)
                              (* g dt))))
                      (list (+ x dx)
                            (+ y dy)
                            (+ u du)
                            (+ v dv))))
        (define system (cons-stream (list x_0 y_0 u_0 v_0)
                                    (stream-map step system)))
        system)

(define (travel-distance C rho D h V alpha m) 
        (define A (* pi (/ (square D) 4)))
        (define beta (* (/ 1 2) C rho A))
        (define hit-ball (system-over-time 0 h (* V (cos alpha)) (* V (sin alpha)) beta m))
        (define (find-x-when-y-is-0 stream)
                (let ((x-y-u-v (stream-car stream)))
                     (if (> (cadr x-y-u-v) 0)
                         (find-x-when-y-is-0 (stream-cdr stream))
                         (car x-y-u-v))))
        (find-x-when-y-is-0 hit-ball))

;changing speed
(travel-distance 0.5 1.25 0.074 1 45 (/ pi 4) 0.15) ; -> about 94m
(travel-distance 0.5 1.25 0.074 1 40 (/ pi 4) 0.15) ; -> about 83m
(travel-distance 0.5 1.25 0.074 1 35 (/ pi 4) 0.15) ; -> about 71m

;changing angle
(travel-distance 0.5 1.25 0.074 1 45 (/ pi 4) 0.15) ; -> about 94m -- over the fence
(travel-distance 0.5 1.25 0.074 1 45 (/ pi 5) 0.15) ; -> about 95m -- over the fence (hmmm...)
(travel-distance 0.5 1.25 0.074 1 45 (/ pi 3) 0.15) ; -> about 77m
(travel-distance 0.5 1.25 0.074 1 45 (/ pi 6) 0.15) ; -> about 92m
(travel-distance 0.5 1.25 0.074 1 45 0 0.15) ; -> about 19m

;in Denver
(travel-distance 0.5 1.06 0.074 1 45 (/ pi 4) 0.15) ; -> about 101m
(travel-distance 0.5 1.06 0.074 1 40 (/ pi 4) 0.15) ; -> about 89m