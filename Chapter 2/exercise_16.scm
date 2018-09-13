;Exercise 2.16.  Explain, in general, why equivalent algebraic expressions may lead to different answers. 
;Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible? 
;(Warning: This problem is very difficult.)

"Yes it is."

"The general problem is that our code treats every two references to an interval as referring to intervals
that can vary completely independently. Two references that are supposed to be to *identical* values is an
extreme case, which makes it easy to see how our model breaks down. But there's all sorts of ways in which
two given intervals can fail to be completely independent in the way they vary.

A step towards a solution is to know ahead of time what basic variables we'll be using and how they can co-vary
-- we can make the user specify this as part of a session. We can also build in an assumption that identical names
refer to identical values. However, we will still need to know for new, *calculated* values how they vary with respect
to other values we calculate -- for instance, using examples from exercise 2.14, we'll need to know that 
R1R2/(R1 + R2) is equivalent to 1/(1/R1 + 1/R2). So we *at least* need to be able to tell when two algebric expressions are
equivalent, which is a difficult problem in itself. But we'll need to do more than that; we'll need to be able to tell
how the value of any given algebraic expression can vary relative to the value of any other one (assuming we know that
for the terms in the algebraic expression). I haven't tried to solve that problem, but it seems really really hard. "