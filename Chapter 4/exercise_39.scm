;Exercise 4.39.  Does the order of the restrictions in the `multiple-dwelling` procedure
;affect the answer?

"No. The answer is such that all restrictions are true of it; that remains so whatever
order the restrictions are evaluated in."

;Does it affect the time to find an answer?

"Absolutely. In general: putting narrower restrictions earlier means fewer total
cases are evaluated, so putting narrow restrictions early is good."

;If you think it matters, demonstrate a faster program obtained from the given one
;by reordering the restrictions. If you think it does not matter, argue your case.

"I do think it matters. You can get a faster version by moving the `(require (> miller cooper))`
up to the top of the list. Why? After the `distinct?` requirement, there are 5! = 120 surviving cases. The
next requirement hit in the current version of `multiple-dwelling` is `(not (= baker 5))`;
this knocks out 4! = 24 cases, leaving 96. On the other hand, there are only (4 + 3 + 2 + 1) * 3! = 60
cases that survive the `distinct?` requirement followed by the `(> miller cooper))`
requirement. (4 + 3 + 2 + 1 ways for cooper to be greater than miller, times the 3! ways to assign
the remaining values.)

