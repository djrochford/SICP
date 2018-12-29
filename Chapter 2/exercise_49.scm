;Exercise 2.49.  Use segments->painter to define the following primitive painters:

"Before I go on, it will be handy to have the following vectors defined:"

(define bl-corner (make-vect 0 0))
(define br-corner (make-vect 1 0))
(define tl-corner (make-vect 0 1))
(define tr-corner (make-vect 1 1))

(define left-mid (make-vect 0 0.5))
(define top-mid (make-vect 0.5 1))
(define right-mid (make-vect 1 0.5))
(define bottom-mid (make-vect 0.5 0))

;a.  The painter that draws the outline of the designated frame.

(define left-side (make-segment bl-corner tl-corner))
(define top-side (make-segment  tl-corner tr-corner))
(define right-side (make-segment br-corner tr-corner))
(define bottom-side (make-segment bl-corner br-corner))

(define outline-painter (segments->painter (list left-side top-side right-side bottom-side)))

;b.  The painter that draws an ``X'' by connecting opposite corners of the frame.

(define tl-br-diagonal (make-segment tl-corner br-corner))
(define bl-tr-diagonal (make-segment bl-corner tr-corner))

(define X-painter (segments->painter (list tl-br-diagonal bl-tr-diagonal)))

;c.  The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.

(define bm-lm-diagonal (make-segment bottom-mid left-mid))
(define lm-tm-diagonal (make-segment left-mid top-mid))
(define tm-rm-diagonal (make-segment top-mid right-mid))
(define bm-rm-diagonal (make-segment bottom-mid right-mid))

(define diamong-painter (segments->painter (list bm-lm-diagonal 
                                                 lm-tm-diagonal 
                                                 tm-rm-diagonal 
                                                 bm-rm-diagonal)))

;d.  The wave painter.


"I cannot be arsed doing this."

