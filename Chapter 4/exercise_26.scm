;Exercise 4.26.  Ben Bitdiddle and Alyssa P. Hacker disagree over the importance
;of lazy evaluation for implementing things such as `unless`. Ben points out that
;it's possible to implement `unless` in applicative order as a special form. Alyssa
;counters that, if one did that, `unless` would be merely syntax, not a procedure
;that could be used in conjunction with higher-order procedures. Fill in the details
;on both sides of the argument. Show how to implement unless as a derived expression
;(like `cond` or `let`)...

(define (unless? exp) (tagged-list? exp 'unless))
(define (unless-condition exp) (cadr exp))
(define (unless-usual exp) (caddr exp))
(define (unless-exceptional exp) (caddr exp))

(define (unless->if exp)
        (make-if (unless-condition exp)
                 (unless-exceptional exp)
                 (unless-usual exp)))

;...and give an example of a situation where it might be useful to
;have unless available as a procedure, rather than as a special form.

"I suppose I could come up with a situation in which it would be handy to pass
an `unless` to a `map`, but anything you could do with an `unless` procedure
you could also do with a `lambda` expresssion wrapping an `unless` expression.
I don't think there is any *more* reason to want an `unless` procedure than to
want and `if` procedure."