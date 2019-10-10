;Exercise 3.80.  A series RLC circuit consists of a resistor, a capacitor, and an
;inductor connected in series, as shown in figure 3.36. If R, L, and C are the resistance,
;inductance, and capacitance, then the relations between voltage (v) and current (i)
;for the three components are described by the equations

; v_R = i_R * R

; v_L = L di_L/dt

; i_C = C dv_C/dt

;and the circuit connections dictate the relations

; i_R = i_L = -i_C

; v_C = v_L + v_R

;Combining these equations shows that the state of the circuit (summarized by v_C,
;the voltage across the capacitor, and i_L, the current in the inductor) is described
;by the pair of differential equations

; dv_C/dt = -i_L/C

; di_L/dt = 1/L * v_C - R/L * i_L


;The signal-flow diagram representing this system of differential equations is shown in
;figure 3.37.


;Figure 3.36:  A series RLC circuit.


;Figure 3.37:  A signal-flow diagram for the solution to a series RLC circuit.

;Write a procedure `RLC` that takes as arguments the parameters R, L, and C of the circuit
;and the time increment dt. In a manner similar to that of the `RC` procedure of exercise 3.73,
;RLC should produce a procedure that takes the initial values of the state variables,
;v_C_0 and i_L_0, and produces a pair (using cons) of the streams of states v_C and i_L.

(define (RLC R L C dt)
        (define v_C (integral (delay dv_C))

;Using `RLC`, generate the pair of streams that models the behavior of a series RLC circuit
;with R = 1 ohm, C = 0.2 farad, L = 1 henry, dt = 0.1 second, and initial values iL0 = 0 amps
;and vC0 = 10 volts.

