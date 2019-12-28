;Exercise 4.38.  Modify the multiple-dwelling procedure to omit the requirement that
;Smith and Fletcher do not live on adjacent floors.

(define (multiple-dwelling)
        (let ((baker (amb 1 2 3 4 5))
              (cooper (amb 1 2 3 4 5))
              (fletcher (amb 1 2 3 4 5))
              (miller (amb 1 2 3 4 5))
              (smith (amb 1 2 3 4 5)))
             (require (distinct? (list baker cooper fletcher miller smith)))
             (require (not (= baker 5)))
             (require (not (= cooper 1)))
             (require (not (= fletcher 5)))
             (require (not (= fletcher 1)))
             (require (> miller cooper))
           ;;(require (not (= (abs (- smith fletcher)) 1)))
             (require (not (= (abs (- fletcher cooper)) 1)))
             (list (list 'baker baker)
                   (list 'cooper cooper)
                   (list 'fletcher fletcher)
                   (list 'miller miller)
                   (list 'smith smith))))

;How many solutions are there to this modified puzzle?

"The good way to answer this question is to run this procedure and `try-again` it until
we can `try-again` no more, but that would require implementing `amb`, which seems
to me to be getting ahead of ourselves. So I looked it up; the answer is 5."