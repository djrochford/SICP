;Exercise 3.38.  Suppose that Peter, Paul, and Mary share a joint bank account that initially contains $100.
;Concurrently, Peter deposits $10, Paul withdraws $20, and Mary withdraws half the money in the account, by
;executing the following commands:
"Peter:" (set! balance (+ balance 10))
"Paul:"	 (set! balance (- balance 20))
"Mary":	 (set! balance (- balance (/ balance 2)))

;a. List all the different possible values for balance after these three transactions have been completed,
;assuming that the banking system forces the three processes to run sequentially in some order.

"Peter-Paul-Mary:" 45
"Peter-Mary-Paul:" 35
"Paul-Peter-Mary:" 45
"Paul-Mary-Peter:" 50
"Mary-Peter-Paul:" 40
"Mary-Paul-Peter:" 40

;b. What are some other values that could be produced if the system allows the processes to be interleaved?
;Draw timing diagrams like the one in figure 3.29 to explain how these values can occur.

"One possibility: 110. Peter looks up the balance first, finds it is 100; add 10 to 100. Then Paul's
transactions occur, then Mary's. Then Peter sets the balance to 110.

Another: 80. Paul looks at the balance first, finds 100, and subtracts 20. Then Peter's transactions
occur, then Mary's. Then Paul sets the balance to 80.

Another 60: Mary looks up the balance, see it's 100, divides by 2 to get 50. Peter sets the balance to
110. Mary looks it up again, minuses 50, gets 60. Paul does his stuff. Mary then sets the balance to 60.

(I won't bother with the timing diagrams -- I take the sequence of events here to be pretty clear.)"