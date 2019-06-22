;Exercise 3.14.  The following procedure is quite useful, although obscure:

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))



;Loop uses the "temporary" variable `temp` to hold the old value of the cdr of x,
;since the `set-cdr!` on the next line destroys the cdr. Explain what `mystery` does
;in general. 

"Mystery removes all elements from the input list and returns them in a new list in
reverse order."

;Suppose `v` is defined by `(define v (list 'a 'b 'c 'd))`. Draw the
;box-and-pointer diagram that represents the list to which `v` is bound.

"v ---> [a][-]-->[b][-]-->[c][-]--[d][/]"

;Suppose that
;we now evaluate `(define w (mystery v))`. Draw box-and-pointer diagrams that show the
;structures v and w after evaluating this expression.

"v --> [/]"
"w --> [d][-]-->[c][-]-->[b][-]-->[a][/]"

;What would be printed as the values
;of v and w ?

"*nothing* and `(d c b a)`."
