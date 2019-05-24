ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "XP Book"
ENT.Author = "Manolis Vrondakis"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
end
