;Exercise 2.75.  Implement the constructor `make-from-mag-ang` in message-passing style.
;This procedure should be analogous to the `make-from-real-imag` procedure given above

(define (make-from-mag-ang m a)
        (define (dispatch op)
                (cond ((eq? op 'real-part) (* m (cos a)))
                      ((eq? op 'imag-part) (* m (sin a)))
                      ((eq? op 'magnitude) m)
                      ((eq? op 'angle') a)
                      (else "Unknown op -- MAKE-FROM-MAG-ANG", op)))
        dispatch)