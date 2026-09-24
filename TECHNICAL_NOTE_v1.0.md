# Square Content in Primitive Pythagorean Composition

**Technical note — v1.0**
**Ivan Nestorov, VolMax Studio Lab**  
**September 2026**

> Status: Final exposition candidate, prepared with AI assistance under
> Ivan Nestorov's direction. Human ratification is pending.
>
> This note explains already frozen Lean 4 results. It does not extend the
> theorem scope or make a claim of mathematical novelty or priority.

---

## 1. Setup

Define

\[
\operatorname{PrimitiveRightTriangle}(a,b,m)
\]

by

\[
a^2+b^2=m^2,
\qquad
\gcd(a,b)=1.
\]

Let

\[
a^2+b^2=m^2,\qquad \gcd(a,b)=1,
\]

and

\[
c^2+d^2=n^2,\qquad \gcd(c,d)=1.
\]

Define

\[
x=ac-bd,
\qquad
y=ad+bc,
\]

so that

\[
(a+bi)(c+di)=x+yi.
\]

Finally put

\[
q=\gcd(m,n).
\]

The formal statements are over the integers. No positivity or orientation
hypothesis is imposed.

The product norm satisfies

\[
x^2+y^2
=
(a^2+b^2)(c^2+d^2)
=
(mn)^2.
\]

The quantity studied below is the common content

\[
\gcd(x,y).
\]

---

## 2. Rung A: the gcd identity

### Theorem A

Under the hypotheses above,

\[
\boxed{
\gcd(x,y)=\gcd(y,q^2)
}.
\]

The corresponding Lean theorem is

```text
primitive_composition_gcd_identity
```

in `PrimitiveTripleFilter.lean`.

### Proof structure

Let

\[
g=\gcd(x,y).
\]

Then

\[
g\mid x
\qquad\text{and}\qquad
g\mid y.
\]

From

\[
x=ac-bd,
\qquad
y=ad+bc,
\]

one obtains

\[
cx+dy
=
a(c^2+d^2)
=
an^2
\]

and

\[
cy-dx
=
b(c^2+d^2)
=
bn^2.
\]

Therefore

\[
g\mid an^2
\qquad\text{and}\qquad
g\mid bn^2.
\]

Because

\[
\gcd(a,b)=1,
\]

a Bézout combination gives

\[
g\mid n^2.
\]

By the symmetric argument,

\[
g\mid m^2.
\]

The formal helper lemma `div_gcd_sq_of_div_squares` then establishes

\[
g\mid \gcd(m,n)^2=q^2.
\]

Since also \(g\mid y\),

\[
g\mid\gcd(y,q^2).
\]

For the reverse divisibility, let

\[
h=\gcd(y,q^2).
\]

Then

\[
h\mid y
\qquad\text{and}\qquad
h\mid q^2.
\]

Since \(q\mid m\) and \(q\mid n\),

\[
q^2\mid mn,
\]

hence \(h\mid mn\). Therefore

\[
h^2\mid(mn)^2
\qquad\text{and}\qquad
h^2\mid y^2.
\]

Using

\[
x^2+y^2=(mn)^2,
\]

we obtain

\[
h^2\mid x^2.
\]

The formal proof then uses the integral-domain/UFD divisibility implication

\[
h^2\mid x^2\Longrightarrow h\mid x.
\]

Thus

\[
h\mid x
\qquad\text{and}\qquad
h\mid y,
\]

so

\[
h\mid\gcd(x,y).
\]

Together with the first divisibility,

\[
\boxed{
\gcd(x,y)=\gcd(y,q^2)
}.
\]

---

## 3. Primitive-composition criterion

The A artifact also proves

\[
\boxed{
\gcd(x,y)=1
\iff
\gcd(y\bmod q,q)=1
}.
\]

The corresponding Lean theorem is

```text
primitive_filter_criterion
```

with \(q=\gcd(m,n)\).

Thus, within the stated Pythagorean domain, primitivity of the composed
coordinate pair is characterized by \(y\) and \(q\).

This is an exact arithmetic criterion. No performance claim is attached to it.

---

## 4. Oddness of the primitive hypotenuse

The B artifact proves

\[
\operatorname{PrimitiveRightTriangle}(a,b,m)
\Longrightarrow
\operatorname{Odd}(m).
\]

The Lean theorem is

```text
primitiveRightTriangle_hypotenuse_odd
```

Parity is derived from the primitive-triple hypotheses and is not an additional
input assumption.

Consequently, if a prime \(p\) divides

\[
q=\gcd(m,n),
\]

then \(p\neq2\).

---

## 5. Local all-or-nothing theorem

Let \(p\) be prime, let \(e>0\), and suppose

\[
p^e\mid q.
\]

Then the B artifact proves

\[
\boxed{
p\nmid y
\quad\lor\quad
p^{2e}\mid y
}.
\]

The Lean theorem is

```text
primitive_composition_local_all_or_nothing
```

and its conclusion is literal divisibility in \(\mathbb Z\).

There is no separate assumption of:

- \(p\neq2\);
- odd \(p\);
- square-free \(q\);
- positivity or orientation;
- \(y\neq0\).

### Proof

Since

\[
p^e\mid q,
\]

and \(q\mid m,n\),

\[
p^e\mid m
\qquad\text{and}\qquad
p^e\mid n.
\]

Hence

\[
p^{2e}\mid m^2
\qquad\text{and}\qquad
p^{2e}\mid n^2.
\]

Define

\[
z=ad-bc.
\]

Then

\[
\begin{aligned}
yz
&=(ad+bc)(ad-bc)\\
&=a^2d^2-b^2c^2\\
&=(a^2+b^2)d^2-b^2(c^2+d^2)\\
&=m^2d^2-b^2n^2.
\end{aligned}
\]

Therefore

\[
\boxed{
p^{2e}\mid yz
}.
\]

Now suppose

\[
p\mid y.
\]

Because \(p\mid m\), primitivity of the first triple implies

\[
p\nmid a.
\]

Otherwise \(p\mid a\), together with

\[
b^2=m^2-a^2,
\]

would imply \(p\mid b\), contradicting \(\gcd(a,b)=1\).

Applying the same argument to the second triple with its two legs exchanged
gives

\[
p\nmid d.
\]

The primitive hypotenuse \(m\) is odd, so

\[
p\neq2.
\]

Therefore

\[
p\nmid2ad.
\]

But

\[
y+z
=
(ad+bc)+(ad-bc)
=
2ad.
\]

Thus \(p\) cannot divide both \(y\) and \(z\). Since \(p\mid y\),

\[
p\nmid z.
\]

We already know

\[
p^{2e}\mid yz.
\]

Because \(p\nmid z\), the full factor \(p^{2e}\) must divide \(y\):

\[
p^{2e}\mid y.
\]

Hence

\[
\boxed{
p\nmid y
\quad\lor\quad
p^{2e}\mid y
}.
\]

---

## 6. Rung B: square content

### Theorem B

Under exactly the same eight integer parameters and the same four hypotheses
as Theorem A,

\[
\boxed{
\gcd(x,y)=\gcd(y,q)^2
}.
\]

The Lean theorem is

```text
primitive_composition_gcd_eq_sq
```

in `PrimitiveCompositionSquareContent.lean`.

### Derivation

Theorem A gives

\[
\gcd(x,y)=\gcd(y,q^2).
\]

It remains to establish

\[
\gcd(y,q^2)=\gcd(y,q)^2.
\]

The formal proof performs this comparison prime by prime using natural-number
factorizations.

Let \(p\) be a prime occurring in \(q\), with exact exponent

\[
e=v_p(q)>0.
\]

The local theorem gives two cases.

If

\[
p\nmid y,
\]

then \(p\) occurs in neither \(\gcd(y,q)\) nor \(\gcd(y,q^2)\).

If

\[
p\mid y,
\]

the local theorem applied to the complete block \(p^e\mid q\) gives

\[
p^{2e}\mid y.
\]

Therefore the exponent of \(p\) in \(\gcd(y,q)\) is \(e\), while the exponent
of \(p\) in \(\gcd(y,q^2)\) is \(2e\).

Thus, for every prime \(p\),

\[
v_p(\gcd(y,q^2))
=
2\,v_p(\gcd(y,q)).
\]

Consequently,

\[
\gcd(y,q^2)=\gcd(y,q)^2.
\]

Combining this with Theorem A yields

\[
\boxed{
\gcd(x,y)=\gcd(y,q)^2
}.
\]

---

## 7. Perfect-square corollary

The B artifact separately exposes the consequence

\[
\boxed{
\gcd(x,y)\text{ is a perfect square}.
}
\]

The Lean theorem is

```text
primitive_composition_gcd_isSquare
```

This statement is restricted to the Pythagorean domain above.

The artifact does not assert the corresponding statement for arbitrary
primitive Gaussian pairs whose norms are not required to be squares.

---

## 8. Arithmetic corollary

Let

\[
r=\gcd(y\bmod q,q).
\]

Using the standard gcd remainder identity,

\[
\gcd(y\bmod q,q)=\gcd(y,q).
\]

Therefore Theorem B gives

\[
\boxed{
\gcd(x,y)=r^2
}.
\]

In particular,

\[
r=1
\iff
\gcd(x,y)=1.
\]

This is an arithmetic consequence of the verified identities.

It is not presented as a performance result.

---

## 9. The case \(y=0\)

The formal theorem does not assume

\[
y\neq0.
\]

`YZeroTest.lean` checks the complete-cancellation example

\[
(3+4i)(3-4i)=25+0i.
\]

For this example,

\[
m=n=5,
\qquad
x=25,
\qquad
y=0,
\]

and the square-content theorem gives

\[
\gcd(25,0)
=
\gcd(0,5)^2
=
25.
\]

The same test file also applies the local all-or-nothing theorem directly to
the zero imaginary coordinate.

---

## 10. Formal statement guards

`SignatureAudit.lean` guards three central public signatures:

```text
primitive_composition_gcd_identity
primitive_composition_gcd_eq_sq
primitive_composition_local_all_or_nothing
```

In particular, it checks that Theorem A and Theorem B have the same eight
integer parameters and the same four hypotheses; only their conclusions differ.

The local theorem is separately guarded in its literal integer-divisibility
form.

---

## 11. Axiom audit

`AxiomAudit.lean` checks all public A and B theorems:

```text
primitive_composition_gcd_identity
primitive_filter_criterion
primitiveRightTriangle_hypotenuse_odd
primitive_composition_local_all_or_nothing
primitive_composition_gcd_eq_sq
primitive_composition_gcd_isSquare
```

For each of them, the recorded dependency list is

```text
[propext, Classical.choice, Quot.sound]
```

No additional declared axiom is part of the frozen proof artifact.

---

## 12. Reproduction

The B verifier performs the following checks:

1. verifies the frozen SHA-256 of the imported A theorem source;
2. verifies the pinned Mathlib revision;
3. verifies `SHA256SUMS`;
4. rejects `sorry`, `native_decide`, and newly declared raw `axiom` tokens in
   the B proof/audit files;
5. builds `PrimitiveTripleFilter`;
6. builds `PrimitiveCompositionSquareContent`;
7. executes `YZeroTest.lean`;
8. executes `SignatureAudit.lean`;
9. executes `AxiomAudit.lean`;
10. verifies `SHA256SUMS` again after execution.

The successful verifier terminates with

```text
PASS: primitive-composition-square-content-s1
```

---

## 13. Pinned formal environment

```text
Lean version:
v4.34.0

Lean commit:
293d5d0c0c3f3dded4688b3ccd6a33939ac5102b

Mathlib version:
v4.34.0

Mathlib commit:
5ed2965256430c3649e86755f9576b54eca72435
```

Frozen A theorem source SHA-256:

```text
5b97b0a5eea88415f98783443c4f15fc3b4d1030fd3b0e99826110795a0216f5
```

---

## 14. Public artifact

Canonical archived bundle:

```text
Formal verification artifacts for primitive Pythagorean composition:
gcd identity and square-content theorem

Ivan Nestorov
VolMax Studio Lab
Version 1.0.0
Zenodo record 22940155
DOI: 10.5281/zenodo.22940155
```

Public record:

https://zenodo.org/records/22940155

The frozen publication bundle contains both Rung A and Rung B proof artifacts.

---

## 15. Scope

The formally verified claims in this note are the mathematical statements
specified above.

This note makes no claim of:

- mathematical novelty or priority;
- computational speedup;
- equivalence with integer factorization;
- RSA consequences;
- cryptographic security consequences.

Literature novelty is outside the scope of the Lean proof artifact itself.

Kernel checking establishes derivability of the encoded statements from the
formal dependencies. Attribution, exposition, significance, and publication
conduct remain human responsibilities.

---

## 16. Provenance

The research question originated with Ivan Nestorov.

AI systems were used under his direction for mathematical exploration,
candidate identities, proof development, counterexample testing, Lean 4
formalization, exposition drafting, and adversarial review.

No AI system is listed as an author.

Further provenance information is recorded in:

```text
ORIGIN.md
CONTRIBUTIONS.md
```
