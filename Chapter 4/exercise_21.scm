((lambda (n)
         ((lambda (fact)
                  (fact fact n))
          (lambda (ft k)
                  (if (= k 1)
                      1
                      (* k (ft ft (- k 1)))))))
         10)

((lambda (n)
         ((lambda (fib)
                  (fib fib n))
          (lambda (ft k)
                  (cond ((= k 0) 0)
                        ((= k 1) 1)
                        (else (+ (ft ft (- k 1)) (ft ft (- k 2))) ) ) ) ))
          19)

(define (f x)
        ((lambda (even? odd?)
                 (even? even? odd? x))
                 (lambda (ev? od? n)
                         (if (= n 0) 
                             #t 
                             (od? ev? od? (- n 1))))
                 (lambda (ev? od? n)
                         (if (= n 0) 
                             #f 
                             (ev? ev? od? (- n 1))))))
(f 100001)

;From SophiaG http://community.schemewiki.org/?sicp-ex-4.21
;non-recursive factorial function 
 (define fact-once 
    (lambda (f) 
      (lambda (n) 
        (if (= n 0) 
            1 
            (* n (f (- n 1))))))) 
  
 ;y-combinator 
 (define Y  
   (lambda (f) 
     ((lambda (x) (x x)) 
      (lambda (x) (f (lambda (y) ((x x) y))))))) 
  
 (define factorial (Y fact-once)) 
 (factorial 20)  ;=2432902008176640000 

 ;See also https://web.stanford.edu/class/cs209/lectures/WhyOfY.pdf