;Exercise 2.66.  Implement the lookup procedure for the case where 
;the set of records is structured as a binary tree, ordered by 
;the numerical values of the keys.

(define (lookup given-key set-of-records)
        (if (null? set-of-records) 
            '()
            (let* ((current-record (entry set-of-records))
                   (record-key (key current-record)))
                  (cond ((= given-key record-key) current-record)
                        ((< given-key record-key) (lookup given-key 
                                                          (left-branch set-of-records)))
                        ((> given-key record-key) (lookup given-key
                                                          (right-branch set-of-records)))))))

