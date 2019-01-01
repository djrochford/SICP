;Exercise 2.55.  Eva Lu Ator types to the interpreter the expression

(car ''abracadabra)

;To her surprise, the interpreter prints back `quote`. Explain.

"The above is syntactic sugar for:"

(car '(quote abracadabra))

"which is the car a of list that has the symbol 'quote' as it's first element,
which is the symbol 'quote'."