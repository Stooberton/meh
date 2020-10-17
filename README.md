# meh
Adds manipulated-entity hooks to Garrysmod

## Hooks
OnSetPos: entity Self, vector Pos

OnSetAng: entity Self, angle Ang

OnSetMass: entity Self, number Mass

OnSetColor: entity Self, color Col

OnSetMaterial: entity Self, string Material

OnSetNoDraw: entity Self, bool NoDraw

OnSetMoveType: entity Self, number MoveType

OnSetVel: entity self, vector Velocity

OnSetLocalVel: entity self, vector LocalVelocity

OnSetAbsVel: entity self, vector AbsVelocity

OnSetAngVel: entity self, angle AngVel

OnSetMass: physobj Self, number Mass

OnApplyCenter: physobj Self, vector Force

OnApplyOffset: physobj Self, vector Force, vector Pos

OnSetObjVel: physobj Self, vector Velocity

OnSetObjVelInstant: physobj Self, vector Velocity

OnApplyTorque: physobj Self, vector Torque

OnSetInertia: physobj Self, vector Inertia

OnParent: entity Self, entity Parent

OnUnparent: entity Self, entity OldParent

OnConstrain: entity A, entity B, entity Constraint

OnUnconstraint: entity A, entity B, entity Constraint
