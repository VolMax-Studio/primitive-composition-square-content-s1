# Primitive-composition square content — s1

Small Lean 4 artifact for the second rung of the primitive-Pythagorean
composition result.  It preserves the earlier A source byte-for-byte and adds
one local theorem and one global strengthening.

## Mathematical scope

For primitive Pythagorean triples

```text
a² + b² = m²,  gcd(a,b) = 1
c² + d² = n²,  gcd(c,d) = 1
```

put

```text
x = ac - bd
y = ad + bc
q = gcd(m,n).
```

The public local theorem is

```text
p prime, 0 < e, p^e ∣ q
  ⟹  ¬ p ∣ y ∨ p^(2e) ∣ y.
```

Its conclusion is literal divisibility in `ℤ`.  There is no `Odd p`, `p ≠ 2`,
square-free, positivity, orientation, or `y ≠ 0` assumption.  The case `p = 2`
is excluded inside the proof by the separately proved fact that a primitive
Pythagorean hypotenuse is odd.

Combining the local theorem with the frozen A theorem gives

```text
gcd(x,y) = gcd(y,q)^2.
```

The final theorem has exactly the same parameters and hypotheses as
`primitive_composition_gcd_identity`; `SignatureAudit.lean` locks both public
signatures side by side.

The perfect-square corollary is restricted to the Pythagorean domain above.
It is **not** asserted for arbitrary primitive Gaussian pairs whose norms need
not be squares.

## Files

- `PrimitiveTripleFilter.lean` — frozen A source, unchanged.
- `PrimitiveCompositionSquareContent.lean` — B proof and square-content
  corollary.
- `YZeroTest.lean` — complete-cancellation witness
  `(3 + 4i)(3 - 4i) = 25 + 0i`.
- `SignatureAudit.lean` — guarded theorem-of-record signatures.
- `AxiomAudit.lean` — guarded `#print axioms` output for every public theorem
  in A and B.
- `lake-manifest.json`, `lakefile.toml`, `lean-toolchain` — pinned build inputs.
- `BUILD_EVIDENCE.md`, `SHA256SUMS` — author-side execution record and file
  digests.

## Pinned environment

- Lean: `v4.34.0`
- Lean commit: `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`
- Mathlib tag: `v4.34.0`
- Mathlib commit: `5ed2965256430c3649e86755f9576b54eca72435`
- Frozen A source SHA-256:
  `5b97b0a5eea88415f98783443c4f15fc3b4d1030fd3b0e99826110795a0216f5`

## Reproduction

Do **not** run `lake update`: the supplied `lake-manifest.json` is part of the
frozen input and must not be re-resolved or rewritten.  A Mathlib cache fetch is
optional and does not replace the verification step:

```bash
# Optional acceleration:
lake exe cache get

# Authoritative end-to-end check:
./verify.sh
```

`verify.sh` consumes the supplied manifest directly, checks all frozen hashes
before and after the build, and rejects a changed manifest.  Its `mathlib.rev`
must be the full commit shown above.

## Gate status

The B Lean artifact is human-ratified by an SSH-signed annotated Git tag
`primitive-composition-square-content-v1-ratified`, pointing to commit
`027b50086d333ae2acbbecfd60e1ad6cb80edf7d`.

The pinned GitHub Actions Lean gate completed successfully, and an AI gate review
of mediated artifacts returned `SURVIVES-REVIEW`.  The reviewer had no direct
repository access and did not independently reproduce the Lean kernel build;
those limitations remain part of the record.

Ratification covers only the stated Lean theorem scope.  Benchmark D remains
`HALT`.  This artifact makes no performance, novelty, factorization-equivalence,
RSA, or publication claim.

---

## Canonical publication artifact

The frozen public proof-artifact bundle for Rungs A and B is archived on Zenodo:

- DOI: `10.5281/zenodo.22940155`
- Version: `1.0.0`
- License: MIT
- Record: https://zenodo.org/records/22940155

For Rung B, the human-ratified theorem commit remains
`027b50086d333ae2acbbecfd60e1ad6cb80edf7d`.

The publication snapshot is tagged
`primitive-composition-square-content-v1-publication-snapshot`.
