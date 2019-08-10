;Exercise 3.31.   The internal procedure `accept-action-procedure!` defined in `make-wire` specifies that when
;a new action procedure is added to a wire, the procedure is immediately run. Explain why this initialization
;is necessary. In particular, trace through the half-adder example in the paragraphs above and say how the
;system's response would differ if we had defined accept-action-procedure! as

(define (accept-action-procedure! proc)
  		(set! action-procedures (cons proc action-procedures)))

"The only way actions get put on the agenda is by invoking `add-to-agenda`. The only place `add-to-agenda` is
invoked is in `after-delay`. The only time `after-delay` is invoked is inside the actions that are defined in
the basic logic gates -- the inverter, the and-gate and the or-gate. The only time these actions are invoked
is in the `accept-action-procedure`, as defined in the text. Defining `accept-action-procedure` as *above*
removes the one place where actions get put on the agenda. That being the case, if `accept-action-procedure`
were defined as above, the agenda would always be empty, and `propogate` would execute nothing."