;Exercise 3.49.  Give a scenario where the deadlock-avoidance mechanism described above
;does not work. (Hint: In the exchange problem, each process knows in advance which
;accounts it will need to get access to. Consider a situation where a process must get
;access to some shared resources before it can know which additional shared resources it
;will require.)

"Any process in which the order in which resources are accessed is not negotiable is a
process in which the above describe deadlock-avoidance mechanism will not work. Processes
in which you have to access one resource to know which resource to access next are just
one example of this -- you *have* to access the resource which tells you what to do next
first. That being so, a process which had to access account A to discover that it next
had to access account B, and a process that had to access account B to discover that it
next had to access account A, could not avoid deadlock with the above described deadlock-
avoidance mechanism."