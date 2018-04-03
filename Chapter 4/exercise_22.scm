(define (analyze-let exp)
        (analyze-lambda (let->combination exp)))