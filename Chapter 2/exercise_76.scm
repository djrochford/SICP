;Exercise 2.76.  As a large system with generic operations evolves, new types of data objects
;or new operations may be needed. For each of the three strategies -- generic operations
;with explicit dispatch, data-directed style, and message-passing style -- describe the changes
;that must be made to a system in order to add new types or new operations. Which organization
;would be most appropriate for a system in which new types must often be added? Which would be most
;appropriate for a system in which new operations must often be added?

"
Generic operations with explicit dispatch: relatively easy to add a new procedure -- you can write
the procedure without changing code elsewhere. Relatively hard to add a new data-type -- you need
to add code to each procedure to deal with the new data-type.

Data-directed style: each new procedure requires adding a new row to the table -- i.e., a new sub-procedure
for each data type. This is comparable to writing a new procedure in the generic-operations approach.
Each new data type requires adding a new column to the table -- a new sub-procedure for each procedure.
This is comparable to adding a new data-type in the message-passing approach. Either way, you don't need to
touch existing code. Best of both worlds!

Message-passing style: relatively easy to add a new data-type -- you can create it without changing
code elsewhere. Relatively hard to add a new procedure -- you need to add code to each data-type.

If you're going to add types often, use either message-passing style or data-directed style. If you're going
to add procedures often, use either explicit dispatch or data-directed style.
"