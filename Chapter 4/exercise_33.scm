;Exercise 4.33.  Ben Bitdiddle tests the lazy list implementation given above
;by evaluating the expression

(car '(a b c))

;To his surprise, this produces an error. After some thought, he realizes that
;the "lists" obtained by reading in quoted expressions are different from the
;lists manipulated by the new definitions of `cons`, `car`, and `cdr`. Modify
;the evaluator's treatment of quoted expressions so that quoted lists typed at
;the driver loop will produce true lazy lists.

"Recall that, currently, when `eval` evaluates a quoted expression, it applies:"

(define (text-of-quotation exp) (cadr exp))

"We'll change this to handles pairs, and hence lists, differently."
"Let `new-cons` be the cons as defined in this part of this text. Then we'll let
`text-of-quotation` be:"

(define (text-of-quotation exp)
        (define (text-convert exp)
                (if (pair? exp)
                    (new-cons (text-convert (car exp))
                          (text-convert (cdr exp)))
                     exp))
        (text-convert (cadr exp)))