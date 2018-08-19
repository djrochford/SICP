;Exercise 2.9.  The *width* of an interval is half of the difference between its upper and lower bounds. 
;The width is a measure of the uncertainty of the number specified by the interval. 
;For some arithmetic operations the width of the result of combining two intervals 
;is a function only of the widths of the argument intervals, 
;whereas for others the width of the combination is not a function of the widths of the argument intervals. 
;Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals 
;being added (or subtracted). 

"Let x1, x2 be the lower and upper bounds of an interval X; y1, y2 be the lower and upper bounds of another interval Y.
The width of X = (x2 - x1)/2; the width of Y = (y2 - y1)/2. 
Let Z be the sum of intervals X and Y. The lower bound z1 of Z = x1 + y1. The upper bound z2 of Z = x2 + y2.
The width of Z = ((x2 + y2) - (x1 + y1))/2
               = (x2 - x1 + y2 - y1)/2 
               = (x2 - x1)/2 + (y2 - y1)/2 
               = the width of X + the width of Y
Hence the width of Z is a function of the width of X and the width of Y.

Let Z' = X - Y, z'1 be the lower bound of Z', z'2 be the upper bound of Z'.
z'1 = x1 - y2, z'2 = x2 - y1.
So the width of Z' = ((x2 - y1) - (x1 - y2))/2
                   = (x2 - y1 - x1 + y2)/2
                   = (x2 - x1)/2 + (y2 - y1)/2
                   = the width of X + the width of Y
Hence the width of Z' is a function of the width of X and the width of Y."

;Give examples to show that this is not true for multiplication or division.

"Take intervals [0, 1] and [1, 2]. The width of [0, 1] is 1/2, the width of [1, 2] is 1/2.
The product of those intervals is [0, 2], the width of which is 1.
Now take intervals [1, 2] and [2, 3], also with widths 1/2 and 1/2.
The product of those intervals is [2, 6], the width of which is 2.
So the width of the product of intervals is not a function of the width of the original intervals.

Similary take the quotient of [0, 1] and [1, 2]; that's [0, 1] times [1/2, 1] = [0, 1], with width 1/2.
Now take the quotient of [1, 2] and [2, 3]. That equals [1, 2] times [1/3, 1/2] = [1/3, 1], with width 1/3.
So the width of the quotient of intervals is not a function of the width of the original intervals.