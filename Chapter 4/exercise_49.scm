;Exercise 4.49.  Alyssa P. Hacker is more interested in generating interesting sentences than
;in parsing them. She reasons that by simply changing the procedure `parse-word` so that it ignores the
;"input sentence" and instead always succeeds and generates an appropriate word, we can use the programs
;we had built for parsing to do generation instead. Implement Alyssa's idea, and show the first
;half-dozen or so sentences generated.

"Here's the original `parse-word` for reference:"
(define (parse-word word-list)
        (require (not (null? *unparsed*)))
        (require (memq (car *unparsed*) (cdr word-list)))
        (let ((found-word (car *unparsed*)))
             (set! *unparsed* (cdr *unparsed*))
             (list (car word-list) found-word)))

"Here is a version that doesn't use *unparsed* at all:"

(define (parse-word word-list)
        (require (not (null? word-list)))
        (amb (car word-list)
             (parse-word (cdr word-list))))



