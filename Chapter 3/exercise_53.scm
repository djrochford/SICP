;Exercise 3.53.  Without running the program, describe the elements of the stream defined by

(define s (cons-stream 1 (add-streams s s)))

"The first value is 1.
The second value is the first value plus the first value = 2.
The third value is the second value plus the second value = 4.
In general, the nth value is 2^(n-1).
"