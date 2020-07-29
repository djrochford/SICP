;Exercise 4.68.  Define rules to implement the `reverse` operation of exercise 2.18,
;which returns a list containing the same elements as a given list in reverse order.
;(Hint: Use `append-to-form`.) 

(rule (reverse () ()))

(rule (reverse (?x . ?y) ?z)
	  (and (reverse ?y ?w)
	  	   (append-to-form ?w (?x) ?z)))

;Can your rules answer both `(reverse (1 2 3) ?x)` and (reverse ?x (1 2 3))` ?

"In the following, I use the following scheme to disambiguate variables. Variables from
rule get numbers added to them, so the ?x from the first application of a rule with an ?x
in it is called ?x1, and so on. For the ?x-es that appear in the original
queies, I use ?x-query. "

"For reference, here are the `append-to-form` rules:"
(rule (append-to-form () ?y ?y))
(rule (append-to-form (?u . ?v) ?y (?u . ?z))
      (append-to-form ?v ?y ?z))

"First, `(reverse (1 2 3) ?x)`"
(reverse (1 2 3) ?x-query)
=> (and (reverse (2 3) ?w1)
	  	(append-to-form ?w1 (1) ?x-query))
"In a frame with ?x1 bound to 1, ?y1 bound to (2 3), ?z1 bound to ?x-query and ?w1 unbound."

"The `reverse` part is processed like this:"
=> (and (reverse (3) ?w2)
		(append-to-form ?w2 (2) ?w1))
"In a frame with ?x2 bound to 2, ?y2 bound to (3), ?z2 bound to ?w1 and ?w2 and ?w1 unbound."

"and again"
=> (and (reverse () ?w3)
		(append-to-form ?w3 (3) ?w2))
"with ?x3 bound to 3, ?y3 bound to (), ?z3 bound to ?w3 and ?w2 unbound"
=> (reverse () ())

"So with ?w is bound to (), we now process the last `append-to-form";
=> (append-to-form () (3) ?z)
=> (append-to-form () (3) (3))

"so now with ?z bound to (3) we process the `append-to-form` before that:"


