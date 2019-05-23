function PlayerDeath(victim, weapon, killer)
	if(LevelSystemConfiguration.KillModule) then
		if(victim != killer) then // Not a suicide
			if(killer:IsPlayer()) then
					local Lvictim = victim:Nick()
					local Lmoney = DarkRP.formatMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
					if(LevelSystemConfiguration.Friendly) then
						if((killer:getDarkRPVar('level') or 1)<=(victim:getDarkRPVar('level') or 1)) then
								local xpgot=killer:addXP(10*(victim:getDarkRPVar('level') or 1), true)
								killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
								DarkRP.notify(killer, 0,4,LevelSystemConfiguration.LangKillNotify)
								if(victim:canAfford(LevelSystemConfiguration.TakeAwayMoneyAmount)) then
									victim:addMoney(-LevelSystemConfiguration.TakeAwayMoneyAmount)
									DarkRP.notify(victim, 0,4,LevelSystemConfiguration.LangDeath)					
								end
						else 
							DarkRP.notify(killer,0,4,LevelSystemConfiguration.LangKillNotify2)
						end
					else
						local xpgot = killer:addXP(10*(victim:getDarkRPVar('level') or 1),true)
						killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
						DarkRP.notify(killer, 0,4,LevelSystemConfiguration.LangKillNotify3)
					end
						
				end
		end
	end
end

hook.Add( "PlayerDeath", "manolis:MVLevels:PlayerDeathBC", PlayerDeath )


function NPCDeath(npc, killer,weapon)
	if(LevelSystemConfiguration.NPCXP) then
		if(npc != killer) then // Not a suicide? Somehow.
			if(killer:IsPlayer()) then
				local XP = killer:addXP(npc:GetVar("GiveXP") or LevelSystemConfiguration.NPCXPAmount, true)
				if(XP) then
					DarkRP.notify(killer, 0,4,LevelSystemConfiguration.LangKillNPC)
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
			if string.find(v:GetUserGroup(), LevelSystemConfiguration.TimerXPVipGroups) then
				local XP = v:addXP(LevelSystemConfiguration.TimerXPAmountVip, true)
			else
				local XP = v:addXP(LevelSystemConfiguration.TimerXPAmount, true)
			end
			if(XP) then
				DarkRP.notify(v,0,4,LevelSystemConfiguration.LangPlayOn) 
			end
		end
	end
end)
