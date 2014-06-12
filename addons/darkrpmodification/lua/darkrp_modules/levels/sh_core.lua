// Love Manolis Vrondakis. @vrondakis
if SERVER then 
hook.Add('canBuyPistol', 'cnbypistl', function(ply, entity) 
	if (entity.level) then
			if not ((ply:getDarkRPVar('level') or 0) >= (entity.level)) then
				DarkRP.notify(ply, 1, 4, 'You\'re not the right level to buy this!')
				return false, true
			end
	end
end)


hook.Add('canBuyAmmo', 'cnbyam0l', function(ply, entity) 
	if (entity.level) then
			if not ((ply:getDarkRPVar('level') or 0) >= (entity.level)) then
				DarkRP.notify(ply, 1, 4, 'You\'re not the right level to buy this!')
				return false, true
			end
	end
end)

hook.Add('canBuyShipment', 'cnbyshipmentalsomanolisissexy', function(ply, entity) 
	if (entity.level) then
			if not ((ply:getDarkRPVar('level') or 0) >= (entity.level)) then
				DarkRP.notify(ply, 1, 4, 'You\'re not the right level to buy this!')
				return false, true
			end
	end
end)

hook.Add('canBuyVehicle', 'cnbyshipmentalsomanolisissex2y', function(ply, entity) 
	if (entity.level) then
			if not ((ply:getDarkRPVar('level') or 0) >= (entity.level)) then
				DarkRP.notify(ply, 1, 4, 'You\'re not the right level to buy this!')
				return false, true
			end
	end
end)

hook.Add('canBuyCustomEntity', 'cnbycsnemtity2', function(ply, entity) 
	if (entity.level) then
			if not ((ply:getDarkRPVar('level') or 0) >= (entity.level)) then
				DarkRP.notify(ply, 1, 4, 'You\'re not the right level to buy this!')
				return false, true
			end
	end
end)




hook.Add('playerCanChangeTeam', 'cnchandsejob12313', function(ply, jobno) 
	// This one requires a little extra work
	job = RPExtraTeams[jobno]
	if (job.level) then
			
			if not ((ply:getDarkRPVar('level') or 0) >= (job.level)) then
				DarkRP.notify(ply, 1, 4, 'You\'re not the right level to become this!')
				return false, true
			end
	end
end)

end

if CLIENT then
function LevelPrompts()
	timer.Simple(0.1,function()

		if(LevelSystemPrestigeConfiguration) then
			return // My sexy system.
		end

		for k,v in pairs(DarkRPEntities) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. ' - Level '..v.level)
			end
		end

		for k,v in pairs(RPExtraTeams) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. ' - Level '..v.level)
			end
		end

		for k,v in pairs(CustomVehicles) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. ' - Level '..v.level)
			end
		end

		for k,v in pairs(CustomShipments) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. ' - Level '..v.level)
			end
		end

		for k,v in pairs(GAMEMODE.AmmoTypes) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. ' - Level '..v.level)
			end
		end
	end)

end

hook.Add( "InitPostEntity", "initdrpa", function()
	LevelPrompts()
end) 

hook.Add("OnReloaded", "alalaldoadoaoawdadadoaga", function()
	LevelPrompts()
end)

end


if CLIENT then

function ButtonColors()
	timer.Simple(0.1, function()
		if(LevelSystemPrestigeConfiguration) then
			return // My sexy system.
		end

		if(LevelSystemConfiguration.GreenAllBars) then
			for k,v in pairs(DarkRPEntities) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar('level') or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end

			end
		end

		if(LevelSystemConfiguration.GreenJobBars) then
			for k,v in pairs(RPExtraTeams) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar('level') or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end

			end
		end

		if(LevelSystemConfiguration.GreenAllBars) then
			for k,v in pairs(CustomVehicles) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar('level') or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end
			end

			for k,v in pairs(CustomShipments) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar('level') or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end
			end

			for k,v in pairs(GAMEMODE.AmmoTypes) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar('level') or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end
			end
		end
	end)
end
hook.Add('F4MenuTabs', 'ssslawlda', ButtonColors)
hook.Add('PlayerLevelChanged', 'ilovesophiealsoiamgoingtofuckhertodaybecausesheissatnextome123update:totallyhadanal:update:no', ButtonColors)

end

function PlayerInitialSpawn(ply)
	if SERVER then
		DarkRP.retrievePlayerLevelData(ply)
	end
end

hook.Add('PlayerInitialSpawn', 'plyspwnxxxxin',PlayerInitialSpawn)


