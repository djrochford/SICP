;Exercise 3.62.  Use the results of exercises 3.60 and 3.61 to define a procedure `div-series`
;that divides two power series. `div-series` should work for any two series, provided that the
;denominator series begins with a nonzero constant term. (If the denominator has a zero constant
;term, then div-series should signal an error.)

(define (div-series num denom)
		(let (scale (stream-car denom))
			 (if (= 0 scale?)
			 	 (error "Denominator has 0 constant term -- DIV-SERIES")
			     (mul-series num 
			     			(scale-stream (invert-unit-series (scale-stream denom (/ 1 scale)))
			     							   scale)))))

;Show how to use div-series together with the result of exercise 3.59 to generate the power series
;for tangent.

(define tangent-series (div-series sine-series cosine-series))