;Exercise 3.25.  Generalizing one- and two-dimensional tables, show how to implement a table
;in which values are stored under an arbitrary number of keys and different values may be
;stored under different numbers of keys. The `lookup` and `insert!` procedures should take as
;input a list of keys used to access the table.

"For reference, here's the two-key `make-table:"
(define (make-table)
        (let ((local-table (list '*table*)))
             (define (lookup key-1 key-2)
                     (let ((subtable (assoc key-1 (cdr local-table))))
                          (if subtable
                              (let ((record (assoc key-2 (cdr subtable))))
                                   (if record
                                       (cdr record)
                                       false))
                              false)))
             (define (insert! key-1 key-2 value)
                     (let ((subtable (assoc key-1 (cdr local-table))))
                          (if subtable
                              (let ((record (assoc key-2 (cdr subtable))))
                                   (if record
                                       (set-cdr! record value)
                                       (set-cdr! subtable 
                                                 (cons (cons key-2 value) (cdr subtable)))))
                              (set-cdr! local-table
                                        (cons (list key-1 (cons key-2 value))
                                        (cdr local-table)))))
                     'ok)    
             (define (dispatch m)
                     (cond ((eq? m 'lookup-proc) lookup)
                           ((eq? m 'insert-proc!) insert!)
                           (else (error "Unknown operation -- TABLE" m))))
             dispatch))

"Now, my generalised `make-table`:"

(define (is-record? subtable)
        (not (pair? (cdr subtable))))

(define (make-table)
        (let ((local-table (list '*table*)))
             (define (lookup keys)
                     (let ((subtable (assoc (car keys) (cdr local-table))))
                          (cond ((eq? subtable #f) #f)
                                ((is-record? subtable) (if (null? (cdr keys)) 
                                                                  (cdr subtable)
                                                                  #f))
                                (else (lookup (cdr keys) (cdr subtable))))))
             (define (insert! keys value)
                     (define (insert-iter remaining-keys level-up)
                             (let* ((current-key (car keys))
                                    (subtable (assoc current-key (cdr level-up))))
                                    (if subtable
                                        (if (null? (cdr remaining-keys))
                                            (set-cdr! subtable value))
                                            (insert-iter (cdr remaining-keys, subtable))
                                        (set-cdr! level-up
                                                  (cons (cons current-key value)
                                                        (cdr level-up))))))
                     (if (null? keys)
                         local-table
                         (if (null? (cdr keys))
                             (set-cdr! local-table (cons (car keys value) (cdr local-table))))
                             (insert-iter keys local-table)))

             (define (dispatch m)
                     (cond ((eq? m 'lookup-proc) lookup)
                           ((eq? m 'insert-proc!) insert!)
                           (else (error "Unknown operation -- TABLE" m))))
             dispatch))

