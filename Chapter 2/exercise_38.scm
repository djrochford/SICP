;Exercise 2.38.  The accumulate procedure is also known as `fold-right`, 
;because it combines the first element of the sequence 
;with the result of combining all the elements to the right. 
;There is also a fold-left, which is similar to fold-right, 
;except that it combines elements working in the opposite direction:

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;What are the values of

(fold-right / 1 (list 1 2 3))
"1 / (2 / (3 / 1)) = 3/2"

(fold-left / 1 (list 1 2 3))
"((1 / 1) / 2) / 3 = 1/6"

(fold-right list '() (list 1 2 3))
"list 1 (list 2 (list 3 '())) = (1 (2 (3 ())))"

(fold-left list '() (list 1 2 3))
"list (list (list '() 1) 2) 3) = (((() 1) 2) 3)"

;Give a property that op should satisfy 
;to guarantee that fold-right and fold-left will produce the same values 
;for any sequence.

"
Being associative would *almost* do it, except for the unfortunate
way `initial` is used in `fold-left` and `fold-right`.
Let s1, s2, ... sn be the elements of  sequence
`(fold-left op initial sequence)` effectively folds the sequence
`(initial s1 s2 ... sn)`,
whereas `(fold-right op initial sequence)` effectively folds the sequence
`(s1 s2 ... sn initial)`
And clearly associativity isn't sufficient to make those folds equivalent.

(If that's not clear, then consider the case in which `sequence` has only
one element -- call is `s`. 
In that case `(fold-left op initial sequence)` = `(op initial s)`
but `(fold-right op initial sequence)` = `(op s initial)`, and
associativity obviously doesn't guarantee that those are equivalent.)

Apparently, a lot of people on the internet think that commutativity will
do the job. That seems to me to be choosing properties of operations
at random; there's no prima facie reason to think that will work, and it
doesn't. If you need convincing, try fold-left and fold-right with any
op that is commutative but not associative -- (lambda (x y) (+ (* x y) 1)),
for instance.

If op is associative *and* commutative, that is sufficient.
You can prove this by induction on the length of the sequence.

Before I begin: note that, in prefix notation, associativity is stated this way:
(op (op a b) c) = (op a (op b c))

Proof:

Base case: suppose `sequence` is empty. Then
`(fold-left op initial sequence)` = `initial` = `(fold-right op initial sequence)`

[Note: the associativity of op wasn't used -- the claim is true in general when `sequence` is empty]

Inductive step: suppose the hypothesis is true for sequences of length k.
Then `(fold-left op initial sequence)` = 
(op (op ... (op (op initial s1) s2) ... sk-1) sk)
= `(fold-right op initial sequence)`
= (op s1 (op s2 ... (op sk-1 (op sk initial))))

Now, consider a sequence of length k+1.
`(fold-left op initial sequence)` = (op (op (op ... (op (op initial s1) s2) ... sk-1) sk) sk+1)
= (op (op s1 (op s2 ... (op sk-1 (op sk initial)))) sk+1) (by the induction hypothesis)
= (op s1 (op (op s2 ... (op sk-1 (op sk initial))) sk+1)) (by associativity)
= (op s1 (op s2 (op ... (op sk-1 (op sk initial)) sk+1))) (by associativity)
= [repeat application of associativity k times]
= (op s1 (op s2 (op ... (op sk-1 (op sk (op initial sk+1))))))
= (op s1 (op s2 (op ... (op sk-1 (op sk (op sk+1 initial)))))) (by commutativity)
= `(fold-right op initial sequence)`

That proves the inductive step, which proves the result.
"
