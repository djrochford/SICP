(define (last-pair chain)
        (if (null? (cdr chain))
            chain
            (last-pair (cdr chain))))

(last-pair (list 23 72 149 34))

(define (reverse chain)
        (define (reverse-iter anti-chain chain)
                (if (null? chain)
                    anti-chain
                    (reverse-iter (cons (car chain) anti-chain) (cdr chain))))
        (reverse-iter () chain))

(reverse (list 1 4 9 16 25))

(define (deep-reverse chain)
        (define (reverse-iter anti-chain chain)
                (cond ((null? chain) anti-chain)
                      ((not (pair? chain)) chain)
                      (else (reverse-iter (cons (reverse-iter () (car chain)) anti-chain) (cdr chain)))))
        (reverse-iter () chain))

(reverse (list (list 1 2) (list 3 4)))
(deep-reverse (list (list 1 2) (list 3 4)))