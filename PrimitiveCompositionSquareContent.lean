import PrimitiveTripleFilter
import Mathlib.NumberTheory.PythagoreanTriples
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic

/-!
# Square content of primitive Pythagorean composition

This file strengthens the frozen gcd identity in `PrimitiveTripleFilter.lean`.
The public local theorem is stated as literal divisibility in `ℤ`; it has no
parity, nonzero-`y`, square-free, orientation, or positivity hypothesis.
-/

/-- The hypotenuse of a primitive Pythagorean triple is odd.  This is derived
from the primitive-triple hypotheses; parity is not an input assumption. -/
theorem primitiveRightTriangle_hypotenuse_odd
    {a b m : ℤ} (h : PrimitiveRightTriangle a b m) : Odd m := by
  have hpt : PythagoreanTriple a b m := by
    simpa [PythagoreanTriple, pow_two] using h.1
  rcases hpt.even_odd_of_coprime h.2 with hab | hab
  · have ha : Even a := by
      rw [even_iff_two_dvd]
      exact Int.dvd_of_emod_eq_zero hab.1
    have hb : Odd b := Int.odd_iff.mpr hab.2
    have hm_sq : Odd (m ^ 2) := by
      rw [← h.1]
      exact (ha.pow_of_ne_zero (by decide)).add_odd hb.pow
    exact (Int.odd_pow' (by decide)).mp hm_sq
  · have ha : Odd a := Int.odd_iff.mpr hab.1
    have hb : Even b := by
      rw [even_iff_two_dvd]
      exact Int.dvd_of_emod_eq_zero hab.2
    have hm_sq : Odd (m ^ 2) := by
      rw [← h.1]
      exact ha.pow.add_even (hb.pow_of_ne_zero (by decide))
    exact (Int.odd_pow' (by decide)).mp hm_sq

private theorem prime_not_dvd_first_leg
    {a b m : ℤ} {p : ℕ}
    (h : PrimitiveRightTriangle a b m)
    (hp : Nat.Prime p)
    (hpm : (p : ℤ) ∣ m) :
    ¬(p : ℤ) ∣ a := by
  intro hpa
  have hpm2 : (p : ℤ) ∣ m ^ 2 :=
    hpm.trans (dvd_pow_self m (by decide))
  have hpa2 : (p : ℤ) ∣ a ^ 2 :=
    hpa.trans (dvd_pow_self a (by decide))
  have hpb2 : (p : ℤ) ∣ b ^ 2 := by
    rw [show b ^ 2 = m ^ 2 - a ^ 2 by linarith [h.1]]
    exact hpm2.sub hpa2
  have hpb : (p : ℤ) ∣ b := Int.Prime.dvd_pow' hp hpb2
  have hpInt : Prime (p : ℤ) := Nat.prime_iff_prime_int.mp hp
  exact hpInt.not_isUnit
    ((Int.isCoprime_iff_gcd_eq_one.mpr h.2).isUnit_of_dvd' hpa hpb)

/-- Local all-or-nothing law.  If a positive prime block `p ^ e` occurs in
the common hypotenuse, then the imaginary coordinate of the product contains
either none of `p`, or the complete doubled block `p ^ (2 * e)`.

The conclusion is literal divisibility in `ℤ`, including the case in which the
imaginary coordinate is zero. -/
theorem primitive_composition_local_all_or_nothing
    (a b m c d n : ℤ) (p e : ℕ)
    (h1 : PrimitiveRightTriangle a b m)
    (h2 : PrimitiveRightTriangle c d n)
    (hp : Nat.Prime p)
    (he : 0 < e)
    (hpe : (p : ℤ) ^ e ∣ (Int.gcd m n : ℤ)) :
    ¬(p : ℤ) ∣ a * d + b * c ∨
      (p : ℤ) ^ (2 * e) ∣ a * d + b * c := by
  have hpem : (p : ℤ) ^ e ∣ m := hpe.trans (Int.gcd_dvd_left m n)
  have hpen : (p : ℤ) ^ e ∣ n := hpe.trans (Int.gcd_dvd_right m n)
  have hpm : (p : ℤ) ∣ m :=
    (dvd_pow_self (p : ℤ) he.ne').trans hpem
  have hpn : (p : ℤ) ∣ n :=
    (dvd_pow_self (p : ℤ) he.ne').trans hpen

  have hm_not_two : ¬(2 : ℤ) ∣ m := by
    intro hm2
    have hm_even : Even m := even_iff_two_dvd.mpr hm2
    exact (Int.not_even_iff_odd.mpr
      (primitiveRightTriangle_hypotenuse_odd h1)) hm_even
  have hp_not_two : ¬(p : ℤ) ∣ (2 : ℤ) := by
    intro hp2
    have hp2Nat : p ∣ 2 := by
      exact Int.natCast_dvd.mp (by simpa using hp2)
    have hpeq : p = 2 :=
      (Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp hp2Nat
    apply hm_not_two
    simpa [hpeq] using hpm

  have hpa : ¬(p : ℤ) ∣ a := prime_not_dvd_first_leg h1 hp hpm
  have h2swap : PrimitiveRightTriangle d c n := by
    constructor
    · simpa [add_comm] using h2.1
    · simpa [Int.gcd_comm] using h2.2
  have hpd : ¬(p : ℤ) ∣ d := prime_not_dvd_first_leg h2swap hp hpn
  have hp_not_twoad : ¬(p : ℤ) ∣ 2 * a * d := by
    intro hpad
    rcases Int.Prime.dvd_mul' hp hpad with hp2a | hpd'
    · rcases Int.Prime.dvd_mul' hp hp2a with hp2 | hpa'
      · exact hp_not_two hp2
      · exact hpa hpa'
    · exact hpd hpd'

  have hk1 : (p : ℤ) ^ (2 * e) ∣ a ^ 2 + b ^ 2 := by
    rcases hpem with ⟨u, hu⟩
    refine ⟨u ^ 2, ?_⟩
    rw [h1.1, hu, Nat.mul_comm 2 e, pow_mul]
    ring
  have hk2 : (p : ℤ) ^ (2 * e) ∣ c ^ 2 + d ^ 2 := by
    rcases hpen with ⟨u, hu⟩
    refine ⟨u ^ 2, ?_⟩
    rw [h2.1, hu, Nat.mul_comm 2 e, pow_mul]
    ring

  let z : ℤ := a * d - b * c
  have hk_prod : (p : ℤ) ^ (2 * e) ∣ (a * d + b * c) * z := by
    have hleft := hk1.mul_right (d ^ 2)
    have hright := hk2.mul_left (b ^ 2)
    have hsub := hleft.sub hright
    have hid :
        (a * d + b * c) * z =
          (a ^ 2 + b ^ 2) * d ^ 2 - b ^ 2 * (c ^ 2 + d ^ 2) := by
      simp [z]
      ring
    rw [hid]
    exact hsub

  by_cases hz : (p : ℤ) ∣ z
  · left
    intro hy
    apply hp_not_twoad
    have hsum := hy.add hz
    have hid : (a * d + b * c) + z = 2 * a * d := by
      simp [z]
      ring
    rw [hid] at hsum
    exact hsum
  · right
    have hpInt : Prime (p : ℤ) := Nat.prime_iff_prime_int.mp hp
    have hcoprime : IsCoprime ((p : ℤ) ^ (2 * e)) z :=
      (hpInt.coprime_iff_not_dvd.mpr hz).pow_left
    exact hcoprime.dvd_of_dvd_mul_right hk_prod

private theorem nat_gcd_sq_eq_sq_gcd_of_all_or_nothing
    (Y Q : ℕ)
    (hQ : Q ≠ 0)
    (hlocal : ∀ (p e : ℕ), Nat.Prime p → 0 < e → p ^ e ∣ Q →
      ¬p ∣ Y ∨ p ^ (2 * e) ∣ Y) :
    Nat.gcd Y (Q ^ 2) = (Nat.gcd Y Q) ^ 2 := by
  by_cases hY : Y = 0
  · subst Y
    simp
  have hleft : Nat.gcd Y (Q ^ 2) ≠ 0 := by
    rw [ne_eq, Nat.gcd_eq_zero_iff, not_and_or]
    exact Or.inl hY
  have hright : (Nat.gcd Y Q) ^ 2 ≠ 0 := by
    apply pow_ne_zero
    rw [ne_eq, Nat.gcd_eq_zero_iff, not_and_or]
    exact Or.inl hY
  apply Nat.eq_of_factorization_eq hleft hright
  intro p
  rw [Nat.factorization_gcd hY (pow_ne_zero _ hQ)]
  rw [Nat.factorization_pow Q 2]
  rw [Nat.factorization_pow (Nat.gcd Y Q) 2]
  rw [Nat.factorization_gcd hY hQ]
  by_cases hp : Nat.Prime p
  · by_cases he : Q.factorization p = 0
    · simp [he]
    · have hepos : 0 < Q.factorization p := Nat.pos_of_ne_zero he
      have hpow : p ^ Q.factorization p ∣ Q := Nat.ordProj_dvd Q p
      rcases hlocal p (Q.factorization p) hp hepos hpow with hnot | hdiv
      · have hy0 : Y.factorization p = 0 :=
          Nat.factorization_eq_zero_of_not_dvd hnot
        simp [hy0]
      · have hle : 2 * Q.factorization p ≤ Y.factorization p :=
          (hp.pow_dvd_iff_le_factorization hY).mp hdiv
        simp only [Finsupp.inf_apply, Finsupp.smul_apply, nsmul_eq_mul,
          Nat.cast_ofNat]
        omega
  · have hy0 : Y.factorization p = 0 :=
      Nat.factorization_eq_zero_of_not_prime Y hp
    have hq0 : Q.factorization p = 0 :=
      Nat.factorization_eq_zero_of_not_prime Q hp
    simp [hy0, hq0]

/-- The content of a composition of two primitive Pythagorean triples is the
square of the cancelled part of their common hypotenuse. -/
theorem primitive_composition_gcd_eq_sq
    (a b m c d n x y : ℤ)
    (h1 : PrimitiveRightTriangle a b m)
    (h2 : PrimitiveRightTriangle c d n)
    (hx : x = a * c - b * d)
    (hy : y = a * d + b * c) :
    Int.gcd x y = (Int.gcd y (Int.gcd m n : ℤ)) ^ 2 := by
  rw [primitive_composition_gcd_identity a b m c d n x y h1 h2 hx hy]
  let Q : ℕ := Int.gcd m n
  have hm0 : m ≠ 0 := by
    intro hm
    subst m
    exact Int.not_odd_zero (primitiveRightTriangle_hypotenuse_odd h1)
  have hQ : Q ≠ 0 := by
    intro hQ0
    have hmn0 : m = 0 ∧ n = 0 := Int.gcd_eq_zero_iff.mp hQ0
    exact hm0 hmn0.1
  have hlocalNat : ∀ (p e : ℕ), Nat.Prime p → 0 < e → p ^ e ∣ Q →
      ¬p ∣ y.natAbs ∨ p ^ (2 * e) ∣ y.natAbs := by
    intro p e hp he hpe
    have hpeInt : (p : ℤ) ^ e ∣ (Q : ℤ) := by
      exact_mod_cast hpe
    have hloc := primitive_composition_local_all_or_nothing
      a b m c d n p e h1 h2 hp he (by simpa [Q] using hpeInt)
    rw [← hy] at hloc
    rcases hloc with hnot | hdiv
    · left
      intro hpY
      exact hnot (Int.natCast_dvd.mpr hpY)
    · right
      apply Int.natCast_dvd.mp
      simpa using hdiv
  have hNat := nat_gcd_sq_eq_sq_gcd_of_all_or_nothing
    y.natAbs Q hQ hlocalNat
  simpa [Int.gcd_def, Q] using hNat

/-- In the Pythagorean domain of the theorem above, the composition content is
a perfect square.  This statement is not asserted for general primitive
Gaussian pairs whose norms need not be squares. -/
theorem primitive_composition_gcd_isSquare
    (a b m c d n x y : ℤ)
    (h1 : PrimitiveRightTriangle a b m)
    (h2 : PrimitiveRightTriangle c d n)
    (hx : x = a * c - b * d)
    (hy : y = a * d + b * c) :
    IsSquare (Int.gcd x y) := by
  refine ⟨Int.gcd y (Int.gcd m n : ℤ), ?_⟩
  simpa [pow_two] using
    (primitive_composition_gcd_eq_sq a b m c d n x y h1 h2 hx hy)
