;Exercise 3.63.  Louis Reasoner asks why the `sqrt-stream` procedure was not written
;in the following more straightforward way, without the local variable `guesses`:

(define (sqrt-stream x)
  		(cons-stream 1.0
               		(stream-map (lambda (guess)
                             			(sqrt-improve guess x))
                           		(sqrt-stream x))))

;Alyssa P. Hacker replies that this version of the procedure is considerably less efficient
;because it performs redundant computation. Explain Alyssa's answer.

"
For reference, here is the original `sqrt-stream`:
"
(define (sqrt-stream x)
  		(define guesses
    			(cons-stream 1.0
                  			 (stream-map (lambda (guess)
                               			 		 (sqrt-improve guess x))
                             			 guesses)))
  		guesses)

"The important difference is the second argument of the `stream-map`. In the original, that argument
is `guesses` -- i.e., the very list that is being generated in the `define` block. In Louis's
version, that second parameter is `sqrt-stream x` -- not the very list being generated, but the result
of a second invocation of `sqrt-stream`. This second invocation does not have access to the memoised
values of the list being generated, nor to the memoised values of other invocations of `sqrt-stream`
from previous recursive calls. So Louis Reasoner's procedure takes no advantage of memoisation,
and calculates each value of sqrt-stream anew -- i.e., performs 'redundant computation, as Alyssa put it."

;Would the two versions still differ in efficiency if our implementation of `delay` used only
;`(lambda () <exp>)` without using the optimization provided by memo-proc (section 3.5.1)?

"They would not -- the source of the inefficiency in Louis's procedure is that it doesn't take
advantage of memoisation. Without memoisation, there is no difference between Louis's procedure
and the original."