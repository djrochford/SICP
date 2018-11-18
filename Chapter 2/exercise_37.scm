;Exercise 3.37 Suppose we represent vectors v = (v_i) as sequences of numbers, 
;and matrices m = (m_(ij)) as sequences of vectors (the rows of the matrix). For example, the matrix
; _     _
;|1 2 3 4|
;|4 5 6 6|
;|6 7 8 9|
;-       -
;is represented as the sequence 

;((1 2 3 4) (4 5 6 6) (6 7 8 9))

;With this representation, 
;we can use sequence operations to concisely express the basic matrix and vector operations.
;These operations (which are described in any book on matrix algebra) are the following:

;(dot-product v w) returns Sum_i (v_i * w_i)
;(matrix-*-vector m v) returns the vector t, where t_i = Sum_j (m_(ij) * v_j)
;(matrix-*-matrix m n) returns the matrix p, where p_(ij) = Sum_k (m_(ik) n_(kj))
;(transpose m) returns the matrix n, where n_(ij) = m_(ji)

;We can define the dot product as:

(define (dot-product v w)
        (accumulate + 0 (map * v w)))

;Fill in the missing expressions in the following procedures 
;for computing the other matrix operations. 
;(The procedure accumulate-n is defined in exercise 2.36.)

"Just so we have it handy:"


(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
        (if (null? (car seqs))
            ()
            (cons (accumulate op init (map (lambda (seq) (car seq)) seqs))
                  (accumulate-n op init (map (lambda (seq) (cdr seq)) seqs)))))

"The answers:"
(define (matrix-*-vector m v)
        (map (lambda (w) (dot-product w v)) m))

(define M (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

(define V (list 1 1 1 1))

(matrix-*-vector M V) ;(10 21 30)

(define (transpose mat)
        (accumulate-n cons () mat)) 

(transpose M) ;((1 4 6) (2 5 7) (3 6 8) (4 6 9))

(define (matrix-*-matrix m n)
        (let ((cols (transpose n)))
             (map (lambda (v) (matrix-*-vector cols v)) m)))

(matrix-*-matrix M (transpose M)) ;((30 56 80) (56 113 161) (80 161 230))