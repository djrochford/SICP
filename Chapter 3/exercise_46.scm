;Exercise 3.46.  Suppose that we implement `test-and-set!` using an ordinary procedure as shown in the text,
;without attempting to make the operation atomic. Draw a timing diagram like the one in figure 3.29 to
;demonstrate how the mutex implementation can fail by allowing two processes to acquire the mutex at the same
;time.

"No diagram, just description:

Process 1 initates acquisition of a mutex.
Process 1 executes `test-and-set!`
Process 1 reads from the mutex, finds it is `false`.
Process 2 executes acquisition of the same mutex to completion. Sets mutex to `true`.
Process 1 also sets mutex to `true`.

Both processes have acquired the mutex; neither are waiting."