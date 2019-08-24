;Exercise 3.44.  Consider the problem of transferring an amount from one account to another.
;Ben Bitdiddle claims that this can be accomplished with the following procedure, even if
;there are multiple people concurrently transferring money among multiple accounts, using any
;account mechanism that serializes deposit and withdrawal transactions, for example, the
;version of `make-account` in the text above.

(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

;Louis Reasoner claims that there is a problem here, and that we need to use a more
;sophisticated method, such as the one required for dealing with the exchange problem. Is
;Louis right?

"As usual, Louis is not right."

;If not, what is the essential difference between the transfer problem and the
;exchange problem? (You should assume that the balance in `from-account` is at least `amount`.)

"THe essential difference is that reads and mutations whose values depend on those reads all happen within
serialised processes, in `transfer`, so there is no way for something funky to happen in between the
read and the mutation. On the other hand, in `exchange`, reads which determine the value of a mutation occur
outside the processes that do the mutating; it's in between those reads and those mutations that strange things
can happen."