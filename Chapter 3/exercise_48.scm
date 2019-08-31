;Exercise 3.48.  Explain in detail why the deadlock-avoidance method described above,
;(i.e., the accounts are numbered, and each process attempts to acquire the smaller-numbered
;account first) avoids deadlock in the exchange problem.

"This prevents deadlock in the exchange problem because it ensures that both processes access
the accounts in the same order. Account 2 will be accessed by neither process until both
processes are done with account 1, and so it cannot occur that one process blocks the other's
access to account 2 while it's access is blocked to account 1."

;Rewrite `serialized-exchange` to incorporate this idea. (You will also need to modify
;`make-account` so that each account is created with a number, which can be accessed by
;sending an appropriate message.)

"First, `make-account`:"

(define account-count 0)

(define (make-account-and-serializer balance)
  		(define account-number account-count)
  		(set! account-count (+ account-count 1))
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
      				 (cond ((eq? m 'withdraw) withdraw)
            			   ((eq? m 'deposit) deposit)
            			   ((eq? m 'balance) balance)
            			   ((eq? m 'serializer) balance-serializer)
            			   ((eq? m 'account-number) account-number)
            			   (else (error "Unknown request -- MAKE-ACCOUNT"
                         		 	    m))))
    		 dispatch))

"Now, serialized-exchange:"
(define (serialized-exchange account1 account2)
		(define (exchange acc1 acc2)
		  		(let ((serializer1 (account1 'serializer))
		        	  (serializer2 (account2 'serializer)))
		  		     (if (< (account1 'account-number) (account2 'account-number)))
		    		 ((serializer1 (serializer2 exchange)) account1
		     											   account2)))
		(if (< (account1 'account-number) (account2 'account-number))
			(exchange (account1 account2))
			(exchange (account2 account1))))