;Exercise 4.64.  Louis Reasoner mistakenly deletes the outranked-by rule (section 4.4.1)
;from the data base. When he realizes this, he quickly reinstalls it. Unfortunately, he
;makes a slight change in the rule, and types it in as

(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss)
               (supervisor ?staff-person ?middle-manager))))

;Just after Louis types this information into the system, DeWitt Aull comes by to find out who
;outranks Ben Bitdiddle. He issues the query

(outranked-by (Bitdiddle Ben) ?who)

;After answering, the system goes into an infinite loop. Explain why.

"Here's what will happen when we query `(outranked-by (Bitdiddle Ben) ?who)`. Firstly, the system
will find that in can apply the `outranked-by` rule, and will evaluate the rule body in a frame in
which `?staff-person` is bound to `(Bitdiddle Ben)` and `?boss` is bound to `?who`.

It will then seperately evaluate the two disjuncts in the `or` query. First it will evaluate
`(supervisor ?staff-person ?boss)`, and, with `?staff-person` bound to `(Bitdiddle Ben)`, will find
a match with `(supervisor (Bitdiddle Ben) (Warbucks Oliver))`, and return that answer.

It will then evaluate
`(and (outranked-by ?middle-manager ?boss)
      (supervisor ?staff-person ?middle-manager))`, which involves first evaluating
`(outranked-by ?middle-manager ?boss)`. The only bound variable in the query is `?boss` which is
bound to the variable `?who`. So we are effectively evaluating `(outranked-by ?middle-manager ?boss)`
in the empty frame. In that frame the unifier will apply the `outranked-by` rule, binding
`?staff-person` to `?middle-manager` and `?who` to `?boss`. This will mean we evaluate the rule body,
effectively in the empty-frame again, and so evaluate the second disjunct in the empty frame, and then
apply the rule to the first conjunct, and then evaluate the rule body, and so on."


"
