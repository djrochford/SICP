;Exercise 3.30.  Figure 3.27 shows a *ripple-carry adder* formed by stringing together n full-adders.
;This is the simplest form of parallel adder for adding two n-bit binary numbers. The inputs A1, A2, A3,
;..., An and B1, B2, B3, ..., Bn are the two binary numbers to be added (each Ak and Bk is a 0 or a 1).
;The circuit generates S1, S2, S3, ..., Sn, the n bits of the sum, and C, the carry from the addition.
;Write a procedure `ripple-carry-adder` that generates this circuit. The procedure should take as
;arguments three lists of n wires each -- the Ak, the Bk, and the Sk -- and also another wire C.

(define (ripple-carry-adder A B S c)
	    (let out)
		(if (null? A)
			'ok'
			(let ((a (car A))
			  	  (b (car B))
			      (s (car S))
			      (out (makewire)))
			     (full-adder a b c s out)
			     (ripple-carry-adder (cdr A) (cdr B) (cdr S) out))))


;The major drawback of the ripple-carry adder is the need to wait for the carry signals to propagate.
;What is the delay needed to obtain the complete output from an n-bit ripple-carry adder, expressed in
;terms of the delays for and-gates, or-gates, and inverters?

"First the delay of a half-adder. It consists of an and-gate and an or-gate in parallel, then an
inverter after the and-gate, then and and gate that takes input from the or-gate and the inverter.
So the final and-gate must wait the max of or-gate-delay and (and-gate-delay + inverter-delay), and
then takes another and-gate delay. So, total delay:
	max(or-gate-delay, and-gate-delay + inverter-delay) + and-gate-delay

A full adder has serial half adders followed by an or gate, for a total delay of
 2 * (max(or-gate-delay, and-gate-delay + inverter-delay) + and-gate-delay) + or-gate-delay

 A ripple-carry-adder has k full-adders attached serially, for a total delay of:
 	k * (2(max(or-gate-delay, and-gate-delay + inverter-delay) + and-gate-delay) + or-gate-delay)
"