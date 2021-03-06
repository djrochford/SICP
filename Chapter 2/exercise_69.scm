"Some needed stuff:"



(define (leaf? object)
        (eq? (car object) 'leaf))

(define (weight-leaf x) (caddr x))

(define (weight tree)
        (if (leaf? tree)
            (weight-leaf tree)
            (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf symbol weight)
        (list 'leaf symbol weight))

(define (make-leaf-set pairs)
        (if (null? pairs)
            '()
            (let ((pair (car pairs)))
                 (adjoin-set (make-leaf (car pair)    ; symbol
                                        (cadr pair))  ; frequency
                             (make-leaf-set (cdr pairs))))))

(define (symbol-leaf x) (cadr x))

(define (symbols tree)
        (if (leaf? tree)
            (list (symbol-leaf tree))
            (caddr tree)))

(define (make-code-tree left right)
        (list left
              right
              (append (symbols left) (symbols right))
              (+ (weight left) (weight right))))


;Exercise 2.69.  The following procedure takes as its argument a list of 
;symbol-frequency pairs (where no symbol appears in more than one pair)
;and generates a Huffman encoding tree according to the Huffman algorithm.

(define (generate-huffman-tree pairs)
        (successive-merge (make-leaf-set pairs)))

;`make-leaf-set` is the procedure given above that transforms the list of pairs
;into an ordered set of leaves. `successive-merge` is the procedure you must write,
;using `make-code-tree` to successively merge the smallest-weight elements of the set
;until there is only one element left, which is the desired Huffman tree.
;(This procedure is slightly tricky, but not really complicated. 
;If you find yourself designing a complex procedure, then 
;you are almost certainly doing something wrong. 
;You can take significant advantage of the fact that we are using an ordered set representation.)

(define (successive-merge leaf-set)
        (cond ((null? leaf-set) '())
              ((null? (cdr leaf-set)) (car leaf-set))
              (else (successive-merge (adjoin-set (make-code-tree (car leaf-set)
                                                                  (cadr leaf-set))
                                                   (cddr leaf-set))))))

(define sample-leaves (make-leaf-set '((A 4) (B 2) (D 1) (C 1))))

(define sample-tree (successive-merge sample-leaves))

sample-tree 

"
That evaluates to:
((leaf a 4) ((leaf b 2) ((leaf c 1) (leaf d 1) (c d) 2) (b c d) 4) (a b c d) 8)

i.e., |-----|------|--D1
      |     |      |
      A4    B2     C1
"