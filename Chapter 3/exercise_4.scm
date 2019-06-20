;Exercise 3.4.  Modify the make-account procedure of exercise 3.3 by adding another
;local state variable so that, if an account is accessed more than seven consecutive
;times with an incorrect password, it invokes the procedure call-the-cops.

(define (call-the-cops)
        (display "cops called!") (newline))

(define (make-account balance password)
        (define incorrect-password-count 0)
        (define (withdraw amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                    "Insufficient funds"))
        (define (deposit amount)
                (set! balance (+ balance amount))
                balance)
        (define (dispatch pswd m)
                (if (not (eq? pswd password))
                    (begin (set! incorrect-password-count (+ incorrect-password-count 1))
                           (if (> incorrect-password-count 7)
                               (call-the-cops))
                           (display "Incorrect password")
                           (newline))
                    (else (begin (set! incorrect-password-count 0)
                                 (cond ((eq? m 'withdraw) withdraw)
                                       ((eq? m 'deposit) deposit)
                                       (else (error "Unknown request -- MAKE-ACCOUNT" m)))))))
        dispatch)

(define safe-acc (make-account 100 'super-secret))

((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50)
((safe-acc 'some-other-password 'deposit) 50) ; cops called!