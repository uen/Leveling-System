// Modified from core DarkRP.
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SeizeReward = 950
ENT.StoredMoney = 0
ENT.StoredXP = 0

local PrintMore
function ENT:Initialize()
	self:SetModel(self.DarkRPItem.model)
	self:SetColor(self.DarkRPItem.vrondakisColor)


	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.sparking = false
	self.damage = 100
	self.IsMoneyPrinter = true
	timer.Simple(self.DarkRPItem.vrondakisPrinterTime,function() PrintMore(self) end)

	if(LevelSystemConfiguration.PrinterSound) then
		self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
		self.sound:SetSoundLevel(52)
		self.sound:PlayEx(1, 100)
	end

	self:SetNWString("PrinterName", (self.DarkRPItem.name or "Unknown"))
	self:SetNWInt("MoneyPerPrint", self.DarkRPItem.vrondakisMoneyPerPrint or 0)
	self:SetNWInt("MoneyAmount", 0)
	self:SetNWInt("MaxConfig",self.DarkRPItem.vrondakisPrinterMaxP or 1)

	self:SetUseType(SIMPLE_USE)



end

function ENT:OnTakeDamage(dmg)
	if self.burningup then return end

	self.damage = (self.damage or 100) - dmg:GetDamage()
	if self.damage <= 0 then
		local rnd = math.random(1, 10)
		if rnd < 3 then
			self:BurstIntoFlames()
		else
			self:Destruct()
			self:Remove()
		end
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
	if(IsValid(self:Getowning_ent())) then
		DarkRP.notify(self:Getowning_ent(), 1, 4, DarkRP.getPhrase("money_printer_exploded"))
	end
end

function ENT:BurstIntoFlames()
	DarkRP.notify(self:Getowning_ent(), 0, 4, DarkRP.getPhrase("money_printer_overheating"))
	self.burningup = true
	local burntime = math.random(8, 18)
	self:Ignite(burntime, 0)
	timer.Simple(burntime, function() self:Fireball() end)
end

function ENT:Fireball()
	if not self:IsOnFire() then self.burningup = false return end
	local dist = math.random(20, 280) -- Explosion radius
	self:Destruct()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
		if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
			v:Ignite(math.random(5, 22), 0)
			elseif v:IsPlayer() then
				local distance = v:GetPos():Distance(self:GetPos())
				v:TakeDamage(distance / dist * 100, self, self)
			end
		end
		self:Remove()
	end

	PrintMore = function(ent)
	if not IsValid(ent) then return end

	ent.sparking = true
	timer.Simple(1, function()
		if not IsValid(ent) then return end
		ent:CreateMoneybag()
		end)
end

function ENT:CreateMoneybag()
	if not IsValid(self) or self:IsOnFire() then return end

	local MoneyPos = self:GetPos()
	if(self.DarkRPItem.vrondakisPrinterOverheat) then
		local overheatchance
		if GAMEMODE.Config.printeroverheatchance <= 3 then
			overheatchance = 22
		else
			overheatchance = GAMEMODE.Config.printeroverheatchance or 22
		end
		if math.random(1, overheatchance) == 3 then self:BurstIntoFlames() end
	end
	if(self.DarkRPItem.vrondakisPrinterMaxP == 0) or ((self.StoredMoney+self.DarkRPItem.vrondakisMoneyPerPrint) <= (self.DarkRPItem.vrondakisMoneyPerPrint*self.DarkRPItem.vrondakisPrinterMaxP)) then

		local amount = self.DarkRPItem.vrondakisMoneyPerPrint
		local xpamount = self.DarkRPItem.vrondakisXPPerPrint

		self.StoredMoney = self.StoredMoney + amount
		self.StoredXP = self.StoredXP + xpamount
		self:SetNWInt("MoneyAmount", self.StoredMoney)
	end

	self.sparking = false
	timer.Simple(self.DarkRPItem.vrondakisPrinterTime,function() PrintMore(self) end)
end

function ENT:Use(activator,caller)
	local xpAdded = 0
	if(IsValid(activator)) then
		if(activator:IsPlayer()) then
			if(self.StoredMoney>0) then
				if (not(self.DarkRPItem.vrondakisPrinterCanCollect)) then
					if not(self.StoredMoney==0) then
						activator:addMoney(self.StoredMoney)
					end

					if not (self.StoredXP==0) then
						activator:addXP(self.StoredXP,true)
					end
					self:SetNWInt("MoneyAmount", 0)
					DarkRP.notify(activator,0,4, DarkRP.getPhrase("lvl_printer_use", self.StoredXP, DarkRP.formatMoney(self.StoredMoney)))
					if guthlogsystem then
						guthlogsystem.addLog( "DarkRP Leveling System", "*"..activator:Name().."* got &"..self.StoredXP.."& XP and !"..DarkRP.formatMoney(self.StoredMoney).."! for using ?"..self:Getowning_ent():Name().."? printer" )
					end
					self.StoredMoney = 0
					self.StoredXP = 0

				else
					if(activator:getDarkRPVar("level")<(self.DarkRPItem.level-5)) then return DarkRP.notify(activator,0,4, DarkRP.getPhrase("lvl_printer_level")) end

					if not(self.StoredMoney==0) then
						activator:addMoney(self.StoredMoney)
					end

					if not (self.StoredXP==0) then
						activator:addXP(self.StoredXP,true)
					end
					self:SetNWInt("MoneyAmount", 0)
					DarkRP.notify(activator,0,4, DarkRP.getPhrase("lvl_printer_use", self.StoredXP, DarkRP.formatMoney(self.StoredMoney)))
					if guthlogsystem then
						guthlogsystem.addLog( "DarkRP Leveling System", "*"..activator:Name().."* got &"..self.StoredXP.."& XP and !"..DarkRP.formatMoney(self.StoredMoney).."! for using ?"..self:Getowning_ent():Name().."? printer" )
					end
					self.StoredMoney = 0
					self.StoredXP = 0
				end
			end
			
		end
	end
end
function ENT:Think()

	if self:WaterLevel() > 0 then
		self:Destruct()
		self:Remove()
		return
	end
	if(self.DarkRPItem.vrondakisPrinterEpilepsy) then
		if(self.StoredMoney>0) then
			//Pick a random color, go to it, then change the color
			local Rr = math.random(0,255)
			local Rb = math.random(0,255)
			local Rc = math.random(0,255)

			self:SetColor(Color(Rr,Rb,Rc))
		end
	end

	if not self.sparking then return end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetMagnitude(1)
	effectdata:SetScale(1)
	effectdata:SetRadius(2)
	util.Effect("Sparks", effectdata)



end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end
