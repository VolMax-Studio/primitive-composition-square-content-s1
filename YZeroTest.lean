import PrimitiveCompositionSquareContent

/-!
# Complete cancellation sanity test

Take `z = 3 + 4i` and `w = 3 - 4i = conj z`.  Then the imaginary
coordinate of `z * w` is zero, the real coordinate is `25`, and both
hypotenuses are `5`.  The theorem must cover this case without a `y ≠ 0`
hypothesis or a modular surrogate.
-/

example :
    Int.gcd (25 : ℤ) 0 =
      (Int.gcd 0 (Int.gcd (5 : ℤ) 5 : ℤ)) ^ 2 := by
  exact primitive_composition_gcd_eq_sq
    (3 : ℤ) 4 5 3 (-4) 5 25 0
    (by norm_num [PrimitiveRightTriangle])
    (by norm_num [PrimitiveRightTriangle])
    (by norm_num)
    (by norm_num)

example :
    ¬(5 : ℤ) ∣ (3 : ℤ) * (-4) + 4 * 3 ∨
      (5 : ℤ) ^ (2 * 1) ∣ (3 : ℤ) * (-4) + 4 * 3 := by
  exact primitive_composition_local_all_or_nothing
    (3 : ℤ) 4 5 3 (-4) 5 5 1
    (by norm_num [PrimitiveRightTriangle])
    (by norm_num [PrimitiveRightTriangle])
    (by norm_num)
    (by norm_num)
    (by norm_num)
