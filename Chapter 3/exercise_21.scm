;Exercise 3.21.  Ben Bitdiddle decides to test the queue implementation described above.
;He types in the procedures to the Lisp interpreter and proceeds to try them out:

(define q1 (make-queue))

(insert-queue! q1 'a)
;((a) a)

(insert-queue! q1 'b)
;((a b) b)

(delete-queue! q1)
;((b) b)

(delete-queue! q1)
;(() b)

;"It's all wrong!"" he complains. "The interpreter's response shows that the last item is
;inserted into the queue twice. And when I delete both items, the second b is still there,
;so the queue isn't empty, even though it's supposed to be.'' Eva Lu Ator suggests that Ben
;has misunderstood what is happening. "It's not that the items are going into the queue
;twice,"" she explains. "It's just that the standard Lisp printer doesn't know how to make
;sense of the queue representation. If you want to see the queue printed correctly, you'll
;have to define your own print procedure for queues." Explain what Eva Lu is talking about.
;In particular, show why Ben's examples produce the printed results that they do.

"A queue, as we implement it, is made up of a list that contains the contents of the queue,
and a a pair of pointers -- one that points to the initial pair of the list, and one that points
to the final pair. The thing named by `q1` above is the pair of pointers, not the list that
holds the contents. So what the printer is showing is what each pointer is pointing at,
not (merely) the contents of the queue.

The front pointer points at the head of the list that holds the queue's contents, so the
printer will always show a list with the entirety of the queue's contents as the first
element of the top-level list it prints. The rear pointer points to the final pair, and
so the printer will show the final element of the queue as the second member of the
top-level list it prints.

That is clearly the case in all of the above examples except the last one, which is a special
case, to do with an implementation detail. As implemented, when a queue has a single element
in it, and we delete that element, the rear-pointer is left pointing to the deleted element;
that's the `b` appears as the second item of the printed list in the last case."

;Define a
;procedure `print-queue` that takes a queue as input and prints the sequence of items in the
;queue.

(define (print-queue queue) (display (car queue)))