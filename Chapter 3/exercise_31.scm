;Exercise 3.31.   The internal procedure `accept-action-procedure!` defined in `make-wire` specifies that when
;a new action procedure is added to a wire, the procedure is immediately run. Explain why this initialization
;is necessary. In particular, trace through the half-adder example in the paragraphs above and say how the
;system's response would differ if we had defined accept-action-procedure! as

(define (accept-action-procedure! proc)
  		(set! action-procedures (cons proc action-procedures)))

"The only way actions get put on the agenda is by invoking `add-to-agenda`. The only place `add-to-agenda` is
invoked is in `after-delay`. The only time `after-delay` is invoked is inside the actions that are defined in
the basic logic gates -- the inverter, the and-gate and the or-gate. These actions get invoked in exactly two
places: by `propogate`, which invokes the actions that are already on the agenda, thus setting the actions for
the next time, and in `accept-action-procedure!`, as defined in the text. It's the invocation in
`accept-action-procedure!` that puts actions on the agenda in the first palce; without that invocations, nothing
gets put on the agenda, and so `propogate` doesn't execute any actions, when it runs, and the agenda remains
empty.
"