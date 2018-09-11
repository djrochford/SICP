;After considerable work, Alyssa P. Hacker delivers her finished system. 
;Several years later, after she has forgotten all about it, she gets a frenzied call from an irate user, 
;Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel resistors 
;can be written in two algebraically equivalent ways:

;R1R2 / (R1 + R2)

;and

;1 / (1/R1 + 1/R2)

;He has written the following two programs, each of which computes the parallel-resistors formula differently:

(define (par1 r1 r2)
        (div-interval (mul-interval r1 r2)
                      (add-interval r1 r2)))
(define (par2 r1 r2)
        (let ((one (make-interval 1 1))) 
             (div-interval one
                           (add-interval (div-interval one r1)
                                         (div-interval one r2)))))

;Lem complains that Alyssa's program gives different answers for the two ways of computing. This is a serious complaint.

;Exercise 2.14. Demonstrate that Lem is right. Investigate the behavior of the system on a variety of arithmetic expressions. 
;Make some intervals A and B, and use them in computing the expressions A/A and A/B. 
;You will get the most insight by using intervals whose width is a small percentage of the center value. 
;Examine the results of the computation in center-percent form (see exercise 2.12).

"Some necessary code"

(define (make-interval a b) (cons a b))

(define (upper-bound interval) (cdr interval))

(define (lower-bound interval) (car interval))

(define (add-interval x y)
        (make-interval (+ (lower-bound x) (lower-bound y))
                       (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
        (if (and (not (> (lower-bound y) 0))
                 (not (< (upper-bound y) 0)))
            (error "Divisor spans 0 -- DIV-INTERVAL")
            (mul-interval x 
                          (make-interval (/ 1.0 (upper-bound y))
                                         (/ 1.0 (lower-bound y))))))


(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent center percentage)
        (make-center-width center (/ (* percentage center) 100)))

(define (percent i)
        (* (/ (width i) (center i)) 100))

(define A (make-center-percent 100 1))
(define B (make-center-percent 100 1))

(define a-over-a (div-interval A A))

"Suppose our intended interpretation of an 'interval' is epistemic -- i.e. there is a specific value that `A` names,
but we don't know what value exactly; it's some number around 100, +- 1%. If that's what we mean, then we know that, whatever
A is, A/A is 1. So it would be nice if (div-interval A A) was an interval centered on 1 with 0% error. However..."
(center a-over-a) ; 1.0002000200020003, not 1.
(percent a-over-a) ; 1.9998000199980077, not 0.

"This is exactly the same as A/B, but what you would *expect* A/B to equal, on our interpretation of interval, 
as A and B can vary independently, and so we really don't know what A/B is exactly."

(define a-over-b (div-interval A B))

(center a-over-b) ; 1.0002000200020003
(percent a-over-b) ; 1.9998000199980077

"Here is a little confirmation that par1 and par2 deliver different results"
(define first (par1 A B))
(define second (par2 A B))

(center first) ; 33.3414820473644
(percent first) ; 2.3329667308221125
(center second) ; 33.333148135287175
(percent second) ; .6666750006250436

"Different"

