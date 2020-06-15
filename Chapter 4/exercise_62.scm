;Exercise 4.62.  Define rules to implement the `last-pair` operation of exercise 2.17, which returns
;a list containing the last element of a nonempty list.

"For reference, this is `last-pair as I defined it in 2.17:"

(define (last-pair chain)
        (if (null? (cdr chain))
            chain
            (last-pair (cdr chain))))

"We can read the following rules off of this definition:"

(rule (last-pair (?x) (?x)))

(rule (last-pair (?x . ?y) ?z)
      (last-pair ?y ?z))


;Check your rules on queries such as
(last-pair (3) ?x)
"By rule 1: ?x = (3)"
(last-pair (3) (3))

(last-pair (1 2 3) ?x)
"By rule 2: ?x satisfies"
(last-pair (2 3) ?x)
"by rule 2 again, ?x satisfies"
(last-pair (3) ?x)
"and by rule 1, ?x = (3).
So the response is
"
(last-pair (1 2 3) (3))

(last-pair (2 ?x) (3)) 
"By rule 2, ?x satisfies:"
(last-pair (?x) (3))
"And by rule 1 ?x = (3). So the response is"
(last-pair (2 3) (3))

;Do your rules work correctly on queries such as (last-pair ?x (3)) ?
"They don't determine a response, so no, if that's what you mean by 'work correctly'.
But then, it's not clear the response should be in this case. There are infinitely
many correct substitution instances for `?x` in this query.