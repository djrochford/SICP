;Exercise 4.60.  By giving the query

(lives-near ?person (Hacker Alyssa P))

;Alyssa P. Hacker is able to find people who live near her, with whom she can ride to work.
;On the other hand, when she tries to find all pairs of people who live near each other by querying

(lives-near ?person-1 ?person-2)

;she notices that each pair of people who live near each other is listed twice; for example,

(lives-near (Hacker Alyssa P) (Fect Cy D))
(lives-near (Fect Cy D) (Hacker Alyssa P))

;Why does this happen?

"Because what is returned is one statement for every ordered pair that satisfies the formula.
For each two people, there are two distinct ordered pairs of those people. If one pair satisfies
`(lives-near ?person-1 ?person2)`, the other will also, `lives-near` being a symmetric relation."

;Is there a way to find a list of people who live near each other, in which each pair appears only once? Explain.

"It could be done, by providing a canonical ordering, and a predicate that requires that two arguments be ordered
in the canonical way. Then you could get a list of people who live near each other without repeats with a query
like this:"

(and (lives-near ?person1 ?person2)
     (ordered ?person1 ?person2))

"where `ordered` is our canonical ordering predicate."