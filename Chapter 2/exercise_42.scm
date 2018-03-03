(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
        (accumulate append () (map proc seq)))

(define (enumerate-interval m n)
        (if (> m n)
            ()
            (cons m (enumerate-interval (+ m 1) n))))

(define empty-board ())

(define (adjoin-position new-row column rest-of-queens)
        (cons (cons new-row column) rest-of-queens))

(define (safe? k board)
        (define (queen-wise-safe? new-queen old-queen)
                (not (or (= (car new-queen) (car old-queen))
                         (= (abs (- (car new-queen) (car old-queen))) 
                            (abs (- (cdr new-queen) (cdr old-queen)))))))
        (accumulate (lambda (position sofar?) (and (queen-wise-safe? (car board) position) 
                                                   sofar?))
                    #t
                    (cdr board)))

(define (queens board-size)
        (define (queen-cols k)
                (if (= k 0)
                    (list empty-board)
                    (filter (lambda (positions) (safe? k positions))
                            (flatmap (lambda (rest-of-queens) (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
                                                                   (enumerate-interval 1 board-size)))
                                     (queen-cols (- k 1))))))
        (queen-cols board-size))

(length (queens 5))