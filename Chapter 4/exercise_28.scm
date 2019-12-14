;Exercise 4.28.  `eval` uses `actual-value` rather than `eval` to
;evaluate the operator before passing it to `apply`, in order to force
;the value of the operator. Give an example that demonstrates the need
;for this forcing.

"Take any procedure which takes a procedure as input and applies it in its body,
like:"

(define (do-twice f x) (f (f x)))

"And consider this application:"

(do-twice (lambda (x) (+ 1 x)) 1)

"The two arguments here get thunk-ified, so when the body of `do-twice` gets
evaluated, it does with a thunk-ified lambda expression (and thunk-ified `1`)
as arguments. `eval` will correctly identify the body of `do-twice` as an application,
and try to run `apply` on it. If it does so without forcing the thunk-ified lambda
expression, `apply` will not recognise the application as involving either
a primitve or compound procedure, and will error."

