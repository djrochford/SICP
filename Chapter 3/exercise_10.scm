;Exercise 3.10.  In the `make-withdraw` procedure, the local variable `balance` is created as
;a parameter of `make-withdraw`. We could also create the local state variable explicitly,
;using `let`, as follows:

(define (make-withdraw initial-amount)
        (let ((balance initial-amount))
             (lambda (amount)
                     (if (>= balance amount)
                         (begin (set! balance (- balance amount))
                                balance)
                     "Insufficient funds"))))

;Recall from section 1.3.2 that let is simply syntactic sugar for a procedure call:

;(let ((<var> <exp>)) <body>)

;is interpreted as an alternate syntax for

;((lambda (<var>) <body>) <exp>)

;Use the environment model to analyze this alternate version of `make-withdraw`, drawing
;figures like the ones above to illustrate the interactions

(define W1 (make-withdraw 100))

(W1 50)

(define W2 (make-withdraw 100))

"For reference, here is the other definition of `make-withdraw`:"

(define (make-withdraw balance)
`       (lambda (amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                "Insufficient funds")))

"Let's start with this old one. (You'll need to forgive how primitive these diagrams are.)

The situation after `(define W1 (make-withdraw 100))` looks like this:

-> |       Global-frame    |
   |   make-withdraw: --------->(<code>)(env-pointer)
   |                     <--------------------|
   |                       |
   |         W1: -------------->(<code>)(env-pointer) 
   |_______________________|                  |
                                              |
             ^                                |
             |                                |
   |  make-withdraw-frame  |                  |
   |     balance: 100      |                  |
   |                     <---------------------
   |_______________________|


After (W1 50)

-> |       Global-frame    |
   |   make-withdraw: --------->(<code>)(env-pointer)
   |                     <--------------------|
   |                       |
 |->         W1: -------------->(<code>)(env-pointer) 
 | |_______________________|                  |
 |                                            |
 |            ^                               |
 |            |                               |
 | |  make-withdraw-frame  |                  |
 | |     balance: 50      |                   |
 | |                     <---------------------
 | |_______________________|
 |
 |
 |-|      W1 frame        |
   |     amount: 50       |


After `(define W2 (make-withdraw 100))`

-> |       Global-frame    |
   |   make-withdraw: --------->(<code>)(env-pointer)
   |                     <--------------------|
   |                       |
   |       W1: -------------->(<code>)(env-pointer) 
   |                       |                  |
   |       W2: ----------------------------------------->(code)(env-pointer) 
   |_______________________|                  |                     |
                                              |                     |
             ^                                |                     |
             |                                |                     |
   |  make-withdraw-frame-1  |                |                     |
   |     balance: 50         |                |                     |
   |                     <---------------------                     |
   |_________________________|                                      |
                                                                    |
                                                                    |
   |  make-withdraw-frame-2  |                                      |
   |      balance: 100       |                                      |
   |                       <----------------------------------------|
   |_________________________|


Now the new `make-withdraw`. The situation after `(define W1 (make-withdraw 100))`:

-> |       Global-frame    |
   |   make-withdraw: --------->(<code>)(env-pointer)
   |                     <--------------------|
   |                       |
   |         W1 ----------------> (code)(env-pointer)
   |_______________________|                 | 
                                             | 
             ^                               |
             |                               | 
   |  make-withdraw-frame  |                 | 
   |  initial-amount: 100  |                 | 
   |                       |                 |     
   |_______________________|                 |
             ^                               | 
             |                               |
   |  anon-procedure-frame |                 |
   |     balance: 100      |                 |  
   |                      <------------------|
   |_______________________|


After `(W1 50)`

-> |       Global-frame    |
   |   make-withdraw: --------->(<code>)(env-pointer)
   |                     <--------------------|
   |                       |
----->         W1 ----------------> (code)(env-pointer)
|  |_______________________|                 | 
|                                            | 
|             ^                              |
|             |                              | 
|   |  make-withdraw-frame  |                | 
|   |  initial-amount: 100  |                | 
|   |                       |                |     
|   |_______________________|                |
|             ^                              | 
|             |                              |
|   |  anon-procedure-frame |                |
|   |     balance: 50       |                |  
|   |                      <-----------------|
|   |_______________________|
|
|
|  |    W1-frame           |
|--|     amount: 50        |
   |_______________________|

After `(define W2 (make-withdraw 100))`

-> |       Global-frame    |
   |   make-withdraw: --------->(<code>)(env-pointer)
   |                     <--------------------|
   |                       |
   |         W1: ----------------> (code)(env-pointer)
------>                    |                  |
|  |         W2:-------------------------------------------->(code)(env-pointer)
|  |______________________|                   |                      |
|                                             |                      |
|             ^                               |                      |
|             |                               |                      |
|   |  make-withdraw-frame-1|                 |                      |
|   |  initial-amount: 100  |                 |                      |
|   |                       |                 |                      |
|   |_______________________|                 |                      |
|             ^                               |                      |
|             |                               |                      |
|   | anon-procedure-1-frame|                 |                      |
|   |     balance: 50       |                 |                      |
|   |                      <------------------|                      |
|   |_______________________|                                        |
|                                                                    |
|                                                                    |
|                                                                    | 
|                                                                    |
|                                                                    | 
|  |  make-withdraw-frame-2|                                         |
|  |  initial-amount: 100  |                                         |
|--                        |                                         |
   |_______________________|                                         |
             ^                                                       | 
             |                                                       |
   | anon-procedure-2-frame|                                         |
   |     balance: 100      |                                         |  
   |                      <------------------------------------------|
   |_______________________|

"
;Show that the two versions of make-withdraw create objects with the same behavior.

"I'm not going to give you a proper proof, but the idea is, a procedure that points to a frame F1
in which A is bound to x, and which in turn points to a frame F2 in which B is bound to y,
which points to a frame F3, is equivalent in behaviour to a procedure that points to a frame
F4 in which A is bound to x and B is bound to y, and which points to F3."

;How do the environment structures differ for the two versions?

"The clearest answer I can give is the above diagrams. In words: in the first version, the object
to which a name is bound by evaluating `make-procedure` points to a frame which points to the global
frame. In the second version,, the object points to a frame which points to a frame which points
to the global frame."
it points"