(define (accumulate op initial sequence)
        (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate m n)
        (if (> m n)
            ()
            (cons m (enumerate (+ m 1) n))))

(enumerate 1 7)

(define (unique-pairs n)
        (accumulate append 
                    ()
                    (map (lambda (i) (map (lambda (j) (list i j)) 
                                          (enumerate 1 (- i 1))))
                         (enumerate 1 n))))

(unique-pairs 7)

(define (prime? n)
   blah blah)

(define (prime-sum? pair)
        (prime? (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
        (map make-pair-sum
            (filter prime-sum?
                    (unique-pairs n))))