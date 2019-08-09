;Exercise 3.29.  Another way to construct an or-gate is as a compound digital logic device,
;built from and-gates and inverters. Define a procedure `or-gate` that accomplishes this.

"'not (not-a1 and not-at)' is equivalent to 'a1 or a2', so:"

(define (or-gate a1 a2 output)
		(let ((b1 (make-wire))
			  (b2 (make-wire))
			  (c (make-wire)))
			 (inverter a1 b1)
			 (inverter a2 b2)
			 (and-gate b1 b2 c)
			 (inverter c output)
			 'ok))

;What is the delay time of the or-gate in terms of `and-gate-delay` and `inverter-delay`?

"The inversions of a1 and a2 can happen in parallel, so that's one inverter-delay to
do both of those. Then add an and-gate delay to and them, and one more inverter-delay, to
get or-gate-delay = 2*inverter-delay + and-gate-delay.
"