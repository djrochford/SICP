;Exercise 3.43.  Suppose that the balances in three accounts start out as $10, $20, and $30, and that multiple processes run,
;exchanging the balances in the accounts. Argue that if the processes are run sequentially, after any number of concurrent
;exchanges, the account balances should be $10, $20, and $30 in some order.

"Let A, B, C be the accounts. Let S be the set of their `balance` values. Obviously, any one exeuction of `exchange` with any
pair of A, B, C as inputs should not alter S -- which accounts have which balances can change, but not the set of balances.
That being so, no number of executions can change S -- if there were such a change, it would have to occur during some particular
execution, and it cannot occur at any such execution. So 'after any number of concurrent exchanges, the account balances should
be $10, $20, and $30 in some order'."

;Draw a timing diagram like the one in figure 3.29 to show how this condition can be violated if the exchanges are implemented
;using the first version of the account-exchange program in this section.

"For reference, here is the first version of the account-exchange program:"

(define (exchange account1 account2)
  		(let ((difference (- (account1 'balance)
                       		 (account2 'balance))))
    		 ((account1 'withdraw) difference)
    		 ((account2 'deposit) difference)))


"Account 1 balance    `exchange` 1              Account 2 balance      `exchange 2`              Account 3 balance
	     30    								  			20										         10
					   access account 1: 30								access account 1: 30
					   access account 2: 20								access account 3: 10
					   difference: 10									difference: 20
					   account1 withdraw difference
		20					
																		account1 withdraw difference
		0
						account2 deposit difference     30	            account 3 deposit difference.     30

Final values 0, 30, 30
"

;On the other hand, argue that even with this `exchange` program, the sum of the balances in the accounts will be preserved.

"For every `withdrawal` of `difference`, there is a `deposit` of `difference`. So, as long as `withdrawal` and `deposit`
complete without interruption, the total in the three accounts will stay the same."

;Draw a timing diagram to show how even this condition would be violated if we did not serialize the transactions on individual accounts.

"I will not; clearly, this can happen, given possibilities like those talked about in 3.38."