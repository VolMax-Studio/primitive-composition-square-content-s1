# Author-side build evidence

- Artifact: `primitive-composition-square-content-s1`
- Recorded UTC: `2026-09-24T06:11:33Z`
- Status: `SPREMNO ZA GEJT` / independent reproduction pending

## Environment observed

```text
Lean (version 4.34.0, x86_64-unknown-linux-gnu,
      commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)
Lake version 5.0.0-src+293d5d0 (Lean version 4.34.0)
Mathlib HEAD 5ed2965256430c3649e86755f9576b54eca72435
Mathlib exact tag v4.34.0
```

## Commands observed

```text
lake build PrimitiveTripleFilter
  PASS — 1394 jobs

lake build PrimitiveCompositionSquareContent
  PASS — 3096 jobs

lake env lean YZeroTest.lean
  PASS — exit 0

lake env lean SignatureAudit.lean
  PASS — exit 0

lake env lean AxiomAudit.lean
  PASS — exit 0
```

The six guarded public-theorem audits report only:

```text
[propext, Classical.choice, Quot.sound]
```

## Frozen-A check

```text
5b97b0a5eea88415f98783443c4f15fc3b4d1030fd3b0e99826110795a0216f5  PrimitiveTripleFilter.lean
```

This equals the canonical A digest supplied to the gate.  B does not modify
that file.

## Acceptance-checklist preflight

1. Toolchain, manifest, and full Mathlib commit are present.
2. Local conclusion is `¬ p ∣ y ∨ p ^ (2 * e) ∣ y` over `ℤ`.
3. `p = 2` is derived impossible via the public odd-hypotenuse theorem.
4. B-final has the same domain as A; guarded signatures pass.
5. Perfect-square scope is limited to primitive Pythagorean triples.
6. Guarded axiom audits pass; no `sorry`, `native_decide`, or axiom declaration
   occurs in the new B source.
7. Frozen A full SHA-256 matches.
8. The explicit `y = 0` conjugate witness passes.

These are author-side observations.  They do not substitute for the independent
gate run.

## Post-review infrastructure repair

- Applied UTC: `2026-09-24T07:48:25Z`
- External structural review: `SURVIVES-REVIEW`, with two packaging fixes.
- `README.md` no longer instructs a reproducer to run `lake update`; the
  supplied manifest is consumed without re-resolution.
- `verify.sh` now uses ubiquitous `grep -E`, explicitly requires it, and treats
  scan errors as failures instead of silently accepting a missing scanner.
- Full-file hashes are checked both before and after the build.
- Lean proof sources, theorem statements, pinned revisions, and frozen A bytes
  are unchanged by this repair.

The repaired package remains `SPREMNO ZA NEZAVISNI GEJT`; a successful local
rerun is author-side evidence and does not self-ratify the artifact.
