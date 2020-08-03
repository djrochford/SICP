;Exercise 4.68.  Define rules to implement the `reverse` operation of exercise 2.18,
;which returns a list containing the same elements as a given list in reverse order.
;(Hint: Use `append-to-form`.) 

(rule (reverse () ()))

(rule (reverse (?x . ?y) ?z)
	  (and (reverse ?y ?w)
	  	   (append-to-form ?w (?x) ?z)))

;Can your rules answer both `(reverse (1 2 3) ?x)` and (reverse ?x (1 2 3))` ?

"In the following, I use the following scheme to disambiguate variables. Variables from
rule get numbers added to them, plus the rule, so the ?x from the first application of a
a reverse rule with an ?x in it is called ?x1-reverse, and so on. For the ?x-es that appear in the original
queies, I use ?x-query. "

"For reference, here are the `append-to-form` rules:"
(rule (append-to-form () ?y ?y))
(rule (append-to-form (?u . ?v) ?y (?u . ?z))
      (append-to-form ?v ?y ?z))

"First, `(reverse (1 2 3) ?x)`"
(reverse (1 2 3) ?x-query)
=> (and (reverse (2 3) ?w1-reverse)
	  	(append-to-form ?w1-reverse (1) ?x-query))
"In a frame with ?x1-reverse bound to 1, ?y1-reverse bound to (2 3), ?z1-reverse bound to
?x-query and ?w1-reverse unbound."

"The `reverse` part is processed like this:"
=> (and (reverse (3) ?w2-reverse)
		(append-to-form ?w2-reverse (2) ?w1-reverse))
"In a frame with ?x2-reverse bound to 2, ?y2-reverse bound to (3), ?z2-reverse bound to ?w1
and ?w2-reverse and ?w1-reverse unbound."

"and again"
=> (and (reverse () ?w3-reverse)
		(append-to-form ?w3-reverse (3) ?w2-reverse))
"with ?x3-reverse bound to 3, ?y3-reverse bound to (), ?z3-reverse bound to ?w3-reverse and ?w3-reverse
and ?w2-reverse unbound."
"The reverse calculations bottom out here:"
=> (reverse () ())
"with ?w3-reverse bound to ()"

"Then we evaluate the final `(append-to-form ?w3-reverse (3) ?w2-reverse))`, with ?w3 bound to ():"
=> (append-to-form () (3) ?w2-reverse)
=> (append-to-form () (3) (3))
"with ?w2-reverse bound to (3)"

"Now we process the `(append-to-form ?w2-reverse (2) ?w1-reverse)`"
=> (append-to-form (3) (2) ?w1-reverse)
=> (append-to-form () (2) ?z1-atf)
"With ?w1-reverse bound to (?u1-atf . ?z1-atf), ?u1-atf bound to 3, ?v1-atf bound to (), ?y1-atf bound to (2) and ?z1-atf unbound"
"That becomes"
=> (append-to-form () (2) (2))
"So now ?z1-atf is bound to (2), which makes ?w1-reverse bound to (3 2)"

"Now we process `(append-to-form ?w1-reverse (1) ?x-query))`. I won't step through the details again;
the result is that ?x-query gets bound to (3 2 1). And that is our answer."

"Sadly, we get an infinite loop when we try to process (reverse ?x (1 2 3))"

"If we reverse the order of the conjuncts in the second `reverse` rule, the opposite happens: we get
and answer for `(reverse ?x (1 2 3))` but not for (reverse (1 2 3) ?x)"ß

