;Exercise 4.51.  Implement a new kind of assignment called `permanent-set!` that is not undone upon
;failure. For example, we can choose two distinct elements from a list and count the number of
;trials required to make a successful choice as follows:

(define count 0)
(let ((x (an-element-of '(a b c)))
      (y (an-element-of '(a b c))))
     (permanent-set! count (+ count 1))
     (require (not (eq? x y)))
     (list x y count))
;;; Starting a new problem
;;; Amb-Eval value:
(a b 2)
;;; Amb-Eval input:
try-again
;;; Amb-Eval value:
(a c 3)

"It will be helpful to refer to `analyze-assignment`, from the book, in answering this question."

(define (analyze-assignment exp)
        (let ((var (assignment-variable exp))
              (vproc (analyze (assignment-value exp))))
             (lambda (env succeed fail)
                     (vproc env
                            (lambda (val fail2)        ; *1*
                                    (let ((old-value (lookup-variable-value var env))) 
                                         (set-variable-value! var val env)
                                         (succeed 'ok
                                                  (lambda ()    ; *2*
                                                          (set-variable-value! var
                                                                               old-value
                                                                               env)
                                                          (fail2))))) 
                             fail))))

"Our function, which I'll call `analyze-permanent-assignment`, can be much simpler, as it doesn't need
to reset the value on fail. It can just do the naïve thing, which is to set the variable and pass on
the continuations like usual. It will, in fact, be exactly the same as `analyze-definition`, except it uses
`set-variable-value!` where `analyze-definition` uses `define-variable!`."

(define (analyze-permanent-assignment exp)
        (let ((var (assignment-variable exp))
              (vproc (analyze (assignment-value exp))))
             (lambda (env succeed fail)
                     (vproc env
                            (lambda (val fail2)
                                    (set-variable-value! var val env)
                                    (succeed 'ok
                                              fail2))
                             fail))))

;What values would have been displayed if we had used set! here rather than permanent-set! ?