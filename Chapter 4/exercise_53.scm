;Exercise 4.53.  With `permanent-set!` as described in exercise 4.51 and `if-fail`
;as in exercise 4.52, what will be the result of evaluating

(let ((pairs '()))
     (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
                   (permanent-set! pairs (cons p pairs))
                   (amb))
              pairs))

"The results will be all pairs where the first element is one of `'(1 3 5 8)`,
the second is one of `'(20, 35, 110)`, and the sum of the pair is prime. I.e.:"

'((3 20) (3 110) (8 35))



