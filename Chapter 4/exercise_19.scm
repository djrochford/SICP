;Exercise 4.19.  Ben Bitdiddle, Alyssa P. Hacker, and Eva Lu Ator are arguing about
;the desired result of evaluating the expression

(let ((a 1))
     (define (f x)
             (define b (+ a x))
             (define a 5)
             (+ a b))
     (f 10))

;Ben asserts that the result should be obtained using the sequential rule for `define`:
;`b` is defined to be `11`, then `a` is defined to be `5`, so the result is `16`.
;Alyssa objects that mutual recursion requires the simultaneous scope rule for internal
;procedure definitions, and that it is unreasonable to treat procedure names differently
;from other names. Thus, she argues for the mechanism implemented in exercise 4.16.
;This would lead to `a` being unassigned at the time that the value for `b` is to be
;computed. Hence, in Alyssa's view the procedure should produce an error. Eva has a
;third opinion. She says that if the definitions of `a` and `b` are truly meant to be
;simultaneous, then the value `5` for `a` should be used in evaluating `b`. Hence,
;in Eva's view `a` should be `5`, `b` should be `15`, and the result should be `20`.
;Which (if any) of these viewpoints do you support?

"I think it would be ideal if things went the way Eva suggests; the order of definitions
within a given block should not alter the output of the procedure. But..."

;Can you devise a way to implement internal definitions so that they behave as Eva prefers?
"...this is, I think, pretty hard to do in general. One solution is to in general delay
the evaluation of arguments until the last moment -- i.e., make the language lazily-evaluated.
But if we're sticking with eager evaluation, then we'll have to figure out the order in which
definitions must be executed in each block, which is a difficult problem -- the naive approach
is to try every order to see if it works, and that involves O(n!) operations (where n is the
number of definitions). I am sure that can be improved on, but there's no very obvious (to me)
nice way to do it.

In the absence of a workable way to bring about the Eva result, the Alyssa result seems
most sensible -- Ben's choice makes procedures do something incorrect, gievn the standard
way of thinking about the relationship between a procedure and the function it implements.

Indeed, this is what MIT Scheme does, according to a footnote in the book.
"