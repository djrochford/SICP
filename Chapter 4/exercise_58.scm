;Exercise 4.58.  Define a rule that says that a person is a ``big shot'' in a division
;if the person works in the division but does not have a supervisor who works in the division.

(rule (big-shot ?person ?division)
      (and (job ?person (?division . ?person-role))
           (or (not (supervisor ?person ?boss))
               (and (supervisor ?person ?boss)
                    (not (job ?boss (?division . ?boss-role)))))))