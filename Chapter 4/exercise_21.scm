;Exercise 4.21.  Amazingly, Louis's intuition in exercise 4.20 is correct.
;It is indeed possible to specify recursive procedures without using `letrec`
;(or even `define`), although the method for accomplishing this is much more
;subtle than Louis imagined. The following expression computes 10 factorial by
;applying a recursive factorial procedure:

((lambda (n)
         ((lambda (fact)
                  (fact fact n))
          (lambda (ft k)
                  (if (= k 1)
                      1
                      (* k (ft ft (- k 1)))))))
         10)

;a. Check (by evaluating the expression) that this really does compute factorials.
;Devise an analogous expression for computing Fibonacci numbers.

"Expression evaluates to 3628800, which is indeed 10!

It is not super easy to parse what is going on here. Let's follow the execution, using
the substitution model:"

((lambda (n)
         ((lambda (fact)
                  (fact fact n))
          (lambda (ft k)
                  (if (= k 1)
                      1
                      (* k (ft ft (- k 1)))))))
         10)

"======="

((lambda (fact)
         (fact fact 10))
 (lambda (ft k)
         (if (= k 1)
             1
            (* k (ft ft (- k 1))))))

"========"

 ((lambda (ft k)
         (if (= k 1)
             1
            (* k (ft ft (- k 1)))))
   (lambda (ft k)
         (if (= k 1)
             1
            (* k (ft ft (- k 1)))))
  10)

 "========"

 (if (= 10 1)
     1
     (* 10 ((lambda (ft k)
                  (if (= k 1)
                      1
                      (* k (ft ft (- k 1)))))
           (lambda (ft k)
                   (if (= k 1)
                       1
                       (* k (ft ft (- k 1)))))

           (- 10 1))))

 "=========="

 (* 10 (if (= 9 1)
            1
            (* 9 ((lambda (ft k)
                          (if (= k 1)
                              1
                              (* k (ft ft (- k 1)))))
                  (lambda (ft k)
                          (if (= k 1)
                              1
                              (* k (ft ft (- k 1)))))

                  (- 9 1)))))

 "======"

  (* 10 (* 9 (if (= 8 1)
                 1
                 (* 8 ((lambda (ft k)
                               (if (= k 1)
                                    1
                                   (* k (ft ft (- k 1)))))
                       (lambda (ft k)
                               (if (= k 1)
                                   1
                                   (* k (ft ft (- k 1)))))

                       (- 8 1))))))

  "...."

  (* 10 (* 9 (* 8 (* 7 (* 6 (* 5 (* 4 (* 3 (* 2 (if (= 1 1)
                                                    1
                                                    (* 1 ((lambda (ft k)
                                                                  (if (= k 1)
                                                                      1
                                                                      (* k (ft ft (- k 1)))))
                                                          (lambda (ft k)
                                                                  (if (= k 1)
                                                                      1
                                                                      (* k (ft ft (- k 1)))))

                                                          (- 1 1)))))))))))))
  "==="
  (* 10 (* 9 (* 8 (* 7 (* 6 (* 5 (* 4 (* 3 (* 2 1)))))))))
  "==="
  3628800  


;b. Consider the following procedure, which includes mutually recursive internal
;definitions:

(define (f x)
        (define (even? n)
                (if (= n 0)
                    #t
                    (odd? (- n 1))))
        (define (odd? n)
                (if (= n 0)
                    #f
                    (even? (- n 1))))
        (even? x))

;Fill in the missing expressions to complete an alternative definition of `f`, which
;uses neither internal definitions nor `letrec`:

(define (f x)
        ((lambda (even? odd?)
                 (even? even? odd? x))
         (lambda (ev? od? n)
                 (if (= n 0) #t (od? ev? od? (- n 1))))
         (lambda (ev? od? n)
                 (if (= n 0) #f (ev? ev? od? (- n 1))))))

(f 9) #f
(f 10) #t
(f 11) #f
(f 12) #t