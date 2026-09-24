import PrimitiveCompositionSquareContent

/-!
# Axiom audit

Every public theorem in the frozen A source and the B source is guarded against
any dependency beyond the standard Lean/Mathlib foundations listed below.
-/

/--
info: 'primitive_composition_gcd_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms primitive_composition_gcd_identity

/--
info: 'primitive_filter_criterion' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms primitive_filter_criterion

/--
info: 'primitiveRightTriangle_hypotenuse_odd' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms primitiveRightTriangle_hypotenuse_odd

/--
info: 'primitive_composition_local_all_or_nothing' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms primitive_composition_local_all_or_nothing

/--
info: 'primitive_composition_gcd_eq_sq' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms primitive_composition_gcd_eq_sq

/--
info: 'primitive_composition_gcd_isSquare' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms primitive_composition_gcd_isSquare
