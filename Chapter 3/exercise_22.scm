;Exercise 3.22.  Instead of representing a queue as a pair of pointers, we can build a
;queue as a procedure with local state. The local state will consist of pointers to the
;beginning and the end of an ordinary list. Thus, the `make-queue` procedure will have
;the form

(define (make-queue)
  (let ((front-ptr ...)
        (rear-ptr ...))
    <definitions of internal procedures>
    (define (dispatch m) ...)
    dispatch))

;Complete the definition of make-queue and provide implementations of the queue operations
;using this representation.

(define (make-queue)
  (let ((front-ptr '()) (rear-ptr '()))
        (define (set-front-ptr! item) (set! front-ptr item))
        (define (set-rear-ptr! item) (set! rear-ptr item))
        (define (empty-queue?) (null? front-ptr))
        (define (front-queue) 
                (if (empty-queue?)
                    (error "FRONT called with an empty queue")
                    (car front-ptr)))
        (define (insert-queue item)
                (let ((new-pair (cons item '())))
                     (cond ((empty-queue?) (set-front-ptr new-pair)
                                           (set-rear-ptr new-pair)
                                           dispatch)
                            (else (set-cdr! rear-ptr new-pair)
                                  (set-rear-ptr new-pair)
                                  dispatch))))
        (define (delete-queue!)
                (cond ((empty-queue?)(error "DELETE! called with an empty queue" dispatch))
                      (else (set-front-ptr (cdr front-ptr))
                            dispatch)))
        (define (dispatch m)
                (cond ((eq? m 'front-ptr) front-ptr)
                      ((eq? m 'rear-ptr) rear-ptr)
                      ((eq? m 'set-front-ptr!) set-front-ptr)
                      ((eq? m 'set-rear-ptr!) set-rear-ptr)
                      ((eq? m 'empty-queue?) empty-queue)
                      ((eq? m 'front-queue) front-queue)
                      ((eq? m 'insert-queue) insert-queue)
                      ((eq? m 'delete-queue) delete-queue)
                      (else (error "Undefined operation -- QUEUE" m))))
        dispatch))
