;Exercise 1.13.  Prove that Fib(n) is the closest integer to phi^n/sqrt(5), where phi = (1 + sqrt(5))/2. Hint: Let psi = (1 - sqrt(5))/2. Use induction and the definition of the Fibonacci numbers (see section 1.2.2) to prove that Fib(n) = (phi^n - psi^n)/sqrt(5).

"Lemma: Fib(n) = (phi^n - psi^n)/sqrt(5), where phi = (1 + sqrt(5))/2, psi = (1 - sqrt(5))/2

Proof: Three cases: n = 0, n = 1, and the rest.

If n = 0, then Fib(n) = 0 (by definition), and (phi^n - psi^n)/sqrt(5) = (1-1)/sqrt(5) = 0, so the lemma is true when n = 0.

If n = 1, then Fib(n) = 1 (by definition), and (phi^n - psi^n)/sqrt(5) = (phi - psi)/sqrt(5)
  = ((1+sqrt(5)-1+sqrt(5)/2)/sqrt(5)
  = sqrt(5)/sqrt(5)
  = 1
So the lemma is true when n= 1

Now, suppose it were true for case k and case k+1.
Then Fib(k) = (phi^k - psi^k)/sqrt(5), and Fib(k+1) = (phi^(k+1) - psi^(k+1))/sqrt(5)
By definition, Fib(k+2) = Fib(k+1) + Fib(k)
  = (phi^k - psi^k)/sqrt(5) + (phi^(k+1) - psi^(k+1))/sqrt(5)
  = (phi^k + phi^(k+1) - psi^k - psi^(k+1))/sqrt(5)
  = (phi^k (1 + phi) - psi^k (1 + psi))/sqrt(5)
  numerator = phi^k * (3 + sqrt(5))/2 - psi^k * (3 - sqrt(5))/2
  = phi^k * (6 + 2*sqrt(5))/4 - psi^k * (6 - 2*sqrt(5))/4
  = phi^k * ((1 + 2*sqrt(5) + 5)/4) - psi^k * (1 - 2*sqrt(5) + 5)/4
  = phi^k * (1 + sqrt(5))^2 - psi^k * (1 - sqrt(5))^2
  = phi^k + phi^2 - psi^k * psi^2
  = phi^(k+2) - psi^(k+2)
So if Fib(k) = (phi^k - psi^k)/sqrt(5), and Fib(k+1) = (phi^(k+1) - psi^(k+1))/sqrt(5), then
Fib(k+2) = (phi^(k+2) - psi^(k+2))/sqrt(5) -- i.e., if the lemma is true for n = k, n = k+1, it is true for n = k+2

The lemma *is* true for n = 0 and n = 1, so it is true for n = 2, n = 3 and indeed all finite n.

Corollary: Fib(n) is the closest integer to phi^n/sqrt(5).
Proof: Fib(n) = (phi^n - psi^n)/sqrt(5). So the difference between Fib(n) and phi^n/sqrt(5) is
phi^n/sqrt(5) - (phi^n - psi^n)/sqrt(5) = psi^n/sqrt(5)
Now, psi = -0.61803398875, so psi^n/sqrt(5) is less than 0.5 for all integer values of n.
So the difference between Fib(n) and phi^n/sqrt(5) is less than 0.5 for all values of n.
So Fib(n) is the closest integer to phi^n/sqrt(5) for all values of n.