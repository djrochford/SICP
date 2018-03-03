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

(define (dot-product v w)
        (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
        (map (lambda (w) (dot-product w v)) m))

(define M (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

(define V (list 1 1 1 1))

(matrix-*-vector M V)

(define (transpose mat)
        (accumulate-n cons () mat))

(transpose M)

(define (matrix-*-matrix m n)
        (let ((cols (transpose n)))
             (map (lambda (v) (matrix-*-vector cols v)) m)))

(matrix-*-matrix M (transpose M))