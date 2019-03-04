"We'll need the tree selectors for this question:"

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))


;Exercise 2.63.  Each of the following two procedures converts a binary tree to a list.

(define (tree->list-1 tree)
        (if (null? tree)
            '()
            (append (tree->list-1 (left-branch tree))
                    (cons (entry tree)
                          (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
        (define (copy-to-list tree result-list)
                (if (null? tree)
                    result-list
                    (copy-to-list (left-branch tree)
                                  (cons (entry tree)
                                        (copy-to-list (right-branch tree)
                                                      result-list)))))
        (copy-to-list tree '()))

;a. Do the two procedures produce the same result for every tree?
;If not, how do the results differ? 
;What lists do the two procedures produce for the trees in figure 2.16?

"The trees in figure 2.16, represented as lists, are as follows:"

(define tree1 (list 7 (list 3 (list 1 '() '()) (list 5 '() '())) (list 9 '() (list 11 '() '()))))

(define tree2 (list 3 (list 1 '() '()) (list 7 (list 5 '() '()) (list 9 '() (list 11 '() '())))))

(define tree3 (list 5 (list 3 (list 1 '() '()) '()) (list 9 (list 7 '() '()) (list 11 '() '()))))

tree1 ; (7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))

tree2 ; (3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))

tree3 ; (5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))

"Here they are converted to straight lists, using both procedures:"

(tree->list-1 tree1) ; (1 3 5 7 9 11)

(tree->list-2 tree1) ; (1 3 5 7 9 11)

(tree->list-1 tree2) ; (1 3 5 7 9 11)

(tree->list-2 tree2) ; (1 3 5 7 9 11)

(tree->list-1 tree3) ; (1 3 5 7 9 11)

(tree->list-2 tree3) ; (1 3 5 7 9 11)

"As you can see, they are all the same. This might lead you to suspect that `tree->list-1` and `tree->list-2`
are in general equivalent. Indeed, that is so; here's a proof.

First, a lemma: for all trees T, (tree->list-1 T) and (tree->list-2 T) are both ordered;
i.e., the lowest element of T is the first element of (tree>-list-1 T), 
the second lowest element of T is the second element of (tree->list-1 T), and so on, and the same is true for `tree->list-2`.

I prove the lemma first for `tree->list-1`. Proof by induction on the number of elements in T.

Base case: suppose T has 0 elements. Then (tree->list-1 T) = the empty list, and trivially the empty list is ordered.

Inductive step: suppose the lemma is true for trees of size k and lower. Suppose T is a tree of size k+1. 

So (tree->list-1 T) = (append (tree->list-1 (left-branch T))
                                (cons (entry T)
                                      (tree->list-1 (right-branch T))))))

Call (tree->list-1 (left-branch T)) 'lefty', and (tree->list-1 (right-branch T)) 'righty'.
(left-branch T) and (right-branch T) are trees of size k or lower, so, by hypothesis, the lemma is true of them,
and lefty and righty are both ordered lists.

Now, (tree->list-1 T) = (append lefty (cons (entry T) righty))))

And, by the properties of our trees, every element of (left-branch T) is lower than (entry T) 
which is lower than every element of (right-branch T);
so every element of lefty is lower than (entry T) is lower than every element of righty.

So (append lefty (cons (entry T) righty)) is ordered. So (tree->list-1 T) is ordered.

That proves the lemma for `tree->list-1`. Now for `tree->list-2`. This is a little more complicated.

First, a sub-lemma: if `result-list` is ordered, and contains only elements greater than those in `tree`, then
`(copy-to-list tree result-list)` is ordered.

Proof by induction. Suppose `tree` is the empty list. Then `(copy-to-list tree result-list)` equals `result-list`, which is
by hypothesis, ordered. So the sub-lemma is true in the base case.

Inductive step: Suppose the sub-lemma is true for trees of size k and lower. Consider tree T, of size k+1.

Now, `(copy-to-list T result-list)` equals `(copy-to-list (left-branch tree)
                                                     (cons (entry tree)
                                                           (copy-to-list (right-branch tree)
                                                                         result-list)))))`

By hypothesis, `result-list` contains only elements greater than those in T, so it contains only elements greater than those
in `(right-branch T)`. And `(right-branch T)` is a tree of size k or lower. So, by the inductive hypothesis,
`(copy-to-list (right-branch tree) result-list)` is ordered. Call it `righty`.
`(entry tree)` is smaller than every element of `righty` (as it is smaller than every element of `(right-branch tree)` and thus smaller
than every element of `result-list`, and thus smaller than everything in righty).

So `(cons (entry tree) (copy-to-list (right-branch tree) result-list))` is ordered. Call it righty-plus

`(copy-to-list T result-list)` equals 
`(copy-to-list (left-branch tree) righty-plus)`
And (left-branch tree) is a tree of size k or lower, and contains only elements lower than righty-plus.
So, by the inductive hypothesis, `(copy-to-list (left-branch tree) righty-plus)` is ordered.

So `(copy-to-list T result-list)` is ordered, assuming `result-list` is ordered and contains only elements greater than T.

That proves the inductive step of the sub-lemma, which proves the sub-lemma.

Ok, now to prove the lemma itself, for `tree->list-2`. `(tree-list-2 tree)` equals `(copy-to-list tree '())`.
So what needs to be shown is that the lemma is true for `(copy-to-list tree '())`. Proof by induction.

Base case: suppose `tree` is the empty list. Then `(copy-to-list tree '())` equals '(), and is trivially ordered.
That proves the base case.

Now the inductive step. Suppose the lemma is true for all trees of size k or lower. Consider tree T, of size k+1.

`(copy-to-list T '()')` in that case equals `(copy-to-list (left-branch T)
                                                                  (cons (entry T)
                                                                        (copy-to-list (right-branch T)
                                                                                      '() )))))`
Now, `(right-branch T)` is a tree of size k smaller, so, by hypothesis, `(copy-to-list (right-branch T) '())` is
ordered. And, obviously, `(copy-to-list (right-branch T) '())` contains only elements of `(right-branch T)`, which are
all greater than `(entry T)`. So `(cons (entry T) (copy-to-list (right-branch T)'() )))))` is ordered. Call it `righty`.

So `(copy-to-list T '()) equals `(copy-to-list (left-branch T)) righty)`, where `righty` is an ordered list that
contains only-elements greater than `(left-branch T)`. By the sub-lemma, then, `(copy-to-list (left-branch T)) righty)` is
ordered. so `(copy-to-list T '())` is ordered. That proves the inductive step, which proves the lemma for `tree->list-2`.

So the lemma is proved for both cases.

The result is an immediate corollary of the lemma, as if (tree->list-1 T) and (tree->list-2 T) both contain the same elements,
and are ordered, then they are equal. (I won't prove that `(tree->list-1 T)` and `(tree->list-2 T)` contain the same elements.
That's a corollary of the fact that they only contain the elements of T, which you could prove by induction, but I take it to be
obvious enough to not require a proof.)
"

;b. Do the two procedures have the same order of growth .
;in the number of steps required to convert a balanced tree with n elements to a list?
;If not, which one grows more slowly?

"For both tree->list1 and tree->list2, a recursive call will occur once for each element of the tree.
But tree->list1 will call an `append` for each element, wheras tree->list2 will only call `cons`.
`cons` is, presumably, constant time, so tree->list-2 is a linear time algorithm.
But `append` is linear in the size of the first parameter.

Now, for each recursive call, the size of the first parameter passed to `append` is (in a balanced tree)
half the size of the previous call. So the total work is order n + 2 * n/2 + 4 * n/4 ... (log n times),
i.e. order n log n.

So tree->list-1 is slower than tree->list-2
