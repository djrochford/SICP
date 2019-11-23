;Exercise 4.23.  Alyssa P. Hacker doesn't understand why `analyze-sequence` needs
;to be so complicated. All the other analysis procedures are straightforward
;transformations of the corresponding evaluation procedures (or eval clauses) in
;section 4.1.1. She expected analyze-sequence to look like this:

(define (analyze-sequence exps)
        (define (execute-sequence procs env)
                (cond ((null? (cdr procs)) ((car procs) env))
                      (else ((car procs) env)
                            (execute-sequence (cdr procs) env))))
        (let ((procs (map analyze exps)))
             (if (null? procs)
                 (error "Empty sequence -- ANALYZE"))
             (lambda (env) (execute-sequence procs env))))

;Eva Lu Ator explains to Alyssa that the version in the text does more of the work
;of evaluating a sequence at analysis time. Alyssa's `sequence-execution` procedure,
;rather than having the calls to the individual execution procedures built in, loops
;through the procedures in order to call them: In effect, although the individual
;expressions in the sequence have been analyzed, the sequence itself has not been.

;Compare the two versions of `analyze-sequence`. For example, consider the common case
;(typical of procedure bodies) where the sequence has just one expression. What work
;will the execution procedure produced by Alyssa's program do?

"Alyssa's program in general returns a procedure that loops through a list of
procedures and executes them; in the case of a single-sequence expression, that
list will be a singleton list, and that one element will be executed."

;What about the execution procedure produced by the program in the text above?

"For reference, the execution procedure in the text is:"

(define (analyze-sequence exps)
        (define (sequentially proc1 proc2)
                (lambda (env) (proc1 env) (proc2 env)))
        (define (loop first-proc rest-procs)
                (if (null? rest-procs)
                    first-proc
                    (loop (sequentially first-proc (car rest-procs))
                          (cdr rest-procs))))
        (let ((procs (map analyze exps)))
             (if (null? procs)
                 (error "Empty sequence -- ANALYZE"))
             (loop (car procs) (cdr procs))))

"This program will return the single procedure that appears as a singleton in the
list the Alyssa's program loops through."

;How do the two versions compare for a sequence with two expressions?

"In this case, Alyssa's program returns a procedure that loops over a list
containing two procedures an executes them; the program above returns
a procedure that executes a procedure that executes the first procedure,
then the second procedure.

It's not clear to me the text-program procedure is better than Alyssa's procedure,
in this case."
