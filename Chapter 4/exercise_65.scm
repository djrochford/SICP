;Exercise 4.65.  Cy D. Fect, looking forward to the day when he will rise in the organization,
;gives a query to find all the wheels (using the wheel rule of section 4.4.1):

(wheel ?who)

;To his surprise, the system responds

;;; Query results:
(wheel (Warbucks Oliver))
(wheel (Bitdiddle Ben))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))

;Why is Oliver Warbucks listed four times?

"For reference, the `wheel` rule is as follows:"
(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))

"When Cy's query is evaluated, the rule is applied, and the body is evalued in the frame with
`?person` bound to `?who`.

The body of the rule is an `and` query. Evaluating that query involves first evaluating"
(supervisor ?middle-manager ?person)
"and then passing the resulting stream as input to the evaluation of"
(supervisor ?x ?middle-manager)

"When evaluating the first query, the evaluator finds eight matches -- all of the `supervisor`
entries in the db:"
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
(supervisor (Fect Cy D) (Bitdiddle Ben))
(supervisor (Tweakit Lem E) (Bitdiddle Ben))
(supervisor (Reasoner Louis) (Hacker Alyssa P))
(supervisor (Bitdiddle Ben) (Warbucks Oliver))
(supervisor (Scrooge Eben) (Warbucks Oliver))
(supervisor (Cratchet Robert) (Scrooge Eben))
(supervisor (Aull DeWitt) (Warbucks Oliver))
"The output is, thus, a stream containing eight frames, three of which have `?person` (and thus `?who`)
bound to `(Warbucks Oliver)`.

That eight-frame stream is passed as input when evaluating"
(supervisor ?x ?middle-manager)
"In the three frames with `?person` bound to `(Warbucks Oliver)`, `?middle-manager` is bound to, in turn,
`(Bitdiddle Ben)`, `(Scrooge Eben)` and `(Aull DeWitt)`. The corresponding entries in the db are:
"
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
(supervisor (Fect Cy D) (Bitdiddle Ben))
(supervisor (Tweakit Lem E) (Bitdiddle Ben))
(supervisor (Cratchet Robert) (Scrooge Eben))

"So in the output of the evaluation of the second conjunct, and thus of the whole query, there are a total
of four frames in which `?person`, and thus `?who` is bound to `(Warbucks Oliver) -- one for each of the
entires above. And that's why `(Warbucks Oliver)` appears four times in the output."
