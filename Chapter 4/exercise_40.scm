;Exercise 4.40.  In the multiple dwelling problem, how many sets of assignments are there of people to floors,
;both before and after the requirement that floor assignments be distinct?

"Before, there are 5^5 = 3125 assignments of people to floors; after, there are 5! = 120 assignments."

;It is very inefficient to generate all possible assignments of people to floors and then leave it to backtracking to eliminate them.
;For example, most of the restrictions depend on only one or two of the person-floor variables, and can thus be imposed before floors
;have been selected for all the people. Write and demonstrate a much more efficient nondeterministic procedure that solves this problem
;based upon generating only those possibilities that are not already ruled out by previous restrictions. (Hint: This will require a nest of let expressions.)

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


