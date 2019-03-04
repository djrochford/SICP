;Exercise 2.65.  Use the results of exercises 2.63 and 2.64 to give a Theta(n) 
;implementations of `union-set` and `intersection-set` for sets implemented as 
;(balanced) binary trees.

"Alrighty:"
(define (union-set set1 set2)
        (let ((listy (append (tree->list-2 set1)
                             (tree->list-2 set2))))
             (list->tree listy)))


(define (intersection-set set1 set2)
        (let ((listy (intersection-list (tree->list-2 set1)
                                        (tree->list-2 set2)))
              (list->tree listy))))

"...where `intersection-list` is just a renamed version of the `intersection-set`
procedure in the text that works on sets as ordered lists."
