local function PlayerDeath(victim, weapon, killer)
	if (LevelSystemConfiguration.KillModule) then
		if (victim != killer) then -- Not a suicide
			if (killer:IsPlayer()) then
				local victime = victim:Nick()
				local money = DarkRP.formatMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
				local XP = killer:addXP( 10 * (victim:getDarkRPVar("level") or 1), true)

				if (LevelSystemConfiguration.Friendly) then
					if ((killer:getDarkRPVar("level") or 1) <= (victim:getDarkRPVar("level") or 1)) then
						killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
						DarkRP.notify(killer, 0,4, DarkRP.getPhrase("lvl_kill_notify", XP, money, victime))
						if guthlogsystem then
							guthlogsystem.addLog( "DarkRP Leveling System", "*"..killer.."* got &"..XP.."& XP and &"..money.."& for killing ?"..victime.."?" )
						end

						if (victim:canAfford(LevelSystemConfiguration.TakeAwayMoneyAmount)) then
							victim:addMoney(-LevelSystemConfiguration.TakeAwayMoneyAmount)
							DarkRP.notify(victim, 0,4, DarkRP.getPhrase("lvl_death", money))
						end
					else 
						DarkRP.notify(killer,0,4, DarkRP.getPhrase("lvl_kill_notify2", XP, victime))
						if guthlogsystem then
							guthlogsystem.addLog( "DarkRP Leveling System", "*"..killer:Name().."* got &"..XP.."& XP for killing ?"..victime.."?" )
						end
					end
				else
					killer:addMoney(LevelSystemConfiguration.TakeAwayMoneyAmount)
					DarkRP.notify(killer, 0,4, DarkRP.getPhrase("lvl_kill_notify3", victime))
                    if guthlogsystem then
						guthlogsystem.addLog( "DarkRP Leveling System", "*"..killer:Name().."* got &0& XP ?"..victime.."? (Friendly mode no XP gain)")
                    end
				end
			end
		end
	end
end

hook.Add( "PlayerDeath", "manolis:MVLevels:PlayerDeathBC", PlayerDeath )


local function NPCDeath(npc, killer,weapon)
	if (LevelSystemConfiguration.NPCXP) then
		if (npc != killer) then -- Not a suicide? Somehow.
			if (killer:IsPlayer()) then
				local XP = killer:addXP(npc:GetVar("GiveXP") or LevelSystemConfiguration.NPCXPAmount, true)
				if (XP) then
					DarkRP.notify(killer, 0,4, DarkRP.getPhrase("lvl_kill_npc", XP))
                    if guthlogsystem then
						guthlogsystem.addLog( "DarkRP Leveling System", "*"..killer:Name().."* got &"..XP.."& XP for killing an NPC" )
                    end
				end
			end
		end
	end
end

hook.Add( "OnNPCKilled", "manolis:MVLevels:OnNPCKilledBC", NPCDeath )


if (LevelSystemConfiguration.BoughtXP) then
	local function BoughtXP(ply, ent, price)
		local XP = 0.1 * ent.price
		ply:addXP(XP, true)
		if guthlogsystem then
			guthlogsystem.addLog( "DarkRP Leveling System", "*"..ply:Name().."* got &"..XP.."& XP for buying ?"..ent.name.."?" )
		end
	end
	
	hook.Add("playerBoughtPistol", "manolis:MVLevels:PistolBought", BoughtXP)
	hook.Add("playerBoughtAmmo", "manolis:MVLevels:AmmoBought", BoughtXP)
	hook.Add("playerBoughtShipment", "manolis:MVLevels:ShipmentBought", BoughtXP)
	hook.Add("playerBoughtCustomEntity", "manolis:MVLevels:CEntityBought", BoughtXP)
end


local time = LevelSystemConfiguration.Timertime
timer.Create( "PlayXP", time,0,function()
	if (LevelSystemConfiguration.TimerModule) then
		for k,v in pairs(player.GetAll()) do
			if IsValid(GetConVar("aafk_enabled")) and GetConVar("aafk_enabled"):GetBool() == true then
				if v:GetNWBool( "aafk_away" ) == false then
					if table.HasValue(LevelSystemConfiguration.TimerXPVipGroups, v:GetNWString("usergroup")) then
						local XP = v:addXP(LevelSystemConfiguration.TimerXPAmountVip, true)
						if (XP) then
							DarkRP.notify(v,0,4, DarkRP.getPhrase("lvl_play_on", XP))
						end
					else
						local XP = v:addXP(LevelSystemConfiguration.TimerXPAmount, true)
						if (XP) then
							DarkRP.notify(v,0,4, DarkRP.getPhrase("lvl_play_on", XP))
						end
					end
				end
			else
				if table.HasValue(LevelSystemConfiguration.TimerXPVipGroups, v:GetNWString("usergroup")) then
					local XP = v:addXP(LevelSystemConfiguration.TimerXPAmountVip, true)
					if (XP) then
						DarkRP.notify(v,0,4, DarkRP.getPhrase("lvl_play_on", XP))
					end
				else
					local XP = v:addXP(LevelSystemConfiguration.TimerXPAmount, true)
					if (XP) then
						DarkRP.notify(v,0,4, DarkRP.getPhrase("lvl_play_on", XP))
					end
				end
			end
		end
		if guthlogsystem then
			guthlogsystem.addLog( "DarkRP Leveling System", "*Everyone* got &"..LevelSystemConfiguration.TimerXPAmount.."& or !"..LevelSystemConfiguration.TimerXPAmountVip.."! XP depending of their rank" )
		end
	end
end)