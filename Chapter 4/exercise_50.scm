;Exercise 4.50.  Implement a new special form `ramb` that is like `amb` except that it searches alternatives
;in a random order, rather than from left to right. 

"The original `analyze-amb`, for reference:"

(define (analyze-amb exp)
        (let ((cprocs (map analyze (amb-choices exp))))
             (lambda (env succeed fail)
                     (define (try-next choices)
                             (if (null? choices)
                                 (fail)
                                 ((car choices) env succeed (lambda ()
                                                                    (try-next (cdr choices))))))
                     (try-next cprocs))))

"Here's my `analyze-ramb`. It's almost exactly the same; the difference is in the last line."

(define (analyze-ramb exp)
        (let ((cprocs (map analyze (amb-choices exp))))
             (lambda (env succeed fail)
                     (define (try-next choices)
                             (if (null? choices)
                                 (fail)
                                 ((car choices) env succeed
                                                (lambda ()
                                                        (try-next (cdr choices))))))
                     (try-next (shuffle cprocs))))) ; difference here.

"We can implement `shuffle` like so:"

(define (shuffle items)
        (let ((size (length items)))
             (if (= size 1)
                 items
                 (let* ((index (+ 1 (random size)))
                        (rearranged (rearrange items index)))
                       (cons (car rearranged) (shuffle (cdr rearranged)))))))

"Where `rearrange` returns a list with the `index` element of `items` at the head,
and the remainder of the list spliced together as the tail:"

(define (rearrange items index)
        (define (iterate index seen index-item rest count)
                (if (null? rest)
                    (cons index-item seen)
                    (if (= count index)
                        (iterate index seen (car rest) (cdr rest) (+ 1 count))
                        (iterate index (append seen (list (car rest))) index-item (cdr rest) (+ 1 count)))))
        (iterate index () '() items 1))

(shuffle (list 1 2 3 4 5))

;Show how this can help with Alyssa's problem in exercise 4.49.

"This can help by ranomdizing the word selected, once the part of speech of the word has been determined,
rather than marching through the list in order, which makes for more interesting sentences sooner. The
only change required to make this happen is to use `ramb` in exercise 4.49 version of `parse-word`, rather than
`amb`. It looks like this:"

(define (parse-word word-list)
        (require (not (null? word-list)))
        (ramb (car word-list)
              (parse-word (cdr word-list))))