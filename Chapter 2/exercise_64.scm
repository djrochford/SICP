;Exercise 2.64.  The following procedure `list->tree` converts an ordered list 
;to a balanced binary tree. The helper procedure `partial-tree` takes as arguments
;an integer n and list of at least n elements and constructs a balanced tree containing
;the first n elements of the list. The result returned by partial-tree is a pair
;(formed with `cons`) whose `car` is the constructed tree and whose `cdr` is 
;the list of elements not included in the tree.

(define (list->tree elements)
        (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
        (if (= n 0)
            (cons '() elts)
            (let ((left-size (quotient (- n 1) 2)))
                 (let ((left-result (partial-tree elts left-size)))
                      (let ((left-tree (car left-result))
                            (non-left-elts (cdr left-result))
                            (right-size (- n (+ left-size 1))))
                           (let ((this-entry (car non-left-elts))
                                 (right-result (partial-tree (cdr non-left-elts)
                                                             right-size)))
                                (let ((right-tree (car right-result))
                                      (remaining-elts (cdr right-result)))
                                     (cons (make-tree this-entry left-tree right-tree)
                                           remaining-elts))))))))

;a. Write a short paragraph explaining as clearly as you can how partial-tree works.

"
`partial-tree` works on the left sub-tree, the root ane the right sub-tree seperately, and `make-tree`s
them at the end. The left part of the tree consists of the first `(quotient (-n 1) 2)` elements of the input list;
the root the next after that, and the rest of elements make the right-subtree. The processing of each-subtree is via a recursive call to `partial-tree`; these recursive calls stop
when they hit the base case, and `n` = 0; in that case, `partial-tree` returns the pair of a) the empty tree
and b) all of the input elements.
"

;Draw the tree produced by list->tree for the list (1 3 5 7 9 11).

"
5 --- 9 ---11
|     |
|     7
|
1 -- 3
"

;b. What is the order of growth in the number of steps required by list->tree to convert a list of n elements?

"
There will be one call to `partial-tree` for each element of `elements`, and the work it does for each element is
constant time (basically just `cons`-ing), so the procedure has linear order of growth in the length of `elements`.
"