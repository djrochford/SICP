(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;Exercise 1.20.  The process that a procedure generates is of course dependent on the rules used by the interpreter. 
;As an example, consider the iterative gcd procedure given above. Suppose we were to interpret this procedure using normal-order evaluation, as discussed in section 1.1.5. 
;(The normal-order-evaluation rule for `if` is described in exercise 1.5.) Using the substitution method (for normal order), illustrate the process generated in evaluating (gcd 206 40) and indicate the remainder operations that are actually performed. 
;How many remainder operations are actually performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?

"Normal order"
(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(if (= (remainder 206 40) 0) ;1 remainder evaluation here
    40
    (gcd (remainder 206 40) 
         (remainder 40 (remainder 206 40))))

(if (= (remainder 40 (remainder 206 40)) 0) ;2 remainder evaluations here
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40)) 
         (remainder (remainder 206 40) 
                    (remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40) 
                  (remainder 40 (remainder 206 40))) ;4 remainder evaluations here
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))))

(if (= (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40)))) ; 7 remainder evaluations here
       0)
       (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
       (gcd (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40) 
                               (remainder 40 (remainder 206 40))))
            (remainder (remainder (remainder 40 (remainder 206 40))
                                  (remainder (remainder 206 40)   
                                             (remainder 40 (remainder 206 40))))
                       (remainder (remainder 206 40)
                                  (remainder 40 (remainder 206 40))))))

(remainder (remainder 206 40)
            (remainder 40 (remainder 206 40))) ; 4 evaluations here

2

"Total of 18 evaluations of `remainder`"

"Applicative order"

(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (remainder 206 40))) ; 1 remainder evaluation here

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6))) ; 1 remainder evaluation here

(if (= 4 0)
    6
    (gcd 4 (remainder 6 4))) ; 1 remainder evaluation here

(if (= 2 0)
    4
    (gcd 2 (remainder 4 2))) ; 1 remainder evaluation here

(if (= 0 0)
    2
    (gcd 2 (remainder 2 0))) ; not evaluated

2

"Total 4 evaluations of `remainder`."


