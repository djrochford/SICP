;Exercise 3.26.  To search a table as implemented above, one needs to scan through the list of records.
;This is basically the unordered list representation of section 2.3.3. For large tables, it may be more
;efficient to structure the table in a different manner. Describe a table implementation where the (key,
;value) records are organized using a binary tree, assuming that keys can be ordered in some way (e.g.,
;numerically or alphabetically). (Compare exercise 2.66 of chapter 2.)

"Here's the idea. Each node of the tree is a key-value pair (where we allow a null value to be a degenerate
case of a key-value pair). The tree is arranged such that, for any given node, with key K, all nodes on the
left sub-tree have keys k < K, and all nodes on the right sub-tree have keys k > K. You need to be careful,
when insertng into the tree, that you preserve this property, but this isn't very hard to do. You do it like
this: go to the root node. If the root node is null, insert your key-value pair right there. If the root
node has key k1 = to your key k2, then replace the value at the node with your value. If k1 > k2,
recursively do the same thing with the left sub-tree. If k1 < k2, recursively do the same thing with the
right sub-tree.
Findind a record is almost the same as inserting, except that you return a value once you find a node such
that k1 = k2, or you return some not-found value once you hit a null node."