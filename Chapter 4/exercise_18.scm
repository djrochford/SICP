;Exercise 4.18.  Consider an alternative strategy for scanning out definitions
;that translates the example in the text to

(lambda <vars>
        (let ((u '*unassigned*)
              (v '*unassigned*))
             (let ((a <e1>)
                   (b <e2>))
                  (set! u a)
                  (set! v b))
             <e3>))

;Here a and b are meant to represent new variable names, created by the interpreter,
;that do not appear in the user's program. Consider the solve procedure from section
;3.5.4:

(define (solve f y0 dt)
        (define y (integral (delay dy) y0 dt))
        (define dy (stream-map f y))
        y)

;Will this procedure work if internal definitions are scanned out as shown in this
;exercise?

"This procedure, scanned out as shown in this exercise, will become:"

(lambda (f y0 dt)
        (let ((y '*unassigned*)
              (dy '*unassigned*))
             (let ((a (integral (delay dy) y0 dt))
                   (b (stream-map f y)))
                  (set! y a)
                  (set! dy b))
             y))

"You can see that when when `b` is declared, `y` equals `'*unassgined*`, and
`b` thus equals `(stream-map f '*unassigned*`)`, so `dy` is set to 
`(steam-map f '*unassigned*)`, which is bad."

;What if they are scanned out as shown in the text?

"`solve`, scanned out as suggested in the text, looks like this:`"
(lambda (f y0 dt)
        (let ((y '*unassigned*)
              (dy '*unassigned*))
             (set! y (integral (delay dy) y0 dt))
             (set! dy (stream-map f y))
             <e3>))
"In this case, by the time `dy` is `set!`, `y` equals something other than
`'*unassigned*`, and `dy` is set to what it should be. This in turn means
`(delay dy)` will evaluate correctly, when the time comes, and `y` has been
`set!` as it should be."
