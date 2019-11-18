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


|           u: unassigned                   |
|           v: unassigned                   |
|       <e3> gets executed in this context  |
---------------------------------------------
"

;Why is there an extra frame in the transformed program?

;Explain why this difference in environment structure can never make a
;difference in the behavior of a correct program.

;Design a way to make the interpreter implement the ``simultaneous'' scope
;rule for internal definitions without constructing the extra frame.