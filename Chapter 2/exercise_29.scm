;makers
(define (make-mobile left right)
        (list left right))

(define (make-branch len structure)
        (list len structure))

;selectors
(define (left-branch mobile)
        (car mobile))

(define (right-branch mobile)
        (car (cdr mobile)))

(define (branch-length branch)
        (car branch))

(define (branch-structure branch)
        (car (cdr branch)))

(define (balanced? mobile)
        (define (torque branch)
                (if (not (pair? (branch-structure branch)))
                    (* (branch-length branch) (branch-structure branch))
                    (- (torque (left-branch (branch-structure branch))) 
                       (torque (right-branch (branch-structure branch))))))
        (= (torque (left-branch mobile)) (torque (right-branch mobile))))

 (define level-1-mobile (make-mobile (make-branch 2 1) 
                                     (make-branch 1 2))) 
 (define level-2-mobile (make-mobile (make-branch 3 level-1-mobile) 
                                     (make-branch 9 1))) 
 (define level-3-mobile (make-mobile (make-branch 4 level-2-mobile) 
                                     (make-branch 8 2)))

 (define balanced-mobile (make-mobile (make-branch 2 level-3-mobile)
                                      (make-branch 2 level-3-mobile)))

 (balanced? level-3-mobile)
 (balanced? level-2-mobile)
 (balanced? level-1-mobile)
 (balanced? balanced-mobile)