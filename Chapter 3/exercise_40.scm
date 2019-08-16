;Exercise 3.40.  Give all possible values of `x` that can result from executing

(define x 10)

(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

"
Call `(lambda () (set! x (* x x)))` A and (lambda () (set! x (* x x x))) B.

1,000,000: A executes in full, then B, OR B executes in full, then A.

100: A access `x` twice, both times finds it to be 10, multipies to get 100. B
executes in full. A sets `x` to 100.

10,000: A access `x`, finds it to be 10. B executes in full. A access `x` again,
find it to be 1000. Multiples to get 10,000. Sets to 10,000.
		OR
B access `x` twice, finds it to be 10 both times. A executes in full. The third
time `B` checks, `x` is 100. Multiplies to get 10,000. Sets to 10,000.

100,000: `B` access `x` once, find it to be 10. A executes in full. `B` finds
`x` to be 100 the next two times it access `x`. Multiples to get 100,000. Sets
to 100,000.

1,000: B access `x` three times, each time find it to be 10, multiples to get
1,000. A executes in full. B sets to 1,000

There are some other orders in which A and B can access `x`, in the middle of
processing, without setting `x`, that don't affect the outcomes.
"

;Which of these possibilities remain if we instead use serialized procedures:

(define x 10)

(define s (make-serializer))

(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (* x x x)))))

"Only one: 1,000,000."
