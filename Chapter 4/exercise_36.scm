;Exercise 4.36.  Exercise 3.69 discussed how to generate the stream of all Pythagorean
;triples, with no upper bound on the size of the integers to be searched. Explain
;why simply replacing `an-integer-between` by `an-integer-starting-from` in the
;procedure in exercise 4.35 is not an adequate way to generate arbitrary Pythagorean
;triples.

"Replacing `an-integer-between` by `an-integer-starting-from` in the
4.35 procedure looks like this:"

(define (a-pythagorean-triple-between)
        (let ((i (an-integer-starting-from 1)))
             (let ((j (an-integer-starting-from i)))
                  (let ((k (an-integer-starging-from j)))
                       (require (= (+ (* i i) (* j j)) (* k k)))
                       (list i j k)))))

"This is bad because of the order in which the search through the triples will occur
(given that the evaluator's search strategy is depth-first). All triples starting with
1 1 occur earlier in the search order than all other triples -- i.e., there are many
triples for which there are an infinite number of triples that occur earlier in the
search order, and thus will never be tried in a finite number of `try-again`s."


;Write a procedure that actually will accomplish this. (That is, write a procedure
;for which repeatedly typing `try-again` would in principle eventually generate all
;Pythagorean triples.)

(define (a-pythagorean-triple-between)
        (let* ((k (an-integer-starting-from 1)) 
               (j (an-integer-between 1 k))
               (i (an-integer-between 1 j)))
              (require (= (+ (* i i) (* j j)) (* k k)))
              (list i j k)))