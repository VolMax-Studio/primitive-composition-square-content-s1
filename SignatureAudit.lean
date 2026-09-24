import PrimitiveCompositionSquareContent

/-!
# Statement-fidelity audit

The two `#check` guards below expose that A and B-final have the same eight
integer parameters and the same four hypotheses.  Only the conclusions differ.
The third guard freezes the literal local divisibility statement.
-/

/--
info: primitive_composition_gcd_identity : ∀ (a b m c d n x y : ℤ),
  PrimitiveRightTriangle a b m →
    PrimitiveRightTriangle c d n → x = a * c - b * d → y = a * d + b * c → x.gcd y = y.gcd (↑(m.gcd n) ^ 2)
-/
#guard_msgs in
#check @primitive_composition_gcd_identity

/--
info: primitive_composition_gcd_eq_sq : ∀ (a b m c d n x y : ℤ),
  PrimitiveRightTriangle a b m →
    PrimitiveRightTriangle c d n → x = a * c - b * d → y = a * d + b * c → x.gcd y = y.gcd ↑(m.gcd n) ^ 2
-/
#guard_msgs in
#check @primitive_composition_gcd_eq_sq

/--
info: primitive_composition_local_all_or_nothing : ∀ (a b m c d n : ℤ) (p e : ℕ),
  PrimitiveRightTriangle a b m →
    PrimitiveRightTriangle c d n →
      Nat.Prime p → 0 < e → ↑p ^ e ∣ ↑(m.gcd n) → ¬↑p ∣ a * d + b * c ∨ ↑p ^ (2 * e) ∣ a * d + b * c
-/
#guard_msgs in
#check @primitive_composition_local_all_or_nothing
