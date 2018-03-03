(define (make-account balance password)
        (define (withdraw amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                    "Insufficient funds"))
        (define (deposit amount)
                (set! balance (+ balance amount))
                balance)
        (define (dispatch pswd m)
                (cond ((not (eq? pswd password)) (error "Incorrect password"))
                      ((eq? m 'withdraw) withdraw)
                      ((eq? m 'deposit) deposit)
                      (else (error "Unknown request -- MAKE-ACCOUNT" m))))
        dispatch)

(define (make-joint account first-password second-password)
        (if ((account first-password 'withdraw) 0)
            (lambda (pswd m)
                    (if (eq? pswd second-password)
                        (account first-password m)
                        (error "Incorrect password")))))

(define peter-acc (make-account 30 'open-sesame))

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'rosebud 'withdraw) 10)
;20
((peter-acc 'open-sesame 'withdraw) 10)
;10