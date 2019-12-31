;Exercise 4.41.  Write an ordinary Scheme program to solve the multiple dwelling puzzle.

(define (multiple-dwelling)
		(define (all-distinct assignment seen)
				(if (null? assignment)
					#t
					(let ((current (car assignment)))
					 	 (if (member current seen)
					 	 	 #f
					 	 	 (all-distinct (cdr assignment) (cons current seen))))))
		(define (meets-restrictions assignment)
				(and ())))