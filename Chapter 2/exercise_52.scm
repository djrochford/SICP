;Exercise 2.52.  Make changes to the square limit of wave shown in figure 2.9 
;by working at each of the levels described above. In particular:

;a.  Add some segments to the primitive `wave` painter of exercise  2.49 (to add a smile, for example).

"As I could not be arsed making the `wave` painter out of line segments, I cannot now add a smile to that list
of line segments, but you can imagine a few more line segments in the list."

;b.  Change the pattern constructed by `corner-split` 
;(for example, by using only one copy of the `up-split` and `right-split` images instead of two).

"Alrighty. Here's the original:"

(define (corner-split painter n)
        (if (= n 0)
            painter
            (let ((up (up-split painter (- n 1)))
                  (right (right-split painter (- n 1))))
                 (let ((top-left (beside up up))
                       (bottom-right (below right right))
                       (corner (corner-split painter (- n 1))))
                      (beside (below painter top-left)
                              (below bottom-right corner))))))


"...and here's the modification..."

(define (corner-split painter n)
        (if (= n 0)
            painter
            (let ((up (up-split painter (- n 1)))
                  (right (right-split painter (- n 1)))
                  (corner (corner-split painter (- n 1))))
                 (beside (below painter up)
                         (below right corner)))))

;c.  Modify the version of `square-limit` that uses `square-of-four`
;so as to assemble the corners in a different pattern. 
;(For example, you might make the big Mr. Rogers look outward from each corner of the square.)

"Here's old `square-limit`:"
(define (square-limit painter n)
        (let ((combine4 (square-of-four flip-horiz
                                        identity
                                        rotate180
                                        flip-vert)))
             (combine4 (corner-split painter n))))

"Here's the new one:"

(define (square-limit painter n)
        (let ((combine4 (square-of-four flip-vert
                                        rotate180
                                        identity
                                        flip-horiz)))
             (combine4 (corner-split painter n))))

"(I haven't set things up to compile these picture-language programs,
and had some trouble visualising exactly what was being asked for. 
I got the answer from here:
http://jots-jottings.blogspot.com/2011/10/sicp-exercise-252-abusing-painters.html
where the pictures makes it clear what is going on.)"
