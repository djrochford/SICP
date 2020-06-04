;Exercise 4.55.  Give simple queries that retrieve the following information from the data base:

;a. all people supervised by Ben Bitdiddle;

(supervised ?supervisee (Bitdiddle Ben))

;b. the names and jobs of all people in the accounting division;

(job ?name (accounting . ?role))

;c. the names and addresses of all people who live in Slumerville.

(address ?name (Slumerville . ?address))