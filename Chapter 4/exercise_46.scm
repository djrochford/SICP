;Exercise 4.46.  The evaluators in sections 4.1 and 4.2 do not determine what order operands are
;evaluated in. We will see that the `amb` evaluator evaluates them from left to right. Explain why
;our parsing program wouldn't work if the operands were evaluated in some other order.

"The answer that is very specific to this implementation is: the order in which the operands are
evaluated is the order in which words are taken off the *unparsed* list. If the operands are not
evaluated left-to-right, then there can be a mismatch between the part-of-speech parsing procedure
being evaluated and the input to that procedure -- it might happen, for instance, that the first
word, which must be part of a noun-phrase, will be passed to the verb-phrase parsing procedure.

The much more fundamental, and abstracted answer has to do with the grammar of natural languages.
I don't know how to put this point rigorously, yet, but it has to do with the fact that natural
language grammar is such that you need to parse the front of a sentence before you can properly
parse the rest -- no doubt a side-effect of the fact that sentences are spoken in time, and the
hearer must parse the sentence as she hears it.