;Exercise 3.16.  Ben Bitdiddle decides to write a procedure to count the number
;of pairs in any list structure. "It's easy,"" he reasons. "The number of pairs
;in any structure is the number in the car plus the number in the cdr plus one
;more to count the current pair." So Ben writes the following procedure:

(define (count-pairs x)
        (if (not (pair? x))
            0
            (+ (count-pairs (car x))
               (count-pairs (cdr x))
               1)))

;Show that this procedure is not correct. In particular, draw box-and-pointer diagrams
;representing list structures made up of exactly three pairs for which Ben's procedure
;would return 3; return 4; return 7; never return at all.

"
Return 3:

[|][-]-->[|][-]-->[|][/]
 |        |        | 
 v        v        v
 a        b        c

Return 4:

 [|][/]
  |
  v
 [|][|]
  |  |
  v  v
 [|][/]
  |
  v
  a

Return 7:

[|][|]
 |  |
 v  v
[|][|]
 |  |
 v  v
[|][/]
 |
 v
 b

 Does not return:

  |-----------------|
  v                 |
 [|][-]-->[|][-]-->[|][|]
  |        |           |
  v        v           v
  a        b           c
"

"To test:"

(define threefer '(a b c))
(count-pairs threefer) ;3


(define end '(a))
(define middle (cons end end))
(define fourbee (list middle))
(count-pairs fourbee); 4

(define sevens (cons middle middle))
(count-pairs sevens); 7