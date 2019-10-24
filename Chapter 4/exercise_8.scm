;Exercise 4.8.  ``Named let'' is a variant of let that has the form

(let <var> <bindings> <body>)

;The <bindings> and <body> are just as in ordinary let, except that <var> is bound
;within <body> to a procedure whose body is <body> and whose parameters are the
;variables in the <bindings>. Thus, one can repeatedly execute the <body> by invoking
;the procedure named <var>. For example, the iterative Fibonacci procedure
;(section 1.2.2) can be rewritten using named let as follows:

(define (fib n)
        (let fib-iter 
             ((a 1) (b 0) (count n))
             (if (= count 0)
                 b
                 (fib-iter (+ a b) a (- count 1)))))

;Modify let->combination of exercise 4.6 to also support named let.

"Here are some helper procedures for dealing with `let`s:"
(define (let? exp) (tagged-list? exp 'let))
(define (named-let? exp) (not (pair? (cadr exp))))
(define (let-bindings exp)
        (if (named-let? exp)
            (caddr exp)
            (cadr exp)))
(define (let-body exp)
        (if (named-let? exp)
            (cdddr exp)
            (caddr exp)))

(define (let-variables bindings) (map car bindings))
(define (let-values bindings (map cdr bindings)))

(define (let-expressions bindings) (map cdr bindings))
(define (let-name exp) 
        (if (named-let? exp)
            (cadr exp)
            (error "Attempted to get name from non-named let expression -- LET-NAME")))

"And now the definition of `let->combination`:"

(define (named-let->combination exp)
        (make-begin (list 'define 
                          (let-name exp)
                          (make-lambda (let-variables (let-bindings exp))
                                       (let-body exp)))
                    (cons (let-name exp) (let-values (let-bindings exp)))))

(define (let->combination exp)
        (if (named-let? exp)
            (named-let->combination exp)
            (cons (make-lambda (let-variables (let-bindings exp))
                               (let-body exp))
                  (let-expressions (let-bindings exp)))))