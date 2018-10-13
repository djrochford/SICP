;Exercise 2.26.  Suppose we define x and y to be two lists:

(define x (list 1 2 3))
(define y (list 4 5 6))

;What result is printed by the interpreter in response to evaluating each of the following expressions:

(append x y) ;(1 2 3 4 5 6)

(cons x y) ;((1 2 3) 4 5 6) 
"I got this one wrong when I first thought about it; I though it was `((1 2 3)(4 5 6))`. 
But of course, actually, that's:"
(list x y) ; ((1 2 3) (4 5 6))
"Remember: a list is a bunch of right-nested `cons`es."