;Exercise 2.24.  Suppose we evaluate the expression `(list 1 (list 2 (list 3 4)))`. 
;Give the result printed by the interpreter, the corresponding box-and-pointer structure, 
;and the interpretation of this as a tree (as in figure 2.6).

"It might be easier to see the structure here if we conver this
`(list 1 (list 2 (list 3 4)))` into the equivalent `cons` expression:
(cons (1 (cons (list 2 (list 3 4)) nill))) =>
(cons (1 (cons (cons 2 (cons (list 3 4) nill) nill)))) =>
(cons (1 (cons (cons 2 (cons (cons 3 (cons 4 nill) nill) nill)))))"

"Box-and-pointer structure:"

"""
[|][-]-->[|][/]
 |        |    
 v        v
[1]      [|][-]-->[|][/]
          |        | 
          v        v
         [2]      [|][-]-->[|][/]
                   |        |
                   v        v
                  [3]      [4]
"""

"Tree representation is very similar:"
"""
|---------null
|   |
1   |-------------null
    |     |
    2     |---------------null
          |        |  
          3        |
                   |
                   4 
"""