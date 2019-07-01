;Exercise 3.23.  A deque (``double-ended queue'') is a sequence in which items can be
;inserted and deleted at either the front or the rear. Operations on deques are the
;constructor `make-deque`, the predicate `empty-deque?`, selectors `front-deque` and
;`rear-deque`, and mutators `front-insert-deque!`, `rear-insert-deque!`,
;`front-delete-deque!`, and `rear-delete-deque!`. Show how to represent deques using pairs, 
;and give implementations of the operations. All operations should be accomplished in
;Theta(1) steps.

"We can do almost all of this already with the object we're using to represent a standard
queue. The problem is `rear-delete-deque`; there's no Theta(1) way to get to the second-last
pair, so that we can make that the rear of our deque, as need to to delete from the rear.

So here's the strategy: each entry in the deque will be a pair, the first element of which
is the value, and the second element of which is not a single pointer to the next pair, but
is instead a *pair* of pointers -- the `car` points back to the last pair (if there is one),
and the `cdr` points forwards to the next pair (if there is one)."

"The following procedures can all remain the same (except 'queue's changed
to 'deque's):"

(define (make-deque) (cons '() '()))

(define (front-ptr deque) (car deque))

(define (rear-ptr deque) (cdr deque))

(define (set-front-ptr! deque item) (set-car! deque item))

(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (empty-deque? deque) (null? (front-ptr deque)))

(define (front-deque deque)
        (if (empty-deque? deque)
            (error "FRONT called with an empty deque" deque)
            (car (front-ptr deque))))


"These are new:"

(define (rear-deque deque)
        (if (empty-deque? deque)
            (error "REAR called with an empty deque")
            (car (rear-ptr deque))))

(define (front-insert-deque deque item)
        (let ((new-pair (cons item (cons '() '()))))
             (cond ((empty-deque? deque) (set-front-ptr! deque new-pair)
                                        (set-rear-ptr! deque new-pair)
                                        deque)
                   (else (set-cdr! (cdr new-pair) (front-ptr deque))
                         (set-car! (cdr (front-ptr deque)) new-pair)
                         (set-front-ptr! deque new-pair)
                         "success"))))
;Note, returning this string, rather than the deque, to avoid making the printer
;print a cyclic structure.

(define (rear-insert-deque deque item)
        (let ((new-pair (cons item (cons '() '()))))
             (cond ((empty-deque? deque) (set-front-ptr! deque new-pair)
                                         (set-rear-ptr! deque new-pair)
                                         deque)
                   (else (set-cdr! (cdr (rear-ptr deque)) new-pair)
                         (set-car! (cdr new-pair) (rear-ptr deque))
                         (set-rear-ptr! deque new-pair)
                         "success"))))

(define DQ (make-deque)) ;dq

(front-insert-deque DQ 1) ; ((1 ()) (1 ()))

(front-deque DQ) ; 1

(rear-deque DQ) ; 1

(rear-insert-deque DQ 2) ; "success"

(front-deque DQ) ; 1

(rear-deque DQ) ; 2

