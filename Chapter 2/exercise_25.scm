;Exercise 2.25.  Give combinations of `car`s and `cdr`s that will pick 7 from each of the following lists:

(define list1 (list 1 3 (list 5 7) 9))

(car (cdr (car (cdr (cdr list1))))); 7

(define list2 (list(list 7)))

(car (car list2)) ; 7

(define list3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr list3)))))))))))) ;7 tricky!