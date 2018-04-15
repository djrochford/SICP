(define (multiple-dwelling)
        (let* ((fletcher (amb 2 3 4))
               (baker (apply amb 
                             (filter (lambda (x)
                                             (not (= x fletcher)))
                                     (list 1 2 3 4))))
               (cooper (apply amb 
                              (filter (lambda (x) 
                                              (not (or (<= (abs x 
                                                                fletcher)
                                                       1)
                                                       (= x baker))))
                                      (list 2 3 4 5))))
               (miller (apply amb 
                              (filter (lambda (x)
                                              (not (or (= x fletcher)
                                                       (= x baker)
                                                       (<= x cooper))))
                                      (list 2 3 4 5))))
               (smith (apply amb 
                             (filter (lambda (x)
                                             (not (or (<= (abs (- x
                                                                  fletcher))
                                                          1)
                                                      (= x miller)
                                                      (= x cooper)
                                                      (= x baker))))
                                             (list 1 2 3 4 5)))))
              (list (list 'baker baker)
                    (list 'cooper cooper)
                    (list 'fletcher fletcher)
                    (list 'miller miller)
                    (list 'smith smith))))


