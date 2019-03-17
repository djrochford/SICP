;The following eight-symbol alphabet with associated relative frequencies 
;was designed to efficiently encode the lyrics of 1950s rock songs.
;(Note that the ``symbols'' of an ``alphabet'' need not be individual letters.)

;A 2 NA  16
;BOOM  1 SHA 3
;GET 2 YIP 9
;JOB 2 WAH 1
;Use generate-huffman-tree (exercise 2.69) to generate a corresponding Huffman tree,
"Some needed stuff":

(define (weight-leaf x) (caddr x))

(define (symbol-leaf x) (cadr x))


(define (leaf? object)
        (eq? (car object) 'leaf))

(define (weight tree)
        (if (leaf? tree)
            (weight-leaf tree)
            (cadddr tree)))

(define (symbols tree)
        (if (leaf? tree)
            (list (symbol-leaf tree))
            (caddr tree)))

(define (make-leaf symbol weight)
        (list 'leaf symbol weight))

(define (make-code-tree left right)
        (list left
              right
              (append (symbols left) (symbols right))
              (+ (weight left) (weight right))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
        (if (null? pairs)
            '()
            (let ((pair (car pairs)))
                 (adjoin-set (make-leaf (car pair)    ; symbol
                                        (cadr pair))  ; frequency
                             (make-leaf-set (cdr pairs))))))

(define (successive-merge leaf-set)
        (cond ((null? leaf-set) '())
              ((null? (cdr leaf-set)) (car leaf-set))
              (else (successive-merge (adjoin-set (make-code-tree (car leaf-set)
                                                                  (cadr leaf-set))
                                                   (cddr leaf-set))))))

(define (generate-huffman-tree pairs)
        (successive-merge (make-leaf-set pairs)))

"Now:"

(define lyrics '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1)))

(define 50s-rock-tree (generate-huffman-tree lyrics))

50s-rock-tree
"
((leaf na 16) ((leaf yip 9) (((leaf a 2) ((leaf wah 1) (leaf boom 1) (wah boom) 2) (a wah boom) 4) ((leaf sha 3) ((leaf job 2) (leaf get 2) (job get) 4) (sha job get) 7) (a wah boom sha job get) 11) (yip a wah boom sha job get) 20) (na yip a wah boom sha job get) 36)

i.e. |----|-------|-------------------|----------|-----GET
     |    |       |                   |          |
     NA   YIP     |-----|----BOOM     SHA       JOB
                  |     |
                  A    WAH
"

;and use encode (exercise 2.68)

"i.e."

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (in? symbol symbol-set)
        (cond ((null? symbol-set) #f)
              ((eq? symbol (car symbol-set)) #t)
              (else (in? symbol (cdr symbol-set)))))

(define (encode-symbol symbol tree)  
        (cond ((leaf? tree) '())
              ((in? symbol (symbols (left-branch tree))) 
               (cons 0 (encode-symbol symbol (left-branch tree))))
              ((in? symbol (symbols (right-branch tree)))
               (cons 1 (encode-symbol symbol (right-branch tree))))
              (else (error "Symbol not in tree -- ENCODE-SYMBOL" symbol tree))))

(define (encode message tree)
        (if (null? message)
            '()
            (append (encode-symbol (car message) tree)
                    (encode (cdr message) tree))))

;to encode the following message:

;Get a job

(encode '(GET A JOB) 50s-rock-tree) ;(1 1 1 1 1 1 1 0 0 1 1 1 1 0)

;Sha na na na na na na na na

(encode '(SHA NA NA NA NA NA NA NA NA) 50s-rock-tree) ;(1 1 1 0 0 0 0 0 0 0 0 0)

;Wah yip yip yip yip yip yip yip yip yip

(encode '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP) 50s-rock-tree) ; (1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)

;Sha boom

(encode '(SHA BOOM) 50s-rock-tree) ;(1 1 1 0 1 1 0 1 1)

;How many bits are required for the encoding?
"14 + 12 + 23 + 9 = 58 bits"

;What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?
"A fixed-length code would require log_2 8 = 3 bits to encode each symbol in the 8-alphabet language. There are a total
of 3 + 9 + 10 + 2 = 24 symbols in the above message. So encoding this song in a fixed-length code would
require 3 * 24 = 72 bits."