;Exercise 2.60.  We specified that a set would be represented as a list with no duplicates.
;Now suppose we allow duplicates. For instance, the set {1,2,3}
;could be represented as the list (2 3 2 1 3 2 2).
;Design procedures `element-of-set?`, `adjoin-set`, `union-set`, and `intersection-set` 
;that operate on this representation.

"`element-of-set` must be the same as before -- i.e.:"
(define (element-of-set? x set)
        (cond ((null? set) false)
              ((equal? x (car set)) true)
              (else (element-of-set? x (cdr set)))))

"`adjoin-set` and `union-set` can be simpler -- no checking if an element is already in the set we're returning."

(define adjoin-set cons)

(define (union-set set1 set2)
        (cond ((null? set2) set1)
              ((null? set1) set2)
              (else (cons (car set1) (union-set (cdr set1) set2)))))


"We could get fancy with `intersection-set` to make it a bit more efficient (by memoizing),
 but the most straightforward implementation is to leave it the same:"
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) (cons (car set1)
                                                 (intersection-set (cdr set1) 
                                                                   set2)))
        (else (intersection-set (cdr set1) set2))))

;How does the efficiency of each compare with the corresponding procedure for the non-duplicate representation?

"Obviously, `element-of-set` and `intersection-set` scale the same way with the size of the input in both cases.
However, the input is liable to be larger with the second, repeating element representation, so in practice these may take
a bit longer, on average. Whether this is significant depends on how much larger the input is liable to be."

"`adjoin set` and `union-set` are much faster on this second representation; `adjoin-set` is constant
time (assuming `cons` is constant time, which it should be), as opposed to linear, and `union-set` is linear in the size
of set1, as opposed to linear in the size of the product of set1 and set2."

;Are there applications for which you would use this representation in preference to the non-duplicate one?

"I would use this application if I wasn't very worried about taking up space and I was going to be doing a lot more
unioning than intersecting. No application for which this is true springs to mind, but I'm sure there are plenty."