// Do not edit these values, as they will be overridden with the values in config.lua. 

LevelSystemConfiguration = {}


Printers = {} 
XPBooks = {}

LevelSystemConfiguration.EnableHUD = true 
LevelSystemConfiguration.LevelColor = Color(255,255,255,255)
LevelSystemConfiguration.XPTextColor = Color(255,255,255,255) 
LevelSystemConfiguration.LevelBarColor = {6,116,255} 
LevelSystemConfiguration.LevelTextPos = {1.5, 180} 

LevelSystemConfiguration.GreenJobBars = true 
LevelSystemConfiguration.GreenAllBars = true


LevelSystemConfiguration.KillModule = true 
LevelSystemConfiguration.Friendly = true
LevelSystemConfiguration.TakeAwayMoneyAmount = 1000
LevelSystemConfiguration.NPCXP = true 
LevelSystemConfiguration.NPCXPAmount = 10 
LevelSystemConfiguration.TimerModule = false 
LevelSystemConfiguration.Timertime = 100 
LevelSystemConfiguration.TimerXPAmount = 10 
LevelSystemConfiguration.YourServerName = "this server"
LevelSystemConfiguration.XPMult = 1 
LevelSystemConfiguration.MaxLevel = 99 
LevelSystemConfiguration.ContinueXP = false
LevelSystemConfiguration.PrinterSound = true 
LevelSystemConfiguration.PrinterMaxP = 4 
LevelSystemConfiguration.PrinterMax = 4 
LevelSystemConfiguration.PrinterOverheat = false 
LevelSystemConfiguration.PrinterTime = 120 
LevelSystemConfiguration.KeepThisToTrue = true
LevelSystemConfiguration.Epilepsy = false



AddCSLuaFile('config.lua')
include('config.lua')


AddCSLuaFile('printers.lua')
AddCSLuaFile('books.lua')

include('books.lua')
include('printers.lua')

hook.Add("loadCustomDarkRPItems", "manolis:MVLevels:CustomLoad", function()
	for k,v in pairs(XPBooks) do
		local Errors = {}
		if not type(v.Name) == 'string' then table.insert(Errors, 'The name of an XP Book is INVALID!') end
		if not type(v.Type) == 'string' then table.insert(Errors, 'The name of an XP Book is INVALID!') end
		if not type(v.Model) == 'string' then table.insert(Errors, 'The model of an XP Book is INVALID!') end
		if not type(v.XPOnUse) == 'number' then table.insert(Errors, 'The XPOnUse of an XP Book is INVALID!') end
		if not type(v.Level) == 'number' then table.insert(Errors, 'The level of an XP Book is INVALID!') end
		if not type(v.Allowed) == 'table' then table.insert(Errors, 'The allowed of an XP Book is INVALID!') end
		if not type(v.Price) == 'number' then table.insert(Errors, 'The price of an XP Book is INVALID!') end
		local ErrorCount = 0
		for k,v in pairs(Errors) do
			error(v)
			ErrorCount = ErrorCount + 1
		end

		if not(ErrorCount==0) then return false end
		DarkRP.createEntity(v.Name,{
			ent="vrondakis_book",
			model=v.Model,
			price=v.Price,
			level=v.Level,
			allowed=table.Copy(v.Allowed),
			cmd=v.Type,
			max = 4,
			prestige=(v.Prestige or 0),
			customCheck = (v.CustomCheck or function() return true end),
			GiveXPAmountOnUse = v.XPOnUse,
		})
	end


	for k,v in pairs(Printers) do
		local Errors = {}
		if not type(v.Name) == 'string' then table.insert(Errors, 'The name of a printer is INVALID!') end
		if not type(v.Type) == 'string' then table.insert(Errors, 'The type of a printer is INVALID!') end
		if not type(v.XPPerPrint) == 'number' then table.insert(Errors, 'The XP of a printer is INVALID!') end
		if not type(v.MoneyPerPrint) == 'number' then table.insert(Errors, 'The money of a printer is INVALID!') end
		if not type(v.Color) == 'table' then table.insert(Errors, 'The color of a printer is INVALID!') end
		if not type(v.Model) == 'string' then table.insert(Errors, 'The model of a printer is INVALID!') end
		if not type(v.Price) == 'number' then table.insert(Errors, 'The price of a printer is INVALID!') end
		if not type(v.Level) == 'number' then table.insert(Errors, 'The level of a printer is INVALID!') end
		local ErrorCount = 0
		for k,v in pairs(Errors) do
			error(v)
			ErrorCount = ErrorCount + 1
		end

		if not(ErrorCount==0) then return false end
			
		DarkRP.createEntity(v.Name,{
			ent = "vrondakis_printer",
			model = v.Model,
			price = v.Price,
			prestige = (v.Prestige or 0),
			printer = true,
			level = v.Level,
			max = LevelSystemConfiguration.PrinterMax,
			cmd = 'buyvrondakis'..v.Type..'printer',
			vrondakisName = v.Name,
			vrondakisType = v.Type,
			vrondakisXPPerPrint = v.XPPerPrint,
			vrondakisMoneyPerPrint = v.MoneyPerPrint,
			vrondakisColor = v.Color,
			vrondakisModel = v.Model,
			customCheck = (v.CustomCheck or function() return true end),
			vrondakisOverheat = LevelSystemConfiguration.PrinterOverheat,
			PrinterMaxP = LevelSystemConfiguration.PrinterMaxP,
			vrondakisPrinterTime = LevelSystemConfiguration.PrinterTime,
			vrondakisIsBuyerRetarded = LevelSystemConfiguration.KeepThisToTrue,
			vrondakisEpileptic = LevelSystemConfiguration.Epilepsy
		})

	end

end)


DarkRP.registerDarkRPVar("xp", net.WriteDouble, net.ReadDouble)
DarkRP.registerDarkRPVar("level", net.WriteDouble, net.ReadDouble)
DarkRP.registerDarkRPVar("prestige", net.WriteDouble, net.ReadDouble)




