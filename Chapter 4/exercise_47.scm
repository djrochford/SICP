;Exercise 4.47.  Louis Reasoner suggests that, since a verb phrase is either a verb or a verb phrase
;followed by a prepositional phrase, it would be much more straightforward to define the procedure
;`parse-verb-phrase` as follows (and similarly for noun phrases):

(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))

;Does this work? Does the program's behavior change if we interchange the order of expressions in the `amb`?

"This does not work, no. There is no base-case to halt the recursion when the verb-phrase is not a plain
old verb. The behaviour does change if the order of the expressions in the `amb` is reversed; in that case,
it will enter infinite recursion even when the verb-phrase is a plain old verb."