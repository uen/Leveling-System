AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include("shared.lua")
 
function ENT:Initialize()
	self:SetModel(self.DarkRPItem.model)
	self:SetColor(self.DarkRPItem.vrondakisColor)
	
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS )   
    self:SetSolid( SOLID_VPHYSICS ) 
    local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
        end
    end

function ENT:Use( activator, caller )
	local xp = self.DarkRPItem.xp
	local bookname = self.DarkRPItem.vrondakisName
    activator:addXP( xp, true)
	DarkRP.notify(activator, 0,4,LevelSystemConfiguration.LangBookNotify)
	self:Remove()
end

function ENT:Touch(entity)
	if LevelSystemConfiguration.BookOnTouch then
		if (!entity:IsPlayer()) then return end
		local xp = self.DarkRPItem.xp
		local bookname = self.DarkRPItem.vrondakisName
		entity:addXP( xp, true)
		DarkRP.notify(entity, 0,4, string.format( LevelSystemConfiguration.LangBookNotify, xp, bookname ))
		self:Remove()
	end
end