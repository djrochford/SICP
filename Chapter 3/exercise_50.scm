;Exercise 3.50.  Complete the following definition, which generalizes `stream-map`
;to allow procedures that take multiple arguments, analogous to `map` in section 2.2.3,
;footnote 12.

(define (stream-map proc . argstreams)
        (if (<??> (car argstreams))
            the-empty-stream
            (<??> (apply proc (map <??> argstreams))
                  (apply stream-map
                         (cons proc (map <??> argstreams))))))

"Here is my completion:"

(define (stream-map proc . argstreams)
        (if (null? (car argstreams))
            the-empty-stream
            (cons-stream (apply proc (map stream-car argstreams))
                         (apply stream-map
                                (cons proc (map stream-cdr argstreams))))))
