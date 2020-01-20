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
	local XP = self.DarkRPItem.xp
	local bookname = self.DarkRPItem.vrondakisName
	activator:addXP( XP, true)
	DarkRP.notify(activator, 0,4, DarkRP.getPhrase("lvl_book_notify", XP, bookname))
	if guthlogsystem then
		guthlogsystem.addLog( "DarkRP Leveling System", "*"..activator:Name().."* got &"..XP.."& XP for using ?"..bookname.."?" )
	end
	self:Remove()
end

function ENT:Touch(entity)
	if LevelSystemConfiguration.BookOnTouch then
		if (!entity:IsPlayer()) then return end
		local XP = self.DarkRPItem.xp
		local bookname = self.DarkRPItem.vrondakisName
		entity:addXP( XP, true)
		DarkRP.notify(entity, 0,4, DarkRP.getPhrase("lvl_book_notify", XP, bookname))
		if guthlogsystem then
			guthlogsystem.addLog( "DarkRP Leveling System", "*"..entity:Name().."* got &"..XP.."& XP for using ?"..bookname.."?" )
		end
		self:Remove()
	end
end
