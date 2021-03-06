;Exercise 4.37.  Ben Bitdiddle claims that the following method for generating
;Pythagorean triples is more efficient than the one in exercise 4.35. Is he correct?
;(Hint: Consider the number of possibilities that must be explored.)

(define (a-pythagorean-triple-between low high)
        (let ((i (an-integer-between low high))
              (hsq (* high high)))
             (let ((j (an-integer-between i high)))
                  (let ((ksq (+ (* i i) (* j j))))
                       (require (>= hsq ksq))
                       (let ((k (sqrt ksq)))
                            (require (integer? k))
                            (list i j k))))))

"Ben is absolutely correct. In the worst case, his procedure checks one case for every
pair of integers between <low, low> and <high, high>; the old procedure, in the worst
case, checks once for every *triple* between <low, low, low> and <high, high, high>.
So the old procedure checks as many cases as Ben's times high - low."