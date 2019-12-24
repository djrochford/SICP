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

(define (text-of-quotation exp)
        (define (text-convert exp)
                (if (pair? exp)
                    (cons (text-convert (car exp))
                          (text-convert (cdr exp)))
                     exp))
        (text-convert (cadr exp)))

"(This assumes that `cons`, `car` and `cdr` (but not `cadr`) have beend defined in
the new way.)"