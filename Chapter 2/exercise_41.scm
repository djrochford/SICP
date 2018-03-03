(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate m n)
        (if (> m n)
            ()
            (cons m (enumerate (+ m 1) n))))

(define (flatmap proc seq)
        (accumulate append () (map proc seq)))

(define (enumerate-triples n)
        (flatmap (lambda (k) (flatmap (lambda (j) (map (lambda (i) (list i j k))
                                                       (enumerate 1 n)))
                                      (enumerate 1 n)))
                 (enumerate 1 n)))

(enumerate-triples 5)

(define (filter seq predicate)
        (cond ((null? seq) ())
              ((predicate (car seq)) (cons (car seq) (filter (cdr seq) predicate)))
              (else (filter (cdr seq) predicate))))

(filter (list 1 2 3 4 5) (lambda (x) (= (remainder x 2) 1)))

(define (triple-sum n s)
        (filter (enumerate-triples n) (lambda (triple) (= (accumulate + 0 triple) s))))

(triple-sum 5 4)
