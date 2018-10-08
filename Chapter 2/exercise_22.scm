;Exercise 2.22.  Louis Reasoner tries to rewrite the first `square-list` procedure of exercise 2.21 
;so that it evolves an iterative process:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items '()))

;Unfortunately, defining `square-list` this way produces the answer list in the reverse order of the one desired. Why?

"We'll consider the evolution of the process using the substitution model.
Consider the time iter is called when `things` is, say, (1 2 3 4) 
The values of `things` and `answer` are:"

(list 1 2 3 4)
'()

"The next time around they are `(cdr things)` equals:"
(list 2 3 4)
"and `(cons (square (car things) answer))` equals
`(cons (square (car (list 1 2 3 4))) '() )` equals:"
(cons 1 '())
"equals"
(list 1)

"The third time around:"
"`things`:" (list 3 4)
"`answer`: `(cons (square (car (list 2 3 4)) (list 1))` equals"
(list 4 1)
"which you can see is in the reverse order to the desired one. If we continue answer will be"
(list 9 4 1)
"then"
(list 16 9 4 1)

"To describe what is happening in a general way: on each iteration, 
we're passing in the back end of `things`,
then putting the first part of the back end of `things`
on to the front end of `answers`, thus making `answers` in the reverse order
of `things`"


;Louis then tries to fix his bug by interchanging the arguments to cons:


(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

(square-list (list 1 2 3 4))

;This doesn't work either. Explain.

"Again, observe the evolution of the argument via the substitution model:"
(list 1 2 3 4)
'()

(list 2 3 4)
"`(cons '() (square 2))` equals"
(list '() 1)

(list 3 4)
"`(cons (list '() 1) (square 2))` equals"
(list (list '() 1) 4)

"As you can see, what's happening is that the nesting of the lists is the wrong way around;
we're left-nesting, rather than right-nesting, which means we're making a list with `car`
the rest of processed `things`, rather with `cdr` the rest of the processed `things`.

The final result of `(square-list (list 1 2 3 4))` in this case is:"
(list (list (list (list '() 1) 4) 9) 16)
