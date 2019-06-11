;Exercise 2.86.  Suppose we want to handle complex numbers whose real parts,
;imaginary parts, magnitudes, and angles can be either ordinary numbers,
;rational numbers, or other numbers we might wish to add to the system.
;Describe and implement the changes to the system needed to accommodate this.
;You will have to define operations such as sine and cosine that are generic
;over ordinary numbers and rational numbers.

"Here, for reference, is the complex-number package, pre-this-question, encompassing
both rectangular and polar sub-packages:"

(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
           (square (imag-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))
(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))
(define (make-from-mag-ang-rectangular r a) 
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))

(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))
(define (make-from-real-imag-polar x y) 
  (attach-tag 'polar
               (cons (sqrt (+ (square x) (square y)))
                     (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))

(define (real-part z)
  (cond ((rectangular? z) 
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type -- REAL-PART" z))))
(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z)))
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type -- IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z)))
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type -- MAGNITUDE" z))))
(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z)))
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type -- ANGLE" z))))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

"The enivisioned change will mean that `x`, `y`, `r`, and `a` in all of the above will be
numbers in our type system, with tags like `integer`, `rational` and so on.

The only changes required are in the procedures that currently act on plain numbers, and
after the change will act on tagged numbers. Those procedures are:
`square`, `+`, `sqrt`, `atan`, `*`, `cos`, `sin`, `-` and `/`.

We already have generic versions of `+`, `*`, `-` and `/`; namely `add`, `mul`, `sub` and `div`.
We can substitute those in the above. That just leaves `square`, `sqrt`, `atan`, `cos`, and `sin`,
which need generic versions."

(define (sqr x) (apply-generic 'sqr x))
(define (squareroot x) (apply-generic 'squareroot x))
(define (arctan x) (apply-generic 'arctan x))
(define (cosine x) (apply-generic 'cosine x'))
(define (sine x) (apply-generic 'sine x))

"For each, I will define the method only for the real package, and let raising take care of the
other cases."

(put 'sqr '(real) (lambda (x) (tag (* x x))))
(put 'squareroot '(real) (lambda (x) (tag (sqrt x))))
(put 'arctan '(real) (lambda (x) (tag (atan x))))
(put 'cosine '(real) (lambda (x) (tag (cos x))))
(put 'sine '(real) (lambda (x) (tag (sin x))))

"(where `tag` refers to the real-package `tag`)."