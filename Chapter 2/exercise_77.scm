;Exercise 2.77.  Louis Reasoner tries to evaluate the expression `(magnitude z)` where `z` 
;is the object shown in figure 2.24. To his surprise, instead of the answer `5` 
;he gets an error message from `apply-generic`, saying there is no method for the operation
;`magnitude` on the types `(complex)`. He shows this interaction to Alyssa P. Hacker, who says 
;"The problem is that the complex-number selectors were never defined for complex numbers,
;just for polar and rectangular numbers. All you have to do to make this work is add the following
;to the complex package:"

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

;Describe in detail why this works. As an example, trace through all the procedures
;called in evaluating the expression `(magnitude z)` where z is the object shown in figure 2.24.
;In particular, how many times is `apply-generic` invoked? What procedure is dispatched to in each case?

"For reference, this is `z`:

-->|||-|----->|||-|---------->|||-|---> 4
    |          |               |
    v          v               v
  complex     rectangular      3

Let us trace through the execution of `(magnitude z)`, using the substitution model"

(magnitude z)

(apply-generic 'magnitude z) 
;z would be substituted at this point, given that scheme is applicative order
; but we'll keep using `z` just because it's easier to write.
  
(let ((type-tags (map type-tag (list z))))
     (let ((proc (get 'magnitude type-tags)))
          (if proc
              (apply proc (map contents (list z)))
              (error "No method for these types -- APPLY-GENERIC"
                     (list 'magnitude type-tags)))))

"`type-tags` evaluates to `(list 'complex)`, so `(get 'magnitude type-tags)` evaluates to
`(get 'magnitude (list 'complex)`, so at this point, without installing the `magnitude`
procedure for generic `complex` type, `(get 'magnitude (list 'complex)` evaluates to `#f`,
and the predicate of the `if` statement is thus `#f`, and so the `error` statement is executed.

But with the procedure installed, the `apply` statement is the one that executes; it evalutes as follows:
"

(apply proc (map contents (list z)))

(apply (get 'magnitude 'complex) (list 'rectangular 3 4))

(apply magnitude (list 'rectangular 3 4))

(magnitude (list 'rectangular 3 4))

(apply-generic 'magnitude (list 'rectangular 3 4))

(let ((type-tags (map type-tag (list 'rectangular 3 4))))
     (let ((proc (get 'magnitude type-tags)))
          (if proc
              (apply proc (map contents (list 'rectangular  3 4)))
              (error "No method for these types -- APPLY-GENERIC"
                     (list 'magnitude type-tags)))))

"Again, because `magnitude` for `rectangular` type is installed, the `apply` statement exeutes"

(apply (get 'magnitude 'rectangular) (list 3 4))

(apply (define (magnitude z)
               (sqrt (+ (square (real-part z))
                        (square (imag-part z)))))
       (list 3 4))

(sqrt (+ (square (real-part (list 3 4)))
         (square (imag-part (list 3 4)))))

(sqrt (+ (square 3)
         (square 4)))

(sqrt (+ 9 16))

(sqrt 25)

5

"You can see that `apply-generic` is invoked twice. The first time, it dispatches to the very same procedure
that invoked `apply-generic` in the first place: the top-level `magnitude` procedure. That's the magnitude procedure
we installed as the one for complex numbers.

Invoking that same magnitude procedure again is progress only because, on the second invocation, we pass in a 
data-structure that has one level of type-tag removed, relative to the first invocation. The second invocation
of `apply-generic` dispatches to the version of `magnitude` appropriate to complex numbers in rectangular form."