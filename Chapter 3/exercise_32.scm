;Exercise 3.32.  The procedures to be run during each time segment of the agenda are kept in a queue.
;Thus, the procedures for each segment are called in the order in which they were added to the agenda
;(first in, first out). Explain why this order must be used. In particular, trace the behavior of an
;and-gate whose inputs change from 0,1 to 1,0 in the same segment and say how the behavior would differ
;if we stored a segment's procedures in an ordinary list, adding and removing procedures only at the
;front (last in, first out).

"Call the inputs to the and-gate 'a1' and 'a2'. They each have the `and-gate` actions in their `action-procedues`
list -- i.e."
(define (and-action-procedure)
    	(let ((new-value (logical-and (get-signal a1)
    								  (get-signal a2))))
      		 (after-delay and-gate-delay
                   		  (lambda ()
                     			  (set-signal! output 
                     			  			   new-value)))))

"This procedure executes whenever `set-signal` changes a wire's singal value.
Now, suppose a1 currently has signal 0 and a2 current has signal 1, and we..."
(set-signal! a1 1)
(set-signal! a2 0)

"After the execution of the first `set-signal` two things happen: firstly, the signal value of a1 becomes 0, and
secondly..."

(lambda ()
	    (set-signal! output 
		  			 new-value))

"...gets put on the agenda, on the head of the list (we are supposing) of the relevant time segment, with `new-value`
equal to..."
(logical-and (get-signal a1)
    		 (get-signal a2))
"which at that point in time equal 1.

When the second `set-signal` executes, the signal value of a1 gets set to 0, and that procedure gets put on the head of
the queue, and this time `new-value` is equal to 0.

Now, when propogate executes the actions on the list, it will execute the one that sets `output` to 0 first, and will
then execute the actions taht sets `output` to 1, leaving the output, after that time-segment at 1, despite the
fact that the inputs to the and-gate are 1 and 0. Wrong!

In general, the actions need to get executed in the order in which they were written to avoid setting outputs based
on input-values when the inputs are in a intermediate state, and not in their final state in the time-segment."