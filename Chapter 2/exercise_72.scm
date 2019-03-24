;Exercise 2.72.  Consider the encoding procedure that you designed in exercise 2.68.
;What is the order of growth in the number of steps needed to encode a symbol?
;Be sure to include the number of steps needed to search the symbol list at each node encountered.

;To answer this question in general is difficult. Consider the special case where the relative 
;frequencies of the n symbols are as described in exercise 2.71, and give the order of growth
;(as a function of n) of the number of steps needed to encode the most frequent
;and least frequent symbols in the alphabet.

"Here is my `encode-symbol`":
(define (encode-symbol symbol tree)  
        (cond ((leaf? tree) '())
              ((in? symbol (symbols (left-branch tree))) 
               (cons 0 (encode-symbol symbol (left-branch tree))))
              ((in? symbol (symbols (right-branch tree)))
               (cons 1 (encode-symbol symbol (right-branch tree))))
              (else (error "Symbol not in tree -- ENCODE-SYMBOL" symbol tree))))

"For a tree like the ones in 2.71, the most common symbol is encoded in constant time -- you check to see
that the symbol is among the set of symbols on the left, which includes only that one symbol, find it is there,
go to the left, find a leaf, and return the 0 that encodes the common symbol, all of which are constant operations in n.

The least common symbol requires that you first fail to find it in the set of symbols to the left, 
(1 comparison), then find it in the symbols on the right. That list has n-1 symbols in it; however,
the list is ordered, and least-common symbol always appears first, so you find it in one comparison.
So you do two comparisons at the first, branch, then two more at the second, and so on, n-1 times in all.
That's a linear number of operations in n.

The second most common symbol requires you to search one on the left, the n-1 on the right, then one on the left. 
In general, the kth-most frequent symbol requires
(1 + (n - (k-1)) * (k-1) + 1 steps, which grows linearly in n except when k = 0.

So generally speaking, `encode-symbol` takes linear time to encode a symbol.

