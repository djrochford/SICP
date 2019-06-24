;Exercise 3.20.  Draw environment diagrams to illustrate the evaluation of the sequence of
;expressions

(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
(car x)
;17

;using the procedural implementation of pairs given above. (Compare exercise 3.11.

"That procedural implementation, for reference, is:"

(define (cons x y)
        (define (set-x! v) (set! x v))
        (define (set-y! v) (set! y v))
        (define (dispatch m)
                (cond ((eq? m 'car) x)
                      ((eq? m 'cdr) y)
                      ((eq? m 'set-car!) set-x!)
                      ((eq? m 'set-cdr!) set-y!)
                (else (error "Undefined operation -- CONS" m))))
        dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))

(define (set-car! z new-value)
        ((z 'set-car!) new-value)
        z)

(define (set-cdr! z new-value)
        ((z 'set-cdr!) new-value)
        z)

"Now the diagrams.

Initially, there's just the global frame, with each of `cons`, `car`, `cdr`, `set-car!`,
and `set-cdr!` pointing to their own procedure objects, which point back to the global frame.
(I'll omit those procedure objects in the following diagrams.)

After `(define x (cons 1 2))`:

| global frame |
|              |
|     x: --------------------------------------------|
|______________|                                     |
      ^                                              |
      |                                              |
| cons frame 1|                                      |
|      x: 1   |                                      |
|      y: 2   |                                      |
|      set-x!: -------> <procedure deinition>        |
|            <----------------|                      |
|             |                                      |      
|      set-y!: -------> <procedure definition>       |
|            <-----------------|                     |
|             |                                      |
|      dispatch: -------> <procedure defintion> <----|
|          <---------------------|
|_____________|




After `(define z (cons x x))`:

| global frame |
|              |
|     x: ----------------------------------------------|
|     z: ---------------------------------------------------|
|______________|                                       |    |
^       ^                                              |    |
|       |                                              |    |
| | cons frame 1|                                      |    |
| |      x: 1   |                                      |    |
| |      y: 2   |                                      |    |
| |      set-x!: -------> <procedure deinition>        |    |
| |            <----------------|                      |    |
| |             |                                      |    | 
| |      set-y!: -------> <procedure definition>       |    |
| |            <-----------------|                     |    |
| |             |                                      |    |
| |      dispatch: -------> <procedure defintion> <----|    |
| |          <---------------------|    ^  ^                |
| |_____________|                       |  |                |
|                                       |  |                |
|                                       |  |                |
| | cons frame 2|                       |  |                |
|-|      x: -----------------------------  |                |
  |      y: --------------------------------                |
  |             |                                           |
  |      set-x!: -------> <procedure deinition>             |
  |            <----------------|                           |
  |             |                                           |
  |      set-y!: -------> <procedure definition>            |
  |            <-----------------|                          |
  |             |                                           |
  |      dispatch: -------> <procedure defintion> <---------|
  |          <---------------------|
  |_____________|



After `(set-car! (cdr z) 17)` (hold on):

| global frame |
|              |
|     x: ----------------------------------------------|
|     z: ---------------------------------------------------|
|______________|                                       |    |
^     ^                                                |    |
|     |                                                |    |
| | cons frame 1|                                      |    |
| |      x: 17  |                                      |    |
| |      y: 2   |                                      |    |
| |      set-x!: -------> <procedure deinition>        |    |
| |            <----------------|                      |    |
| |             |                                      |    | 
| |      set-y!: -------> <procedure definition>       |    |
| |            <-----------------|                     |    |
| |             |                                      |    |
| |      dispatch: -------> <procedure defintion> <----|    |
| |          <---------------------|    ^  ^   ^            |
| |____________^|                       |  |   |            |
|              |--------------|         |  |   |            |
|                             |         |  |   |------|     |
| | cons frame 2|             |         |  |          |     |
|-|      x: -----------------------------  |          |     |
| |      y: --------------------------------          |     |
| |             |             |                       |     |
| |      set-x!: -------> <procedure deinition>       |     |
| |            <----------------|                     |     |
| |             |             |                       |     |
| |      set-y!: -------> <procedure definition>      |     |
| |            <-----------------|                    |     |
| |             |             |                       |     |
| |      dispatch: -------> <procedure defintion> <---------|
| |          <---------------------|     ^            |
| |____________<----|         |          |            |
|                   |         |          |            |
|-|  cdr frame |    |         |          |            |
| |     z: ------------------------------|            |
| |____________|    |         |                       |
|                   |         |                       |
|  |  z1 frame    |-|         |                       |
|  |     m: 'cdr  |           |                       |
|  |______________|           |                       |
|                             |                       |
|-|  set-car! frame   |       |                       |
  |     z: -------------------------------------------|
  |     new-value: 17 |       |
  |___________________|       |
                              |
  |   z2 frame      |----------
  |    m: 'set-cdr  |
  |_________________|


And finally `(car x)`:

| global frame |
|              |
|     x: ----------------------------------------------|
|     z: ---------------------------------------------------|
|______________|                                       |    |
^       ^                                              |    |
|       |                                              |    |
| | cons frame 1|                                      |    |
| |      x: 17  |                                      |    |
| |      y: 2   |                                      |    |
| |      set-x!: -------> <procedure deinition>        |    |
| |            <----------------|                      |    |
| |             |                                      |    | 
| |      set-y!: -------> <procedure definition>       |    |
| |            <-----------------|                     |    |
| |             |                                      |    |
| |      dispatch: -------> <procedure defintion> <----|    |
| |          <---------------------|    ^  ^   ^            |
| |____________^|                       |  |   |            |
|              |------|                 |  |   |            |
|                     |                 |  |   |            |
| | cons frame 2|     |                 |  |   |----|       |
|-|      x: -----------------------------  |        |       |
| |      y: --------------------------------        |       |
| |             |     |                             |       |
| |      set-x!: -------> <procedure deinition>     |       |
| |            <----------------|                   |       |
| |             |     |                             |       |
| |      set-y!: -------> <procedure definition>    |       |
| |            <-----------------|                  |       |
| |             |     |                             |       |
| |      dispatch: -------> <procedure defintion> <---------|
| |          <---------------------|                |
| |_____________|     |                             |
|                     |                             |
|-|   car frame  |    |                             |
  |      z: ----------------------------------------|
  |______________|    |
                      |
  |   z frame    |-----
  |     m: 'car  |
"