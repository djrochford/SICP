;Exercise 2.39.   Complete the following definitions of reverse (exercise 2.18)
;in terms of fold-right and fold-left from exercise 2.38.

(define (reverse-right sequence)
        (fold-right (lambda (x y)
                            (append y (list x)))
                    () 
                    sequence))

(reverse-right (list 1 2 3 4 5)) ;(5 4 3 2 1)


(define (reverse-left sequence)
        (fold-left (lambda (x y) (cons y x)) () sequence))

(reverse-left (list 1 2 3 4 5)) ;(5 4 3 2 1)