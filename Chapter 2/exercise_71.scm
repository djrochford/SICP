;Exercise 2.71.  Suppose we have a Huffman tree for an alphabet of n symbols,
;and that the relative frequencies of the symbols are 1, 2, 4, ..., 2^(n-1).
;Sketch the tree for n=5;

"Let the symbols be s1, s2, ... s5, in increasing order of frequency. The tree looks like

|------|-----|-----|-----s1
|      |     |     |    
s5     s4    s3    s2 
"
;for n=10.

"Very similar (you can figure it out)."

"In general, such tree only ever have one leaf to the left of a branch. Proof sketch: by induction.
Base case: n=2. Obviously true.
Inductive step. Suppose the hypothesis is true for n=k. Now consider a sequence of symbols with 
frequencies 1, 2, 4, ..., 2^(k-1), 2k. The tree for the first k symbols will be the same. Their collective
weights are 1 + 2 + ... + 2^(k-1) = 2^(k-1) - 1 < 2k. So the new symbol is weighteir than the rest of
tree combined, and will be on its own (left) branch, one step from the root,
with the rest of the tree on the other branch.
"

;In such a tree (for general n) how many bits are required to encode the most frequent symbol? the least frequent symbol?
"In such a tree, 1 bit is required to encode the most frequent symbol, and n - 1 bits are required to
encode the least frequent symbol."