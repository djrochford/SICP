;Exercise 3.36.  Suppose we evaluate the following sequence of expressions in the global environment:

(define a (make-connector))
(define b (make-connector))
(set-value! a 10 'user)

;At some time during evaluation of the set-value!, the following expression from the connector's local
;procedure is evaluated:

(for-each-except setter inform-about-value constraints)

;Draw an environment diagram showing the environment in which the above expression is evaluated.

"
| Global frame     |
|   make-connector:----------><procedure object>
|			     <--------------------|
|				   |
|	a:-----------------------------------------------------------	
|			       |										    |	
|	b:--------------------------------------------------------------|
|------------------|										    |	|
		^														|	|
		|														|	|
| first make-connector frame |									|	|
|   value: 10		         |									|	|
|   informant: 'user		 |									|	|
|   constraints: null		 |									|	|
|	set-my-value:-------------------><procedure object>			|	|
|						<--------------------|					|	|
|							 |									|	|
|   forget-my-value:----------------><procedure object>			|	|
|                       <--------------------|					|	|
|							 |									|	|
|   connect:------------------------><prcoedure object>			|	|
|						<--------------------|					|	|
|  							 |									|	|
|   me:-----------------------------><procedure object><--------|	|
|						<---------------------|						|
-----------------------------|										|
																	|
| second make-connector frame |										|
|   value: false		     |										|
|   informant: false		 |										|
|   constraints: null		 |										|
|	set-my-value:-------------------><procedure object>				|
|						<--------------------|						|
|							 |										|
|   forget-my-value:----------------><procedure object>				|
|                       <--------------------|						|
|							 |										|
|   connect:------------------------><prcoedure object>				|
|						<--------------------|						|
|  							 |										|
|   me:-----------------------------><procedure object><------------|
|						<---------------------|
-----------------------------|
"