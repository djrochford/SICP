;Exercise 1.31.   
;a.  The sum procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures.
;Write an analogous procedure called product that returns the product of the values of a function at points over a given range. 
;Show how to define factorial in terms of product. Also use product to compute approximations to pi using the formula.

;pi/4 = (2 * 4 * 4 * 6 * 6 * 8 ...)/(3 * 3 * 5 * 5 * 7 * 7 ...)

"Just a tiny tweak on sum..."

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (f a)
        (let ((numerator (if (odd? a)
                             (+ 1 a)
                             (+ 2 a)))
              (denominator (if (odd? a)
                               (+ 2 a)
                               (+ 1 a))))
             (/ numerator denominator)))

(define (inc n)
        (+ 1 n))

(define (approximate-pi n)
        (* 4 
          (product f 1 inc n)))


(approximate-pi 10) ; 3.27510104...

(approximate-pi 100) ; 3.1570301...

"This is pretty slow converging."

;b.  If your product procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

"And again..."

(define (product term a next b)
        (define (iter a result)
                (if (> a b)
                    result
                    (iter (next a) 
                          (* (term a) result))))
        (iter a 1))

(define (inc n)
        (+ 1 n))

(define (approximate-pi n)
        (* 4 
          (product f 1 inc n)))


(approximate-pi 10) ; 3.27510104

(approximate-pi 100) ; 3.15703017646


