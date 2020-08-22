;Exercise 4.70.  What is the purpose of the `let` bindings in the procedures `add-assertion!`
;and `add-rule!`? What would be wrong with the following implementation of `add-assertion!`?

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
        (cons-stream assertion THE-ASSERTIONS))
  'ok)

;Hint: Recall the definition of the infinite stream of ones in section 3.5.2:
(define ones (cons-stream 1 ones))

"The `cons-stream` expression in `add-assertion` evaluates to a list containing
whatever `assertion` is bound to, and a thunk, waiting to evaluate `THE-ASSERTIONS`.
When `THE-ASSERTIONS` is evaluated, it will be in an environment in which
`THE-ASSERTIONS` is bound to the very list containing the thunk, by the `set! THE-ASSERTIONS`
expression that contains the `cons-stream` expression. 
`THE-ASSERTIONS` has effectively become an infinite stream of `assertion`s. This is
*not* what what was intended, which was to put `assertion` at the front of the
stream of already existing assertions -- i.e., the thing `THE-ASSERTIONS` was bound to
*before* the `set!` statement was evaluated, not afterwards.

The `let` binding used in the book's definition of `add-assertion!` is to give us a way,
after the `set!` expression is evaluated, to reference the value `THE-ASSERTIONS` from
before the `set!` expression was evaluated.
"
