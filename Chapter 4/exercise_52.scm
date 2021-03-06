;Exercise 4.52.  Implement a new construct called `if-fail` that permits the user to catch the
;failure of an expression. `if-fail` takes two expressions. It evaluates the first expression
;as usual and returns as usual if the evaluation succeeds. If the evaluation fails, however,
;the value of the second expression is returned, as in the following example:

;;; Amb-Eval input:
(if-fail (let ((x (an-element-of '(1 3 5))))
           (require (even? x))
           x)
         'all-odd)
;;; Starting a new problem
;;; Amb-Eval value:
all-odd
;;; Amb-Eval input:
(if-fail (let ((x (an-element-of '(1 3 5 8))))
           (require (even? x))
           x)
         'all-odd)
;;; Starting a new problem
;;; Amb-Eval value:
8

(define (analyze-if-fail exp)
        (let ((try-proc (analyze if-fail-try exp))
              (fail-proc (analyze if-fail-fail exp)))
             (lambda (env succeed fail)
                     (try-proc env
                               succeed
                               (lambda ()
                                       (fail-proc env
                                                  succeed
                                                  fail))))))