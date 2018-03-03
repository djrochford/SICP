(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
        (accumulate + 0 (map (lambda (tree)
                                     (if (not (pair? tree)) 
                                         1
                                         (count-leaves tree))) 
                             t)))

(count-leaves (list 1 2 (list 3 (list 4 5) (list 6 7) 8 9) 10 11 (list 12)))