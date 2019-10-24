;Exercise 4.10.  By using data abstraction, we were able to write an `eval`
;procedure that is independent of the particular syntax of the language to
;be evaluated. To illustrate this, design and implement a new syntax for
;Scheme by modifying the procedures in this section, without changing `eval` or `apply`.

"I'm not going to spend any time on this, but it's clear it can be done --
an easy change is to permute where in the lists you keep the various parts of the expressions.
You could, for instnce, make `if` statements `(<tag> <consequent> <alternative> <predicate>)`, if you
liked; as long as you made the necessary changes to `make-if`, `if-predicate`, `if-consequent`
and `if-alterantive`, you wouldn't need to change `eval` or `apply`."