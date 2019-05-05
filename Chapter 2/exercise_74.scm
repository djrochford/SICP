;Exercise 2.74.  Insatiable Enterprises, Inc., is a highly decentralized conglomerate
;company consisting of a large number of independent divisions located all over the world.
;The company's computer facilities have just been interconnected by means of a clever
;network-interfacing scheme that makes the entire network appear to any user to be a single
;computer. Insatiable's president, in her first attempt to exploit the ability of the network
;to extract administrative information from division files, is dismayed to discover that,
;although all the division files have been implemented as data structures in Scheme, the 
;particular data structure used varies from division to division. A meeting of division managers
;is hastily called to search for a strategy to integrate the files that will satisfy
;headquarters' needs while preserving the existing autonomy of the divisions.

;Show how such a strategy can be implemented with data-directed programming. As an example, 
;suppose that each division's personnel records consist of a single file, which contains a set
;of records keyed on employees' names. The structure of the set varies from division to division.
;Furthermore, each employee's record is itself a set (structured differently from division to
;division) that contains information keyed under identifiers such as address and salary.
;In particular:

;a.  Implement for headquarters a `get-record` procedure that retrieves a specified employee's
;record from a specified personnel file. The procedure should be applicable to any division's
;file. Explain how the individual divisions' files should be structured. In particular, what
;type information must be supplied?

"
Let us assume that we have table, the rows of which are department names, the columns of which are procedure names.
We'll have a `get-record` coulumn, from which we can look up a procedure which will retrive the record
from the given departments personnel file, whatever their data structure that holds those records.

Those personnel files will need to be tags to indicate their department, which we can think of as their data-type.
We'll assume we have `tag` and `data` procedures, which recover the tag and the non-tag parts of the personnel file.

The generic `get-record` procedure will just retrive the appropriate department `get-record` procedure, using the personnel
file's type tag, and apply it to the personnel file's data and employee-name parameters. It will also apply a tag to the retrieved
record, so that other procedures that work on records know what data-type they're dealing with. It'll look something like this:
"
(define (get-record personnel-file employee-name)
        (let ((record ((get 'get-record (tag personnel-file)) (data personnel-file)
                                                              employee-name)))
             (if record
                 (attach-tag (tag personnel-file) record)
                 #f)))

;b.  Implement for headquarters a `get-salary` procedure that returns the salary information from a given employee's record
;from any division's personnel file. How should the record be structured in order to make this operation work?

"
Our procedure will take a tagged record (retrieved via `get-record`, presumably), use the tag to look up the relevant `get-salary`
method from our table, and apply that to the non-tag part of the record (which we'll call the 'data').
"
(define (get-salary record)
        ((get 'get-salary (department-tag record))
         (data record))) 


;c.  Implement for headquarters a `find-employee-record` procedure. This should search all the divisions' files 
;for the record of a given employee and return the record. Assume that this procedure takes as arguments an
;employee's name and a list of all the divisions' files.

(define (find-employee-record employee-name personnel-files)
        (if (null? personnel-files)
            #f
            (let ((record (get-record (car personnel-files) employee-name)))
                 (if record)
                     record
                     (find-employee-record employee-name (cdr personnel-files))

;d.  When Insatiable takes over a new company, what changes must be made in order to incorporate the new personnel
;information into the central system?

"
The new personnel files must be tagged appropriately, and new `get-record` and `get-salary` procedures must be installed
in the table.
"