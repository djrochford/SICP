;Exercise 2.68.  The `encode` procedure takes as arguments a message 
;and a tree and produces the list of bits that gives the encoded message.

(define (encode message tree)
        (if (null? message)
            '()
            (append (encode-symbol (car message) tree)
                    (encode (cdr message) tree))))

;`encode-symbol` is a procedure, which you must write, 
;that returns the list of bits that encodes a given symbol according to a given tree.
;You should design encode-symbol so that it signals an error 
;if the symbol is not in the tree at all. 

"First, we need something to check if a given symbol is in the set of symbols of a branch of a tree:"

(define (in? symbol symbol-set)
        (cond ((null? symbol-set) #f)
              ((eq? symbol (car symbol-set)) #t)
              (else (in? symbol (cdr symbol-set)))))

"and some helpers from earlier..."

(define (leaf? object)
        (eq? (car object) 'leaf))
(define (symbols tree)
        (if (leaf? tree)
            (list (symbol-leaf tree))
            (caddr tree)))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

"Voilà:"
(define (encode-symbol symbol tree)  
        (cond ((leaf? tree) '())
              ((in? symbol (symbols (left-branch tree))) 
               (cons 0 (encode-symbol symbol (left-branch tree))))
              ((in? symbol (symbols (right-branch tree)))
               (cons 1 (encode-symbol symbol (right-branch tree))))
              (else (error "Symbol not in tree -- ENCODE-SYMBOL" symbol tree))))

;Test your procedure by encoding the result you obtained in exercise 2.67
;with the sample tree and seeing whether it is the same as the original sample message.


"From 2.68:"
(define (make-leaf symbol weight)
        (list 'leaf symbol weight))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (weight tree)
        (if (leaf? tree)
            (weight-leaf tree)
            (cadddr tree)))
(define (make-code-tree left right)
        (list left
              right
              (append (symbols left) (symbols right))
              (+ (weight left) (weight right))))
(define sample-tree
        (make-code-tree (make-leaf 'A 4)
                        (make-code-tree (make-leaf 'B 2)
                                        (make-code-tree (make-leaf 'D 1)
                                                        (make-leaf 'C 1)))))

"The test"
(encode '(a d a b b c a) sample-tree) ;(0 1 1 0 0 1 0 1 0 1 1 1 0) -- i.e., the correct thing. 