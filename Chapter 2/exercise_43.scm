;Exercise 2.43.  Louis Reasoner is having a terrible time doing exercise 2.42. 
;His `queens` procedure seems to work, but it runs extremely slowly. 
;(Louis never does manage to wait long enough for it to solve even the 6 × 6 case.) 
;When Louis asks Eva Lu Ator for help, 
;she points out that he has interchanged the order of the nested mappings in the flatmap, 
;writing it as

(flatmap (lambda (new-row) 
                 (map (lambda (rest-of-queens)
                              (adjoin-position new-row 
                                               k 
                                               rest-of-queens))
                      (queen-cols (- k 1))))
         (enumerate-interval 1 board-size))

;Explain why this interchange makes the program run slowly.

"As a reminder, the original, code, in context, is:"
(define (queens board-size)
        (define (queen-cols k)
                (if (= k 0)
                    (list empty-board)
                    (filter (lambda (positions) (safe? k positions))
                            ;changed code here...
                            (flatmap (lambda (rest-of-queens) 
                                             (map (lambda (new-row) 
                                                          (adjoin-position new-row 
                                                                           k 
                                                                           rest-of-queens))
                                                  (enumerate-interval 1 board-size)))
                                     (queen-cols (- k 1))))))
                            ;to here.
        (queen-cols board-size))

"Here, `queen-cols` is a recursive procedure, 
but it describes an iterative process --
that is, each call to `queen-cols` triggers one more call
to `queen-cols`, until it hits the base case when k = 0.
So, given that the initial value of `k` is `board-size,
there's a total of `board-size` calls to `queen-cols`
in the original code."

"On the other hand, in Louis's code, each call to `queen-cols` 
triggers as many further calls to `queen-cols` as there are applications
of the outer lambda expression, in the `filter`, 
which is one for every member of `(enumerate-interval 1 boar- size)`.
So every call to `queen-cols` triggers `board-size` many further calls
to `queen-cols`, until they hit the base case.

So there will be the 1 initial call to `queen-cols` where k = `board-size`,
then `board-size` calls where k = `board-size - 1`
then `board-size` * `board-size` calls where k = `board-size` - 2,
and so on.
In total, that's `board-size`^`board-size` calls to `queen-cols`.
"

;Estimate how long it will take Louis's program to solve the eight-queens puzzle,
;assuming that the program in exercise 2.42 solves the puzzle in time T.

"With `board-size` many calls to `queen-cols`, 
the original code takes T time to process.
So it takes T/`board-size` times per call to `queen-cols`.

With `board-size`^`board-size` many calls to `queen-cols`,
you'd expect Louis's code to take `board-size`^`board-size` *
T/`board-size` = `board-size`^(`board-size` - 1) * T"