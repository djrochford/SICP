;Exercise 3.47.  A semaphore (of size n) is a generalization of a mutex. Like a mutex,
;a semaphore supports acquire and release operations, but it is more general in that up
;to n processes can acquire it concurrently. Additional processes that attempt to acquire
;the semaphore must wait for release operations. Give implementations of semaphores

;a. in terms of mutexes


(define (make-semaphore n)
		(let ((count 0) (at-limit-mutex (make-mutex)) (access-count-mutex (make-mutex)))
			 (define (the-semaphore m)
			 		 (cond ((eq? m 'acquire) (at-limit-mutex 'acquire)
			 		 						 (access-count-mutex 'acquire) 
			 		 						 (set! count (+ count 1))
			 		 						 (if (< count n)
			 		 						  	 (at-limit-mutex 'release))
			 		 						 (access-count-mutex 'release))
			 		 	   ((eq? m 'release) (access-count-mutex 'acquire)
			 		 						 (if (> count 0)
				 		 						 (set! count (- count 1))
				 		 					 (if (< count n)
				 		 					 	 (at-limit-mutex 'release))
			 		 						 (access-count-mutex 'release)))))
			 the-semaphore))

;b. in terms of atomic test-and-set! operations.

(define (make-semaphore n)
		(let ((count 0) (lock (list #f)))
			 (define (the-semaphore m)
			 		 (cond ((eq? m 'acquire) (if (test-and-set! lock)
			 		 							 (the-semaphore 'acquire))
			 		 						 (cond ((>= count n) (clear! lock)
			 		 						 					 (the-semaphore 'acquire'))
			 		 						       (else (set! count (+ count 1))
			 		 						  	 		 (clear! lock))))
			 		 	   ((eq? m 'release) (if (test-and-set! lock)
			 		 	   						 (the-semaphore 'release))
			 		 						 (if (> count 0)
				 		 						 (set! count (- count 1)))
			 		 						 (clear! lock))))
			 the-semaphore))
