;Exercise 4.66.  Ben has been generalizing the query system to provide statistics about
;the company. For example, to find the total salaries of all the computer programmers
;one will be able to say

(sum ?amount
     (and (job ?x (computer programmer))
          (salary ?x ?amount)))

;In general, Ben's new system allows expressions of the form

(accumulation-function <variable>
                       <query pattern>)

;where `accumulation-function` can be things like `sum`, `average`, or `maximum`.
;Ben reasons that it should be a cinch to implement this. He will simply feed the
;query pattern to `qeval`. This will produce a stream of frames. He will then pass
;this stream through a mapping function that extracts the value of the designated
;variable from each frame in the stream and feed the resulting stream of values to
;the accumulation function. Just as Ben completes the implementation and is about
;to try it out, Cy walks by, still puzzling over the wheel query result in exercise
;4.65. When Cy shows Ben the system's response, Ben groans, "Oh, no, my simple
;accumulation scheme won't work!""

;What has Ben just realized?
"Ben has just realised that there are cases (like Cy's) in which there is more than one
output frame per entry relevant to the query. In cases like that, the input ot the accumulation-
function in Ben's scheme will include more than one frame per relevant entry, and the
accumulation-function will double count some values."

;Outline a method he can use to salvage the situation.
"Ben needs a way of de-duping frames. He can check that the bindings of the frames for the variables
that appear in the query pattern, and throw out frames that duplicate previously seen bindings
before passing the input to the accumulation-function. This is probably something the system should do anyway."