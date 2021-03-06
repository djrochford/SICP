(load "environments.scm")
(load "eval-apply.scm")
(load "io.scm")

(define the-global-environment (setup-environment))

(define input-prompt ">>>M-Eval input:")
(define output-prompt ">>>M-Eval value:")

(define (driver-loop)
        (prompt-for-input input-prompt)
        (let ((input (read)))
             (let ((output (eval input the-global-environment)))
                  (announce-output output-prompt)
                  (user-print output)))
        (driver-loop))

(driver-loop)