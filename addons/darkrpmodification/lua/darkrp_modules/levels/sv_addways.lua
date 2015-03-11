function PlayerDeath(victim, weapon, killer)
	if(LevelSystemConfiguration.KillModule) then
		if(victim != killer) then // Not a suicide
			if(killer:IsPlayer()) then
					if(LevelSystemConfiguration.Friendly) then
						if((killer:getDarkRPVar('level') or 1)<=(victim:getDarkRPVar('level') or 1)) then
								local xpgot=killer:addXP(10*(victim:getDarkRPVar('level') or 1), true)
								killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
								DarkRP.notify(killer, 0,4,'You got '..xpgot..'XP and '..LevelSystemConfiguration.TakeAwayMoneyAmount..'$ for killing '..victim:Nick())
								if(victim:canAfford(LevelSystemConfiguration.TakeAwayMoneyAmount)) then
									victim:addMoney(-LevelSystemConfiguration.TakeAwayMoneyAmount)
									DarkRP.notify(victim, 0,4,'You died and lost $'..LevelSystemConfiguration.TakeAwayMoneyAmount..'!')					
								end
						else 
							DarkRP.notify(killer,0,4,'You killed '..victim:Nick())
						end
					else
						local xpgot = killer:addXP(10*(victim:getDarkRPVar('level') or 1),true)
						killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
						DarkRP.notify(killer, 0,4,'You got '..xpgot..'XP for killing '..victim:Nick())
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
				local XP = killer:addXP(LevelSystemConfiguration.NPCXPAmount, true)
				DarkRP.notify(killer, 0,4,'You got '..XP..'XP for killing an NPC.')				
			end
		end
	end
end

hook.Add( "OnNPCKilled", "manolis:MVLevels:OnNPCKilledBC", NPCDeath )

local time = LevelSystemConfiguration.Timertime
timer.Create( "PlayXP", time,0,function()
	if(LevelSystemConfiguration.TimerModule) then
		for k,v in pairs(player.GetAll()) do 
			local XP = v:addXP(100,true)
			if(XP) then
				DarkRP.notify(v,0,4,"You got "..XP.."XP for playing "..LevelSystemConfiguration.YourServerName) 
			end
		end
	end
end)
