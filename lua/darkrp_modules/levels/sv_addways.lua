function PlayerDeath(victim, weapon, killer)
	if(LevelSystemConfiguration.KillModule) then
		if(victim != killer) then -- Not a suicide
			if(killer:IsPlayer()) then
				local victime = victim:Nick()
				local money = DarkRP.formatMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
				local XP = killer:addXP(10*(victim:getDarkRPVar('level') or 1), true)
					
				if(LevelSystemConfiguration.Friendly) then
					if((killer:getDarkRPVar('level') or 1)<=(victim:getDarkRPVar('level') or 1)) then
						killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
						DarkRP.notify(killer, 0,4, string.format( LevelSystemConfiguration.LangKillNotify, XP, money, victime ))
						
						if(victim:canAfford(LevelSystemConfiguration.TakeAwayMoneyAmount)) then
							victim:addMoney(-LevelSystemConfiguration.TakeAwayMoneyAmount)
							DarkRP.notify(victim, 0,4, string.format( LevelSystemConfiguration.LangDeath, money ))					
						end
					else 
						DarkRP.notify(killer,0,4, string.format( LevelSystemConfiguration.LangKillNotify2, XP, victime ))
					end
				else
					killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
					DarkRP.notify(killer, 0,4, string.format( LevelSystemConfiguration.LangKillNotify3, victime ))
				end
			end
		end
	end
end

hook.Add( "PlayerDeath", "manolis:MVLevels:PlayerDeathBC", PlayerDeath )


function NPCDeath(npc, killer,weapon)
	if(LevelSystemConfiguration.NPCXP) then
		if(npc != killer) then -- Not a suicide? Somehow.
			if(killer:IsPlayer()) then
				local XP = killer:addXP(npc:GetVar("GiveXP") or LevelSystemConfiguration.NPCXPAmount, true)
				if(XP) then
					DarkRP.notify(killer, 0,4, string.format( LevelSystemConfiguration.LangKillNPC, XP ))
				end
			end
		end
	end
end

hook.Add( "OnNPCKilled", "manolis:MVLevels:OnNPCKilledBC", NPCDeath )

local time = LevelSystemConfiguration.Timertime
timer.Create( "PlayXP", time,0,function()
	if(LevelSystemConfiguration.TimerModule) then
		for k,v in pairs(player.GetAll()) do 
			local XP = v:addXP(LevelSystemConfiguration.TimerXPAmount, true)
			if(XP) then
				local servername = LevelSystemConfiguration.YourServerName
				DarkRP.notify(v,0,4, string.format( LevelSystemConfiguration.LangPlayOn, XP, servername ))
			end
		end
	end
end)

/* -- broken for vips
local time = LevelSystemConfiguration.Timertime
timer.Create( "PlayXP", time,0,function()
	if(LevelSystemConfiguration.TimerModule) then
		for k,v in pairs(player.GetAll()) do 
			if string.find(v:GetUserGroup(), LevelSystemConfiguration.TimerXPVipGroups) then
				local XP = v:addXP(LevelSystemConfiguration.TimerXPAmountVip, true)
			else
				local XP = v:addXP(LevelSystemConfiguration.TimerXPAmount, true)
			end
			if(XP) then
				local servername = LevelSystemConfiguration.YourServerName
				DarkRP.notify(v,0,4, string.format( LevelSystemConfiguration.LangPlayOn, XP, servername )) 
			end
		end
	end
end)*/