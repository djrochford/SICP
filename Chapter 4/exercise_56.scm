;Exercise 4.56.  Formulate compound queries that retrieve the following information:

;a. the names of all people who are supervised by Ben Bitdiddle, together with their addresses;

(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?place))

;b. all people whose salary is less than Ben Bitdiddle's, together with their salary and Ben Bitdiddle's salary;

(and (salary (Bitdiddle Ben) ?ben-salary)
     (salary ?person ?person-salary)
     (lisp-value < ?person-salary ?ben-salary))

;c. all people who are supervised by someone who is not in the computer division, together with the supervisor's name and job.

(and (supervisor ?supervisee ?boss)
     (not (job ?boss (computer . ?job-type)))
     (job ?boss ?boss-job))