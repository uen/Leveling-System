AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local PrintMore
function ENT:Initialize()
	self:SetModel("models/props_lab/bindergraylabel01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self.GiveXPAmount = self.DarkRPItem.GiveXPAmountOnUse

end

function ENT:Use(activator,caller)
	if(activator:IsPlayer()) then
		activator:addXP((self.DarkRPItem.GiveXPAmountOnUse) or 0)
	end
	self:Remove()
end
