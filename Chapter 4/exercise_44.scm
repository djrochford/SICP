;Exercise 4.44.  Exercise 2.42 described the ``eight-queens puzzle'' of placing queens on a
;chessboard so that no two attack each other. Write a nondeterministic program to solve this puzzle.

"Here is a highly inefficient but clear solution."

(define (ok? board)
        (define (pair-ok? queen1 queen2)
                (not (or (= (car queen1) (car queen2))
                         (= (cdr queen1) (cdr queen2))
                         (= (abs (- (car queen1) (car queen2))) 
                            (abs (- (cdr queen1) (cdr queen2)))))))
        (define (one-to-many-ok? queen board)
                (if (null? board)
                    #t
                    (and (pair-ok? queen (car board))
                         (one-to-many-ok queen (cdr board)))))
        (if (null? board)
            #t
            (and one-to-many-ok? (car board) (cdr board)
                 (ok? (cdr board)))))

(define (eight-queens)
        (let ((queen1 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen2 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen3 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen4 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen5 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen6 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen7 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))
              (queen8 (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8))))
             (require (ok? (list queen1 queen2 queen3 queen4 queen5 queen6 queen7 queen8)))))
