// Love Manolis Vrondakis. @vrondakis
resource.AddSingleFile('materials/vrondakis/xp_bar.png')
resource.AddSingleFile('resource/fonts/FrancoisOne.ttf')
local meta = FindMetaTable("Player")
function meta:addXP(amount, anal)
	if not IsValid(self) then return false end
	if not amount then return false end
	amount = tonumber(amount)

	if(!self:getDarkRPVar('xp')) then
		DarkRP.notify(self,0,5,'XP not set. Err..')
			return ""
	end

	if(self:getDarkRPVar('level') == LevelSystemConfiguration.MaxLevel) then
			return ""
	end

	if not(anal) then
		DarkRP.notify(self,0,4,'You got '..amount..' XP!')
	end

	local PlayerLevel = (self:getDarkRPVar('level') or 1)
	local PlayerXP = (self:getDarkRPVar('xp') or 1)
	local TotalXP = PlayerXP + amount

	if(TotalXP>=self:getMaxXP()) then
		PlayerLevel = PlayerLevel + 1
		DarkRP.notifyAll(0,3,self:Name() .. ' reached level '..PlayerLevel..'!')
		hook.Call( "PlayerLevelChanged" )

		local RemainingXP = (TotalXP-self:getMaxXP())
		if(LevelSystemConfiguration.ContinueXP) then
			if(RemainingXP>0) then
				self:setDarkRPVar('xp',0)
				self:setDarkRPVar('level',PlayerLevel)
				self:addXP(RemainingXP,true)
				return
			end
		end
		self:setDarkRPVar('level', PlayerLevel)
		self:setDarkRPVar('xp',0)
		DarkRP.storeXPData(self,PlayerLevel,0)
	else
		DarkRP.storeXPData(self,PlayerLevel,(TotalXP or 0))
		self:setDarkRPVar('xp', math.max(0,TotalXP))

	end
end


function meta:getLevel()
	return self:getDarkRPVar('level')
end

function meta:setLevel(level)
	if not level then return end
	return self:setDarkRPVar('level', level)
end

function meta:getXP()
	return self:getDarkRPVar('xp')
end

function meta:setXP(xp)
	return self:setDarkRPVar('xp', xp)
end

function meta:getMaxXP()
	return (((10+(((self:getDarkRPVar('level') or 1)*((self:getDarkRPVar('level') or 1)+1)*90))))*LevelSystemConfiguration.XPMult)
end

function meta:hasLevel(level)
	if(self:getDarkRPVar('level')) >= level then return true
	else return false end
end

// Please do not remove or edit this:

concommand.Add("levels", function() 
	print('--------------------')
	print('--LEVELING SYSTEM---')
	print('----BY VRONDAKIS----')
	print('-----@vrondakis-----')
	print('--------------------')
end)