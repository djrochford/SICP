;Exercise 2.40.  Define a procedure `unique-pairs` that, 
;given an integer n, generates the sequence of pairs (i,j) with 1< j< i< n. 
;Use `unique-pairs` to simplify the definition of `prime-sum-pairs` given above.

"Just so we have accumulate an enumerate handy:"

(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate m n)
        (if (> m n)
            ()
            (cons m (enumerate (+ m 1) n))))

(enumerate 1 7) ; (1 2 3 4 5 6 7)

"The answer:"

(define (unique-pairs n)
        (accumulate append 
                    ()
                    (map (lambda (i) (map (lambda (j) (list i j)) 
                                          (enumerate 1 (- i 1))))
                         (enumerate 1 n))))

(unique-pairs 7) 
;((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4) 
; (6 1) (6 2) (6 3) (6 4) (6 5) (7 1) (7 2) (7 3) (7 4) (7 5) (7 6))

"Now to simplify prime-sum-pairs:"

(define (prime-sum-pairs n)
        (map make-pair-sum
             (filter prime-sum?
                    (unique-pairs n))))