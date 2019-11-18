;Exercise 4.17.  Draw diagrams of the environment in effect when
;evaluating the expression `<e3>` in the procedure in the text,
;comparing how this will be structured when definitions are interpreted
;sequentially with how it will be structured if definitions are scanned 
;out as described

"The aforementioned procedure in the text:"
(lambda <vars>
        (define u <e1>)
        (define v <e2>)
        <e3>)

"The un-scanned-out environment diagram:

|   Global   |
|           <--------<procedure object>
|____________|
      ^
      |
| lambda execution frame                    |
|           u: <e1>                         |
|           v: <e2>                         |
|       <e3> gets executed in this context  |
---------------------------------------------
"

"The scanned out procdure:"
(lambda <vars>
        (let ((u '*unassigned*)
              (v '*unassigned*))
             (set! u <e1>)
             (set! v <e2>)
             <e3>))

"The scanned-out environment diagram:

|   Global   |
|           <--------<procedure object>
|____________|
      ^
      |
| lambda execution frame |
|               <-------------<procedure object>
-------------------------|
      ^
      |
| let execution frame                    |
|       u: <e1>                          |
|       v: <e2>                          |
|      <e3> get executed in this context |
-----------------------------------------|
"

;Why is there an extra frame in the transformed program?

"Because, unlike the original program, <e3> is embedded within a `let`
block in the transformed program, which the evaluator turns into a prcedure
that gets its own frame of execution.

I feel there may be a more fundamental answer to this question, but I don't
know it."

;Explain why this difference in environment structure can never make a
;difference in the behavior of a correct program.

"Let the frames common to both environments be G (for 'Global') and A, and let the
extra frame in the second environment be B.

In the first environment structure, all variable look-ups that occur in
A, and do not find the variable bound in A, will then lookup that variable
in G.

On the other hand, in the second environment structure, all variable
look-ups in A will, when that variable is unbound, look for a binding
in B. If the evaluator finds no bindings in B then, because G is the parent of B, the
evaluator will look for bindings in G.

Now B always contains *no* variable bindings (this follows from the fact that the `let`
block is the only block in the transformed lambda expression). So whenever A does not
contain a binding, the lookup will pass to B and end up looking in G. So variables that
are not bound in A will get their bindings from G, or none at all, just like
in the original environment structure. So the second environment structure is equivalent,
in terms of what variables get bound to what, to the first.
"

;Design a way to make the interpreter implement the ``simultaneous'' scope
;rule for internal definitions without constructing the extra frame.

"A simple way that I think will work is to move all deifnition to the top of the
block in which they occur -- I believe this is called 'hoisting'. Moving around
sub-blocks within a block of code will not change the number of frames that
get created in the execution of that code; only creating new
