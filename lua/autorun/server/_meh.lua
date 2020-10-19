-- Manipulated-Entity Hooks

-- OnSetPos: entity Self, vector Pos
-- OnSetAng: entity Self, angle Ang
-- OnSetMass: entity Self, number Mass
-- OnSetColor: entity Self, color Col
-- OnSetMaterial: entity Self, string Material
-- OnSetNoDraw: entity Self, bool NoDraw
-- OnSetMoveType: entity Self, number MoveType
-- OnSetVel: entity self, vector Velocity
-- OnSetLocalVel: entity self, vector LocalVelocity
-- OnSetAbsVel: entity self, vector AbsVelocity
-- OnSetAngVel: entity self, angle AngVel

-- OnSetMass: physobj Self, number Mass
-- OnApplyCenter: physobj Self, vector Force
-- OnApplyOffset: physobj Self, vector Force, vector Pos
-- OnSetObjVel: physobj Self, vector Velocity
-- OnSetObjVelInstant: physobj Self, vector Velocity
-- OnApplyTorque: physobj Self, vector Torque
-- OnSetInertia: physobj Self, vector Inertia

-- OnParent: entity Self, entity Parent
-- OnUnparent: entity Self, entity OldParent
-- OnConstrain: entity A, entity B, entity Constraint
-- OnUnconstraint: entity A, entity B, entity Constraint


local HRUN   = hook.Run
local TSIMP  = timer.Simple
local ENT    = FindMetaTable("Entity")
local OBJ    = FindMetaTable("PhysObj")
local Filter = {predicted_viewmodel = true, gmod_hands = true} -- Induces normal parent behavior
local ValidConstraint = { -- Note: no-collide is missing because no-collide is not a constraint. KeepUpright is also just not worth mentioning.
    phys_lengthconstraint = true, phys_constraint = true, phys_hinge = true, phys_ragdollconstraint = true,
    gmod_winch_controller = true, phys_spring = true, phys_slideconstraint = true, phys_torque = true,
    phys_pulleyconstraint = true, phys_ballsocket = true
}


---- Make a copy of the originals

local O_Pos         = ENT.SetPos
local O_Ang         = ENT.SetAng
local O_Color       = ENT.SetColor
local O_Material    = ENT.SetMaterial
local O_Nodraw      = ENT.SetNoDraw
local O_Movetype    = ENT.SetMoveType
local O_Parent      = ENT.SetParent
local O_Velocity    = ENT.SetVelocity
local O_AngVel      = ENT.SetLocalAngularVelocity
local O_AbsVelocity = ENT.SetAbsVelocity
local O_LocalVel    = ENT.SetLocalVelocity

local O_Center      = OBJ.ApplyForceCenter
local O_Offset      = OBJ.ApplyForceOffset
local O_Torque      = OBJ.ApplyTorqueCenter
local O_ObjVel      = OBJ.SetVelocity
local O_ObjVelInst  = OBJ.SetVelocityInstantaneous
local O_SetMass     = OBJ.SetMass
local O_Inertia     = OBJ.SetInertia

---- Override global functions

do -- Track movement (Potentially expensive, off by default)
    function MEH_TrackMovement(Bool) -- Call MEH_TrackMovement(bool) to toggle tracking movement
        if Bool then
            function ENT:SetPos(Var, ...)
                if HRUN("OnSetPos", self, Var) == false then return end

                O_Pos(self, Var)
            end

            function ENT:SetAng(Var, ...)
                if HRUN("OnSetAng", self, Var) == false then return end

                O_Ang(self, Var, ...)
            end

            function ENT:SetVelocity(Var, ...)
                if HRUN("OnSetVel", self, Var) == false then return end

                O_Velocity(self, Var, ...)
            end

            function ENT:SetLocalVelocity(Var, ...)
                if HRUN("OnSetLocalVel", self, Var) == false then return end

                O_LocalVel(self, Var, ...)
            end

            function ENT:SetAbsVelocity(Var, ...)
                if HRUN("OnSetAbsVel", self, Var) == false then return end

                O_AbsVelocity(self, Var, ...)
            end

            function ENT:SetLocalAngularVelocity(Var, ...)
                if HRUN("OnSetAngVel", self, Var) == false then return end

                O_AngVel(self, Var, ...)
            end

            function OBJ:ApplyForceCenter(Var, ...)
                if HRUN("OnApplyCenter", self, Var) == false then return end

                O_Center(self, Var, ...)
            end

            function OBJ:ApplyForceOffset(Force, Pos, ...)
                if HRUN("OnApplyOffset", self, Force, Pos) == false then return end

                O_Offset(self, Force, Pos, ...)
            end

            function OBJ:ApplyTorqueCenter(Var, ...)
                if HRUN("OnApplyTorque", self, Var) == false then return end

                O_Torque(self, Var, ...)
            end

            function OBJ:SetVelocity(Var, ...)
                if HRUN("OnSetObjVel", self, Var) == false then return end

                O_ObjVel(self, Var, ...)
            end

            function OBJ:SetVelocityInstantaneous(Var, ...)
                if HRUN("OnSetObjVelInstant", self, Var) == false then return end

                O_ObjVelInst(self, Var, ...)
            end
        else
            ENT.SetPos                  = O_Pos
            ENT.SetAng                  = O_Ang
            ENT.SetVelocity             = O_Velocity
            ENT.SetLocalVelocity        = O_LocalVel
            ENT.SetAbsVelocity          = O_AbsVelocity
            ENT.SetLocalAngularVelocity = O_AngVel

            OBJ.ApplyForceCenter         = O_Center
            OBJ.ApplyForceOffset         = O_Offset
            OBJ.ApplyTorqueCenter        = O_Torque
            OBJ.SetVelocity              = O_ObjVel
            OBJ.SetVelocityInstantaneous = O_ObjVelInst
        end
    end
end

function ENT:SetColor(Var, ...)
    if HRUN("OnSetColor", self, Var) == false then return end

    O_Color(self, Var, ...)
end

function ENT:SetMaterial(Var, ...)
    if HRUN("OnSetMaterial", self, Var) == false then return end

    O_Material(self, Var, ...)
end

function ENT:SetNoDraw(Var, ...)
    if HRUN("OnSetNoDraw", self, Var) == false then return end

    O_Nodraw(self, Var, ...)
end

function ENT:SetMoveType(Var, ...)
    if HRUN("OnSetMoveType", self, Var) == false then return end

    O_Movetype(self, Var, ...)
end

function OBJ:SetMass(Var, ...)
    if HRUN("OnSetMass", self, Var) == false then return end

    O_SetMass(self, Var, ...)
end

function OBJ:SetInertia(Var, ...)
    if HRUN("OnSetInertia", self, Var) == false then return end

    O_Inertia(self, Var, ...)
end

function ENT:SetParent(Var, ...)
    if Filter[self:GetClass()] then
        O_Parent(self, Var, ...)

        return
    end

    local OldParent = self:GetParent()

    if IsValid(OldParent) and HRUN("OnUnparent", self, OldParent) == false then return end

    if IsValid(Var) then
        if HRUN("OnParent", self, Var) == false then -- Cannot parent
            return
        else -- But can unparent
            O_Parent(self, nil, ...)

            return
        end
    end

    O_Parent(self, Var, ...)
end

hook.Add("OnEntityCreated", "MEH!", function(Entity)
    if ValidConstraint[Entity:GetClass()] then
        TSIMP(0, function()
            if IsValid(Ent) then
                HRUN("OnConstrain", Entity.Ent1, Entity.Ent2 or Entity.Ent4, Entity)
            end
        end)
    end
end)

hook.Add("EntityRemoved", "MEH!", function(Entity)
    if ValidConstraint[Entity:GetClass()] then
        HRUN("OnUnconstrain", Entity.Ent1, Entity.Ent2 or Entity.Ent4, Entity)
    end
end)