;Exercise 4.42.  Solve the following "Liars" puzzle (from Phillips 1934):

;Five schoolgirls sat for an examination. Their parents -- so they thought -- showed an undue degree of interest in the result.
;They therefore agreed that, in writing home about the examination, each girl should make one true statement and one untrue one.
;The following are the relevant passages from their letters:

;Betty: ``Kitty was second in the examination. I was only third.''
;Ethel: ``You'll be glad to hear that I was on top. Joan was second.''
;Joan: ``I was third, and poor old Ethel was bottom.''
;Kitty: ``I came out second. Mary was only fourth.''
;Mary: ``I was fourth. Top place was taken by Betty.''
;What in fact was the order in which the five girls were placed?

"Let B1 be Betty's first statement, B2 her second, E1 Ethel's first statement, and so on.

First, note that B1 = K1 -> not-K2 = not-M1 -> M2 -> not-E1 -> E2 -> not-B1
So B1 implies a contradiction, and must be false, and B2 must be true.

So Betty was third.

Now, B2 -> not-J1 -> J2 -> not-E1 -> E2

So Ethel was fifth, and Joan was second.

Also, B2 -> not-M2 -> M1.

So Mary was fourth.

That leaves Kitty for first place.

So the solution is: Kitty first, Joan second, Betty third, Mary fourth and Ethel fifth.
"


