// Love Manolis Vrondakis. @vrondakis
function PlayerDeath(victim, weapon, killer)
	if(LevelSystemConfiguration.KillModule) then
		if(victim != killer) then // Not a suicide
			if(killer:IsPlayer()) then
					if(LevelSystemConfiguration.Friendly) then
						if(killer:getDarkRPVar('level')<=victim:getDarkRPVar('level')) then
								killer:addXP(10*(victim:getDarkRPVar('level') or 1), true)
								killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
								local xpgot = 10*(victim:getDarkRPVar('level') or 1)
								DarkRP.notify(killer, 0,4,'You got '..xpgot..'XP and '..LevelSystemConfiguration.TakeAwayMoneyAmount..'$ for killing '..victim:Nick())
								victim:addMoney(-1000)
								DarkRP.notify(victim, 0,4,'You died and lost $'..LevelSystemConfiguration.TakeAwayMoneyAmount..'!')					
						else 
							DarkRP.notify(killer,0,4,'You killed '..victim:Nick())
						end
					else
						killer:addXP(10*(victim:getDarkRPVar('level') or 1),true)
						killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
						local xpgot = 10*(victim:getDarkRPVar('level') or 1)
						DarkRP.notify(killer, 0,4,'You got '..xpgot..'XP for killing '..victim:Nick())
					end
						
				end
		end
	end
end

hook.Add( "PlayerDeath", "plyded123", PlayerDeath )


function NPCDeath(npc, killer,weapon)
	if(LevelSystemConfiguration.NPCXP) then
		if(npc != killer) then // Not a suicide? Somehow.
			if(killer:IsPlayer()) then
				killer:addXP(LevelSystemConfiguration.NPCXPAmount, true)
				DarkRP.notify(killer, 0,4,'You got '..LevelSystemConfiguration.NPCXPAmount..'XP for killing an NPC.')				
			end
		end
	end
end

hook.Add( "OnNPCKilled", "enpcded123", NPCDeath )

local time = LevelSystemConfiguration.Timertime
timer.Create( "PlayXP", time,0,function()
	if(LevelSystemConfiguration.TimerModule) then
		for k,v in pairs(player.GetAll()) do 
			DarkRP.notify(v,0,4,"You got "..LevelSystemConfiguration.TimerXPAmount.."XP for playing "..LevelSystemConfiguration.YourServerName) 
			v:addXP(100,true)
		end
	end
end)
