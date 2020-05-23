;Exercise 4.48.  Extend the grammar given above to handle more complex sentences.
;For example, you could extend noun phrases and verb phrases to include adjectives and adverbs,
;or you could handle compound sentences.

"Let's try the first suggestion -- extending noun phrase to include adjectives.
Here is the noun-phrase parsing procedures, from the book:"
(define (parse-simple-noun-phrase)
        (list 'simple-noun-phrase
              (parse-word articles)
              (parse-word nouns)))

(define (parse-noun-phrase)
        (define (maybe-extend noun-phrase)
                (amb noun-phrase
                     (maybe-extend (list 'noun-phrase
                                          noun-phrase
                                          (parse-prepositional-phrase)))))
        (maybe-extend (parse-simple-noun-phrase)))

"We'll extend this by extending what counts as a simple noun phrase. In English, it is grammatical
to put any number of adjectives (including zero) between the article and the noun in the noun-phrase.
To accommodate this fact, we'll introduce two new syntactic categories: an adjective-string, which
can be either an adjective or an adjective followed by an adjective-string, and an extended noun, which
can be either a noun or an adjective-string and a noun. It looks like this:"

(define (parse-adjective-string)
        (define (maybe-extend adjective-string)
                (amb adjective-string
                     (maybe-extend (list 'adjective-string
                                          adjective-string
                                          (parse-word adjectives)))))
        (maybe-extend (parse-word adjectives)))

(define (parse-extended-noun)
        (amb (parse-word nouns)
             (list 'extended-noun)
                    (parse-adjective-string)
                    (parse-word nouns)))

(define (parse-simple-noun-phrase)
        (list 'simple-noun-phrase
              (parse-word articles)
              (parse-extended-noun)))