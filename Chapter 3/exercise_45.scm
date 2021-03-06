;Exercise 3.45.  Louis Reasoner thinks our `bank-account` system is unnecessarily complex and error-prone now
;that deposits and withdrawals aren't automatically serialized. He suggests that `make-account-and-serializer`
;should have exported the serializer (for use by such procedures as `serialized-exchange`) in addition to
;(rather than instead of) using it to serialize accounts and deposits as `make-account` did. He proposes to
;redefine accounts as follows:

(define (make-account-and-serializer balance)
        (define (withdraw amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                    "Insufficient funds"))
        (define (deposit amount)
                (set! balance (+ balance amount))
                balance)
        (let ((balance-serializer (make-serializer)))
             (define (dispatch m)
                     (cond ((eq? m 'withdraw) (balance-serializer withdraw))
                           ((eq? m 'deposit) (balance-serializer deposit))
                           ((eq? m 'balance) balance)
                           ((eq? m 'serializer) balance-serializer)
                           (else (error "Unknown request -- MAKE-ACCOUNT"
                                        m))))
             dispatch))

;Then deposits are handled as with the original `make-account`:

(define (deposit account amount)
        ((account 'deposit) amount))

;Explain what is wrong with Louis's reasoning. In particular, consider what happens when `serialized-exchange` is
;called.

"Here, for reference, is `serialized-exchange`:"

(define (serialized-exchange account1 account2)
        (let ((serializer1 (account1 'serializer))
              (serializer2 (account2 'serializer)))
             ((serializer1 (serializer2 exchange))
              account1
              account2)))

"When it is called, `exchange` is put in the serializer of both account1 and account2, and then called.
Being in the serializer of account 1, `exchange` cannot run at the same time as account 1's  `withdraw`,
which is also in account 1's serializer. But account 1's `withdraw` is called during the execution of `exchange`.
So `exchange` cannot finish executing; it's execution blocks to execution of `withdraw`, but `withdraw`
must execute for `exchange` to finish executing. Something similar holds dor `deposit` and acccount 2."