;Exercise 2.47.  Here are two possible constructors for frames:

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

;For each constructor supply the appropriate selectors to produce an implementation for frames.

"For constructor 1..."

(define (make-frame origin edge1 edge2)
        (list origin edge1 edge2))

"the appropriate selectors are:"

(define origin-frame car)

(define edge1-frame cadr)

(define edge2-frame caddr)

(define myframe (make-frame "dog" "cat" "mouse"))
"Forgive me not using realistic values for origin, edge1 and edge2, above;
I'm too lazy."

(origin-frame myframe) ;"dog"
(edge1-frame myframe) ;"cat"
(edge2-frame myframe) ;"mouse"

"For constructor 2..."

(define (make-frame origin edge1 edge2)
        (cons origin (cons edge1 edge2)))

"the appropriate selectors are:"

(define origin-frame car)

(define edge1-frame cadr)
"(those are both the same as before)"

(define edge2-frame cddr) 
"(this one is different)"

(define my-other-frame (make-frame "dog" "cat" "mouse"))

(origin-frame my-other-frame) ;"dog"
(edge1-frame my-other-frame) ;"cat"
(edge2-frame my-other-frame) ;"mouse"
