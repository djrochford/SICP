;Exercise 4.32.  Give some examples that illustrate the difference between the
;streams of chapter 3 and the "lazier" lazy lists described in this section. How
;can you take advantage of this extra laziness?

"A relatively obvious way to take advantage of this is to make an infinite tree:"

(define (next-level val)
        (cons (/ val 2) (+ val (/ val 2))))

(define cantor (cons (/ 1 2) (map next-level cantor)))
