;`while` syntax
;(while <name> <predicate> <body>)

;Example:
;(define (fib n)
;        (cond ((= n 0) 0)
;              ((= n 1) 1)
;              (else (let ((i 0) (first 0) (second 1) (sum 0))
;                          (while 'fib-loop
;                                 (not (> i n))
;                                 ((set! sum (+ first second))
;                                  (set! first second)
;                                  (set! second sum)))
;                           sum))))

(define (while? exp) (tagged-list? exp 'while))
(define (while-name) (cadr exp))
(define (while-predicate exp) (caddr exp))
(define (while-body exp) (cadddr exp))

(define (make-definition name parameters body)
        (list 'define (cons name parameters) body))

(define (make-application procedure-name parameters)
        (cons procedure-name
              parameters))

(define (while->recurse exp)
        (make-defintion (while-name exp) 
                        '()
                        (if (while-predicate exp)
                            (make-begin (cons (while-body exp)
                                              (make-application (while-name exp) '()')))
                          #f)))