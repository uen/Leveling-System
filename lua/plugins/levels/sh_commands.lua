local plugin = plugin

local command = {}
command.help = "Give XP to a player."
command.command = "addxp"
command.arguments = {"player", "amount"}
command.bDisallowConsole = false
command.bSingleTarget = true
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"xp"}
command.permissions = {"Set XP"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)
	local amount = tonumber(arguments[2]) or -1
	
	if amount == -1 then return	end
	
	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		target:addXP(amount)
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " has given  ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, " " .. tostring(amount) .. " XP.")
		end
	end
end
plugin:AddCommand(command)

command = {}
command.help = "Set a player's current level."
command.command = "setlevel"
command.arguments = {"player", "amount"}
command.bDisallowConsole = false
command.bSingleTarget = true
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"level"}
command.permissions = {"Set XP"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)
	local amount = tonumber(arguments[2]) or -1
	
	if amount == -1 then return	end
	
	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		DarkRP.storeXPData(target, amount, 0)
        target:setDarkRPVar("level", amount)
        target:setDarkRPVar("xp", 0)
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " set  ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, " level to " .. tostring(amount))
		end
	end
end
plugin:AddCommand(command)

command = {}
command.help = "Give player a number of levels."
command.command = "addlevels"
command.arguments = {"player", "amount"}
command.bDisallowConsole = false
command.bSingleTarget = true
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"levels", "givelevels"}
command.permissions = {"Set XP"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)
	local amount = tonumber(arguments[2]) or -1
	
	if amount == -1 then return	end
	
	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		local level = target:getDarkRPVar("level") or 0
		DarkRP.storeXPData(target, level + amount, 0)
        target:setDarkRPVar("level", level + amount)
        target:setDarkRPVar("xp", 0)
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " gave  ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, tostring(amount) .. " levels.")
		end
	end
end
plugin:AddCommand(command)