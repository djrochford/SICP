;Exercise 2.13.  Show that under the assumption of small percentage tolerances 
;there is a simple formula for the approximate percentage tolerance 
;of the product of two intervals in terms of the tolerances of the factors. 
;You may simplify the problem by assuming that all numbers are positive.

"The percentage tolerance of an interval p = 100 * w/c, where w is the
intervals width, and c its center. So w = p * c / 100 
The lower bound of the interval is 
  c - w = c - (p * c)/100
       = c * (1 - p/100)
Similarly, the upper bound is c * (1 + p/100)

Let i1, i2 be two intervals, and let c1, p1, c2, p2 be their centres and
percentage tolerances, respsectively.

Assuming all the numbers involved are positive, the lower-bound of i1 * i2 is
the lower-bound of i1 * the lower bound of i2, which is
c1 * (1 - p1/100) * c2 * (1 - p2/100) = c1c2 - c1p2/100 - c2p1/100 + p1p2/10000
Similarly, the upper bound is c1c2 + c1p2/100 + c2p1/100 + p1p2/10000

So the width of i1 * i2 is (the upper-bound - the lower bound) / 2 
  = (2 * c1p2/100 + 2 * c2p1/100) / 2
  = (c1p2 + c2p1) / 100
And the centre is (the lower bound + the upper bound) / 2 
 = (2c1c2 + 2p1p2/10000) / 2
 = (c1c2 + p1p2/10000)

So the percentage tolerance is 100 * (c1p2 + c2p1)/100 / (c1c2 + p1p2/10000)
 = (c1p2 + c2p1)/(c1c2 + p1p2/10000)

If p1 and p2 are small, p1p2/10000 is close to 0, so the above is approximately

 (c1p2 + c2p1) / c1c2"
