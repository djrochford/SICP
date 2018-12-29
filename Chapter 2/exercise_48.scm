;Exercise 2.48.  A directed line segment in the plane can be represented as a pair of vectors 
;-- the vector running from the origin to the start-point of the segment,
;and the vector running from the origin to the end-point of the segment. 
;Use your vector representation from exercise 2.46 to define a representation 
;for segments with a constructor `make-segment` and selectors `start-segment` and `end-segment`.

"I'm a bit unclear on what is being asked for here. 
The most straightforward way to implement the segment constructor and selectors is like so:"

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

"...assuming that the arguments of `make-segment` will be vectors, as described in the question.
But this isn't using the vector representation of exercise 2.46 in any interesting way.

Something else you could do is assume that `make-segment` will take co-ordinates, and use those
to build vectors that gets stored as a pair that consitutes the segment. That would require that you
use the vector implementation of 2.46. But it's unclear why you'd do that."
