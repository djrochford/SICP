;Exercise 4.9.  Many languages support a variety of iteration constructs,
;such as `do`, `for`, `while`, and `until`. In Scheme, iterative processes
;can be expressed in terms of ordinary procedure calls, so special iteration
;constructs provide no essential gain in computational power. On the other
;hand, such constructs are often convenient. Design some iteration constructs,
;give examples of their use, and show how to implement them as derived expressions.


"We're going to make a `while`

`while` syntax:
(while <predicate> <body>)

Example:"

(define (fib n)
        (cond ((= n 0) 0)
              ((= n 1) 1)
              (else (let ((i 0) (first 0) (second 1) (sum 0))
                          (while (not (> i n))
                                 ((set! sum (+ first second))
                                  (set! first second)
                                  (set! second sum)))
                           sum))))


(define (while? exp) (tagged-list? exp 'while))
(define (while-predicate exp) (cadr exp))
(define (while-body exp) (caddr exp))


(define (while->let exp)
        (make-let ('temp-name (make-lambda '()
                                           (make-if (while-predicate exp)
                                                    (make-begin (cons (while-body exp)
                                                                      ('temp-name)))
                                                    "Finished")))
                  ('temp-name)))


