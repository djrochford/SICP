;Exercise 2.32.  We can represent a set as a list of distinct elements, 
;and we can represent the set of all subsets of the set as a list of lists. 
;For example, if the set is (1 2 3), then the set of all subsets is 
;(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). 
;Complete the following definition of a procedure 
;that generates the set of subsets of a set and give a clear explanation of why it works:

(define (subsets s)
        (if (null? s)
            (list '())
            (let ((rest (subsets (cdr s))))
                 (append rest (map (lambda (x) (cons (car s) x)) 
                                   rest)))))

(subsets (list 1 2 3)) ;(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

"Why does this work? 

First, here's a proof of the following claim about sets:

Let S be a set, e some thing. Let S+ be S union {e}. P(S+), the set of all subsets of S+, 
is equal to the union of:
a) P(S), the set of all subsets of S, and
b) the set {X union {e} for all X in P(S)}. That is, get P(S), and union e to each set
in it; that's {X union {e} for all X in P(S)}

Call that big union T. To prove P(S+) equals T, I will first prove that P(S+) is a subset of T, 
then that T is a subset of P(S+).

So: proof that P(S+) is a subset of T.

Take some arbitrary member U of P(S+). e is either a member of U or not. 

If e is not a member of U, then U contains only elements in S, 
and thus must be a member of P(S). So it is a member of T.

On the other hand, if e is an element of U, then it is the union of {e} and some set that contains
only elements in S, which must be a member of P(S). So U is equal to {e} union X, for some
X in P(S). So U is member of {X union {e} for all X in P(S)}. So it's a member of T.

Either way U is a member of T.

U was arbitrary, so for all members X of P(S+), X is a member of T.

So P(S+) is a subset of T.

Now, a proof that T is a subset of P(S+).

Let U be an arbitrary member of T. U is either a member of P(S), or {X union {e} for all X in P(S)}.

Suppose U is a member of P(S). Then all of U's elements are in S. So all of U's elements are in S+. So U is in P(S+).

On the other hand, suppose U is a member of {X union {s} for all X in P(S)}. Then all U's elements
are either e or a member of S -- that is, all U's elements are in S+. So U must be a member of P(S+).

Either way, U is a member of P(S+).

U was arbitrary, so for all members X of T, X is a member of P(S+).

So T is a subset of P(S+)

So P(S) is a subset of T, and T is a subset of P(S+).

So P(S+) equals T.

Alrighty, now we can see why our procedure must work.
Consider the function f who's domain is data structures of Scheme s.
The following completely defines f:
If s is not a list, f(s) = s
If s is a list, f(s) = the set S containing f(e) for every element e
of s.
(I take it to be clear that f is well defined.)

Let s be an arbitrary input list to `subsets`, 
and let (subsets s) the output.
We will prove that f((subsets s)) = P(f(s))

Proof by induction.

Base case: s is the empty list, and f(s) is the empty set.
In that case the predicate of the `if` statement evaluates to `true`,
and (subsets s) is the list containing the empty list,
and f((subsets s)) is the singleton of the empty set,
which is indeed P(f(s)).

Inductive step: s is a non-empty list, and f(s) = S a non-empty set.
Let e be the first member of s.
When s is non empty, the predicate of the `if` statement evaluated to `false`,
and the procedure evaluates the alternative clause:
`(let ((rest (subsets (cdr s))))
                 (append rest (map (lambda (x) (cons (car s) x)) 
                                   rest)))))`

That is, it returns:
`(append (subsets (cdr s)) 
         (map (lambda (x) (cons (car s) x)) 
              (subsets (cdr s))))`

Consider each of the arguments of the append:
1. (subsets (cdr s)), and
2. (map (lambda (x) (cons (car s) x)) 
        (subsets (cdr s)))

f((cdr s)) = S - {e}, so by the inductive assumption, 
f((subsets (cdr s)) = P(f((cdr s))) = P(S - {e})
So f of 1 is P(S-{e})
And (car s) = e, so 2 evaluates to the list that consists of
all the lists in (subsets (cdr s)) with e added to them. So, f of 2 is
{X union {e} for all X in f((subsets (cdr s)))}
= {X union {e} for all X in P(S - {e})}
So f of the total append equals the union of P(S-{e}) and
{X union {e} for all X in P(S - {e})}
So, by the proof about sets from earlier, f of the entire append equals P(S) = P(f(s))
So f((subsets s)) = P(f(s)).
That finishes the proof of the inductive step, 
which finishes the proof that this procedure works as intended.
"""