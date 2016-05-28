resource.AddSingleFile('materials/vrondakis/xp_bar.png')
resource.AddSingleFile('resource/fonts/FrancoisOne.ttf')
local meta = FindMetaTable("Player")

function meta:setLevel(level)
	if not (level or self:IsPlayer()) then return end
	return self:setDarkRPVar('level', level)
end

function meta:setXP(xp)
	if not (xp or self:IsPlayer()) then return end
	return self:setDarkRPVar('xp', xp)
end

function meta:addXP(amount, notify, carryOver)
	local PlayerLevel = (self:getDarkRPVar('level'))
	local PlayerXP = (self:getDarkRPVar('xp'))
	amount = tonumber(amount)

	if((not amount) or (not IsValid(self)) or (not PlayerLevel) or (not PlayerXP) or (PlayerLevel>=LevelSystemConfiguration.MaxLevel)) then return 0 end
	if(not carryOver) then
		if(self.VXScaleXP) then
			amount=(amount*tonumber(self.VXScaleXP))
		end
	end

	if not(notify) then
		DarkRP.notify(self,0,4,'You got '..amount..' XP!')
	end
	
	local TotalXP = PlayerXP + amount

	if(TotalXP>=self:getMaxXP()) then // Level up!
		PlayerLevel = PlayerLevel + 1
		DarkRP.notifyAll(0,3,self:Name() .. ' reached level '..PlayerLevel..'!')
		hook.Call( "PlayerLevelChanged", nil, self, PlayerLevel-1, PlayerLevel ) // call the PlayerLevelChanged hook and pass player, old level and new level.

		local RemainingXP = (TotalXP-self:getMaxXP())
		if(LevelSystemConfiguration.ContinueXP) then
			if(RemainingXP>0) then
				self:setXP(0)
				self:setLevel(PlayerLevel)
				return self:addXP(RemainingXP,true,true)
			end
		end
		
		self:setLevel(PlayerLevel)
		self:setXP(0)
		
		DarkRP.storeXPData(self,PlayerLevel,0)
	else
		DarkRP.storeXPData(self,PlayerLevel,(TotalXP or 0))
		self:setXP(math.max(0,TotalXP))

	end
	return (amount or 0)

end

meta.AddXP = meta.addXP

function meta:getLevel()
	return self:getDarkRPVar('level')
end

function meta:getXP()
	return self:getDarkRPVar('xp')
end

function meta:getMaxXP()
	return (((10+(((self:getDarkRPVar('level') or 1)*((self:getDarkRPVar('level') or 1)+1)*90))))*LevelSystemConfiguration.XPMult)
end

function meta:addLevels(levels)
	if(self:getDarkRPVar('level') == LevelSystemConfiguration.MaxLevel) then
			return false
	end
	if((self:getDarkRPVar('level') +levels)>LevelSystemConfiguration.MaxLevel) then
		// Determine how many levels we can add.
		local LevelsCan = (((self:getDarkRPVar('level')+levels))-LevelSystemConfiguration.MaxLevel)
		if(LevelsCan==0) then
			return 0
		else
			DarkRP.storeXPData(self, LevelSystemConfiguration.MaxLevel,0)
			self:setDarkRPVar('xp',0)
			self:setDarkRPVar('level', LevelSystemConfiguration.MaxLevel)
			return LevelsCan
		end
		
	else
		DarkRP.storeXPData(self,(self:getDarkRPVar('level') +levels),0)
		self:setDarkRPVar('xp',0)
		self:setDarkRPVar('level',(self:getDarkRPVar('level') +levels))
		return levels
	end
	
		
end

function meta:hasLevel(level)
	return ((self:getDarkRPVar('level')) >= level)
end

concommand.Add("levels", function(ply)
	DarkRP.notify(ply,0,10,"Leveling System by @vrondakis")
end)
