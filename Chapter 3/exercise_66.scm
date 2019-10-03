;Exercise 3.66.  Examine the stream `(pairs integers integers)`. Can you make
;any general comments about the order in which the pairs are placed into the
;stream? For example, about how many pairs precede the pair (1,100)? The pair 
;(99,100)? The pair (100,100)? (If you can make precise mathematical statements
;here, all the better. But feel free to give more qualitative answers if you find
;yourself getting bogged down.)

"For reference, `pairs` is defined as follows:"

(define (interleave s1 s2)
        (if (stream-null? s1)
            s2
            (cons-stream (stream-car s1)
                         (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
        (cons-stream (list (stream-car s)
                           (stream-car t))
                     (interleave (stream-map (lambda (x) 
                                                     (list (stream-car s) 
                                                           x))
                                             (stream-cdr t))
                                 (pairs (stream-cdr s) (stream-cdr t)))))

"Let's take this a piece at a time."
(list (stream-car s) (stream-car t))
"is (1 1)"

(stream-map (lambda (x) (list (stream-car integers) x))
            (stream-cdr integers))
"is equal to ((1 2) (1 3) (1 4) ... )

The `interleave` of that with `(pairs (2 3 4 ...) (2 3 4 ...))`
which is the cons of (2 2) and the `interleave` of ((2 3) (2 4) (2 5) ...)
and `(pairs (3 4 5 ...) (3 4 5 ...))`

So so far the overall result we know to start with
(1 1) (first element of first `cons`)
(1 2) (first element of the first `stream-map`)
(2 2) (first element of `cons` in second invocation of `pairs`)
(1 3) (second element of first `stream-map`)
(2 3) (first element of the `stream-map` in the second invocation of `pairs`)
(1 4) (third element of first `stream-map`)
(3 3) (first element of `cons` in third invocation of `pairs`)

Easy to see: every second element is from ((1 2) (1 3) (1 4) ...)
Less easy, but not too hard to see:
after a little bit, every fourth element comes from ((2 3) (2 4) (2 5) ... )
and after a longer bit, every eighth element comes from ((3 4) (3 5) (3 6) ...)
and after a yet longer bit, every 16th element comes from ((4 5) (4 6) (4 7) ...)

This table shows the order in which the pairs appear in `(pairs integers integers).`
The rows represent the first element of the pair; the columns the second element.
(with thanks to zzd3zzd at http://community.schemewiki.org/?sicp-ex-3.66)

   1   2   3   4   5   6   7 ... 100
1  1   2   4   6   8  10  12 ...
2      3   5   9  13  17  21
3          7  11  19  27  35
4             15  23  39  55
5                 31...
6
7
...
100

Let f(m, n) be the index of `(m n)` in `(pairs integers integers)`.
You can see above that when m = n, f(m, n) = 2^(m-1)

Otherwise, f(m, n) = 2^(m-1) + 2^m * (n - m) - 1
"