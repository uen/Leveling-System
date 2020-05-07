function ulx.addXP(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:addXP(amount, true)
	DarkRP.notify(target_ply, 0,4,calling_ply:Nick() .. " gave you "..amount.."XP")
	ulx.fancyLogAdmin(calling_ply, "#A has gave #T an xp amount of #s", target_ply, amount)
end
local addXPx = ulx.command("Levels", "ulx addxp", ulx.addXP, "!addxp")
addXPx:addParam{type=ULib.cmds.PlayerArg}
addXPx:addParam{type=ULib.cmds.NumArg, hint="xp"}
addXPx:defaultAccess(ULib.ACCESS_ADMIN)
addXPx:help("Add XP to a player.")

function ulx.setLevel(calling_ply, target_ply, level)
	if not level then ULib.tsayError("Level not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	DarkRP.storeXPData(target_ply,level,0)
        target_ply:setDarkRPVar("level",level)
        target_ply:setDarkRPVar("xp",0)
	DarkRP.notify(target_ply, 0,4,calling_ply:Nick() .. " set your level to "..level)
	ulx.fancyLogAdmin(calling_ply, "#A has set #T level to #s", target_ply, level)
end
local setLevelx = ulx.command("Levels", "ulx setlevel", ulx.setLevel, "!setlevel")
setLevelx:addParam{type=ULib.cmds.PlayerArg}
setLevelx:addParam{type=ULib.cmds.NumArg, hint="level"}
setLevelx:defaultAccess(ULib.ACCESS_ADMIN)
setLevelx:help("Set a players level.")