;Exercise 3.27.  *Memoization* (also called *tabulation*) is a technique that enables a procedure to record, in a local table,
;values that have previously been computed. This technique can make a vast difference in the performance of a program. A memoized
;procedure maintains a table in which values of previous calls are stored using as keys the arguments that produced the values.
;When the memoized procedure is asked to compute a value, it first checks the table to see if the value is already there and, if
;so, just returns that value. Otherwise, it computes the new value in the ordinary way and stores this in the table. As an example
;of memoization, recall from section 1.2.2 the exponential process for computing Fibonacci numbers:

(define (fib n)
        (cond ((= n 0) 0)
              ((= n 1) 1)
              (else (+ (fib (- n 1))
                       (fib (- n 2))))))

;The memoized version of the same procedure is

(define memo-fib
       (memoize (lambda (n)
                        (cond ((= n 0) 0)
                              ((= n 1) 1)
                              (else (+ (memo-fib (- n 1))
                                       (memo-fib (- n 2))))))))

;where the memoizer is defined as

(define (memoize f)
        (let ((table (make-table)))
             (lambda (x)
                     (let ((previously-computed-result (lookup x table)))
                          (or previously-computed-result
                              (let ((result (f x)))
                                   (insert! x result table)
                                   result))))))

;Draw an environment diagram to analyze the computation of `(memo-fib 3)`. 

"An environment diagram:

After (define memo-fib ...):

--> |  Global Frame   |  
    |                 |
    |  memoize -----------><procedure object>
    |               <------------------|
    |                 |
    | memo-fib ------------------------------------><procedure object>
    |                 |                                     |
    |-----------------|                                     |
           ^                                                |
           |                                                |
    |  memoize frame  |                                     |
    |                 |                                     |
    |  f: -----------------><procedure object>              |
    |               <--------------|                        |
    |-----------------|                                     |
            ^                                               |
            |                                               |
                                                            |
    | (anonymous let) |                                     |
    |                <--------------------------------------|
    | table: <table object>
    |-----------------|




Then when `(memo-fib 3)` executes:

--> |  Global Frame   |  
    |                 |
    |  memoize -----------><procedure object>
    |               <------------------|
    |                 |
    | memo-fib ------------------------------------><procedure object>
    |                 |                                       |
    |-----------------|                                       |
           ^                                                  |
           |                                                  |
      |  memoize frame  |                                     |
      |                 |                                     |
      |  f: -----------------><procedure object>              |
 | -->|               <--------------|                        |
 |    |-----------------|                                     |
 |            ^                                               |
 |            |                                               |
 |                                                            |
 |    | (anonymous let) |                                     |
 |    |                <--------------------------------------|
 |    | table: <table object>
 |    |                <-----------------------------|
 |    |-----------------|                            |
 |           ^                                       |
 |           |                                       |
 |    | memo-fib frame |                             |
 |    |  x: 3          |                             |
 |    ------------------                             |
 |          ^                                        |
 |          |                                        |
 |    | (anonymous let)                   |          |
 |    | previously-computed-result: null  |          | 
 |    -------------------------------------          |
 |          ^                                        |
 |          |                                        | 
 |    | (anonymous let)|                             |
 |    | result: 2      |                             |
 |    ------------------                             |
 |                                                   |
 |---| f frame  |                                    |
 |   | n:3      |                                    |
 |   ------------                                    |
 |                                                   |
 |                                                   | 
 |  | memo-fib frame |-------------------------------|
 |  |  x: 2          |                               |
 |  ------------------                               |
 |      ^                                            |
 |      |                                            |
 |  | (anonymous let)                  |             |
 |  | previously-computed-result: null |             |
 |  ------------------------------------             |
 |        ^                                          |
 |        |                                          |    
 |  | (anonymouse let)|                              |
 |  |   result:  1    |                              |
 |  -------------------                              |
 |                                                   |
 |--| f frame  |                                     |
    | n:2      |                                     |
    ------------                                     |
                                                     |
    | memo-fib frame |                               |
    | x: 1           |-------------------------------|
    ------------------                               |
                                                     |
                                                     |
    | memo-fib frame |-------------------------------|
    | x: 0           |                               |
    ------------------                               |
                                                     |
                                                     |
    | memo-fib frame |--------------------------------
    |  x: 1          |
    ------------------
"

;Explain why `memo-fib` computes the nth Fibonacci number in a number of steps proportional to n.

"
Here is a diagram showing the invocations of `fib` triggered by executing `(fib [n])`:

(fib [n])
|
|--------------------(fib [n-2])
|                        |
|                        |----------------------(fib [n-4])-------...
|                        |                           |
(fib [n-1])          (fib [n-3])                     |
|                        |                          ...
|                        |--------------...
|                        | 
|                       ...
|
|
|--------------------(fib [n-3])
|                         |                  
|                         |---------------...
(fib (n-2))               |
|                         ...
|
|-------------------(fib [n-4])----------...
|                        |
|                        |
|                       ...
(fib (n-3))
|
|--------------------...
|
(fib (n-4))
|
|------------...
...

(A parent node in the tree above triggers it's child invocations.)

`(memo-fib [n])`, however, looks like this:

(memo-fib [n])
|
|--------------------(memo-fib [n-2])
|                        
|                      
|                        
(memo-fib [n-1])          
|                                           
|                        
|                       
|          
|
|
|--------------------(memo-fib [n-3])
|                         
|                         
(memo-fib (n-2))               
|                         
|
|-------------------(memo-fib [n-4])
|                        
|                        
|                       
(memo-fib (n-3))
|
|--------------------(memo-fib [n-5])
|
...
|
|
(memo-fib 2)
|
|--------------------(memo-fib 0)
|
(memo-fib 1)

Why is that? The beginning of the `memo-fib` tree looks just like the beginning of the `fib` tree.
Execution goes depth-first and to the left, sp `(memo-fib [n-1])` executes first. That invocation
of `memo-fib` spawns two more, and again it executes the left-most one in the tree. So `memo-fib`
goes all the way down the left-most branches, from n, n-1, n-2, ... to 1, a base case. It will then
execute it's first right node, where n=0, another base case, and in doing so will get an answer for
`memo-fib 2`. Now the memo-fib magic kicks in, and the answer to `memo-fib 2` gets saved in the table;
so the next time `(memo-fib 2)` gets invoked, it will *not* spawn any more `memo-fib` invocations, but
just spit back the answer.

Now it hits the right node spawned by `(memo-fib 3)`, which is `(memo-fib 1)`, a base case, and gets
an answer for `(memo-fib 3)`, which again it saves, thus preventing the need to do any further work
the next time `(memo-fib 3)` gets invoked.

In general, `memo-fib` will continue to save answers in this order, for n=2, 3, 4,..., and will traverse
the execution tree in such a way that, by the time it sees a second invocation of `(memo-fib [k])`, it
will already have saved the answer, and will avoid any more invocations of `memo-fib`. The result is the
tree you see above. (This should be proved, really, but I'm not going to bother; staring at the tree is
likely enough to convince you.)

The number of nodes in this tree grows linearly with n, and the amount of work at each individual node is
constant, so `memo-fib` gets it's answer in linear time.
"

;Would the scheme still work if we had simply defined memo-fib to be (memoize fib)?
"No it would not, because in that case `memo-fib`'s recursive calls would be to `fib`, not `memo-fib`, and
those calls would not take advantage of the table while executing."