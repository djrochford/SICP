;Exercise 4.67.  Devise a way to install a loop detector in the query system
;so as to avoid the kinds of simple loops illustrated in the text and in exercise
;4.64. The general idea is that the system should maintain some sort of history of
;its current chain of deductions and should not begin processing a query that it is
;already working on. Describe what kind of information (patterns and frames) is
;included in this history, and how the check should be made. (After you study the
;details of the query-system implementation in section 4.4.4, you may want to modify
;the system to include your loop detector.)

"A foolproof but inefficient way to do this is to record the patterns it has evaluated and
the bindings of the variables in those patterns, in the frames in which they were evaluated.
If it ever evaluates the same pattern with the same variable bindings, it's in a loop, and should
terminate the current branch of execution. One subtlety here: if a variable is bound to another variable in one frame,
and the same variable is bound to a third variable in another frame, those two bindings should count
as the same.

Now, the history stored this way will get large, and checking each time will take a lot of time.
Loops can only happen through rule application; we can use this fact to make things a bit more
efficient. First we can just save the rules that get applied, plus the variable bindings for those rules. 
Secondly, we can check the history for duplicates only when applying a rule.
"