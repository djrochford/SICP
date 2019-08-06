;Exercise 3.26.  To search a table as implemented above, one needs to scan through the list of records.
;This is basically the unordered list representation of section 2.3.3. For large tables, it may be more
;efficient to structure the table in a different manner. Describe a table implementation where the (key,
;value) records are organized using a binary tree, assuming that keys can be ordered in some way (e.g.,
;numerically or alphabetically). (Compare exercise 2.66 of chapter 2.)

"Here's the idea. Each node of the tree is a key-value pair. The tree is arranged such that, for any
given node, with key K, all nodes on the left sub-tree have keys k < K, and all nodes on the right
sub-tree have keys k > K. You need to be careful, when insertng into the tree, that you preserve 
this property (I won't prove that this is possible for arbitrary sequences of keys here, but it is).
To find a record, you start at the root node, and compare your key with the node's key. If the keys
are the same, you return the value. Otherwise, if you're key is lower in the order than the root node's
key, you recusively do the same thing with the left sub-tree; if, on the other hand, your key is higher
than the root nodes key, you recursively do the same thing with the right sub-tree."