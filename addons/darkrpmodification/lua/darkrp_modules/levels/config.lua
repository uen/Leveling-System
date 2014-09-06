LevelSystemConfiguration = {} // Leave this line.
local Printers = {} // Leave this line.
local XPBooks = {} // And this



// Okay so, clientside settings first, such as the HUD.							

LevelSystemConfiguration.EnableHUD = true // Is the HUD enabled?
LevelSystemConfiguration.LevelColor = Color(255,255,255,255) // The color of the "Level: 1" HUD element. White looks best. (This setting is nullified if you have the prestige system)
LevelSystemConfiguration.XPTextColor = Color(255,255,255,255) // The color of the XP percentage HUD element.
LevelSystemConfiguration.LevelBarColor = {6,116,255} // The color of the XP bar. (Sorry this one is different. It is still RGB)
LevelSystemConfiguration.LevelTextPos = {1.5, 170} // The position of the LevelText. Y starts from bottom. Fiddle with it

LevelSystemConfiguration.GreenJobBars = true // Are the green bars at the bottom of jobs enabled? KEEP THIS TRUE! 
LevelSystemConfiguration.GreenAllBars = true // Are the green bars at the bottom of everything but jobs enabled? I WOULD VERY MUCH RECCOMEND THIS TO BE TRUE.

//Now, let us configure the ways (other than printers) that players get XP
LevelSystemConfiguration.KillModule = true // Give XP + Money for kills! // Next 2 settings control this.
LevelSystemConfiguration.Friendly = true // Only take away money / give XP if the killer is a lower level/same level than the victim. KEEP THIS TO TRUE UNLESS YOU WANT A STUPID RDM MINGEFEST SERVER.
LevelSystemConfiguration.TakeAwayMoneyAmount = 1000 // How much money to take away from players when they are killed and add to the killer. You can change this to 0 if none. The XP amount is dynamic.

LevelSystemConfiguration.NPCXP = true // Give XP when an NPC is killed?
LevelSystemConfiguration.NPCXPAmount = 10 // Amount of XP to give when an NPC is killed

LevelSystemConfiguration.TimerModule = false // Give XP to everybody every howeverlong
LevelSystemConfiguration.Timertime = 100 // How much time (in seconds) until everybody gets given XP
LevelSystemConfiguration.TimerXPAmount = 10 // How much XP to give each time it goes off
LevelSystemConfiguration.YourServerName = "this sexy server" // The notifcation text ish. "You got 100XP for playing on this sexy server"

//Next, general settings
LevelSystemConfiguration.XPMult = 1 // How hard it is to level up. 2 would require twice as much XP, ect.
LevelSystemConfiguration.MaxLevel = 99 // The max level
LevelSystemConfiguration.ContinueXP = false // If remaining XP continues over to next levels. I recommend this to be false. Seriously. What if a level 1 gets 99999999 XP somehow? He is level 99 so quickly.

//Printer settings
LevelSystemConfiguration.PrinterSound = true // Give the printers sounds?
LevelSystemConfiguration.PrinterMaxP = 4 // How many times a printer can print before stopping. Change this to 0 if you want infine.
LevelSystemConfiguration.PrinterMax = 4 // How many printers of a certain type a player can own at any one time
LevelSystemConfiguration.PrinterOverheat = false // Can printers overheat?
LevelSystemConfiguration.PrinterTime = 120 // How long it takes printers to print
LevelSystemConfiguration.KeepThisToTrue = true // Can players collect from printers that are 5 levels above their level? PLEASE KEEP THIS TRUE FOR GOD SAKE
LevelSystemConfiguration.Epilepsy = false // If printers flash different colors when they have money in them. (This is only added because somebody will complain about the removal of the green printers.)

//Let us add/change printers! Super easily!

/*TEMPLATE CODE/*
local Printer= {} // Leave this line
Printer.Name = 'Your Printer Name'
Printer.Type = 'yourprintername' // A UNIQUE identifier STRING, can be anything. NO SPACES! The player does not see this.
Printer.XPPerPrint = 10 // How much XP to give a player every time they print.
Printer.MoneyPerPrint = 50 // How much money to give a player every time they print.
Printer.Color = Color(255,255,255,255) // The color of the printer. Setting it to (255,255,255,255) will make it the normal prop color.
Printer.Model = 'models/props_lab/reciever01b.mdl' // The model of the printer. To find the path of a model, right click it in the spawn menu and click "Copy to Clipboard"
Printer.Prestige = 0 // The prestige you have to be to buy the printer. Only works with the prestige DLC.
table.insert(Printers,Printer) // Leave this line
*/

// Here are the default printers:

local Printer={}
Printer.Name = 'Regular Printer'
Printer.Type = 'regularprinter'
Printer.XPPerPrint = 65
Printer.MoneyPerPrint = 100
Printer.Color = Color(255,255,255,255)
Printer.Model = 'models/props_lab/reciever01b.mdl'
Printer.Price = 1000
Printer.Level = 1
Printer.Prestige = 0

table.insert(Printers,Printer)

local Printer={}
Printer.Name = 'Golden Money Printer'
Printer.Type = 'goldenprinter'
Printer.XPPerPrint = 300
Printer.MoneyPerPrint = 300
Printer.Color = Color(255,215,0)
Printer.Model = 'models/props_lab/reciever01b.mdl'
Printer.Price = 3000
Printer.Level = 10
Printer.Prestige = 0
table.insert(Printers,Printer)

local Printer={}
Printer.Name = 'Ruby Money Printer'
Printer.Type = 'rubyprinter'
Printer.XPPerPrint = 1069
Printer.MoneyPerPrint = 1200
Printer.Color = Color(255,0,0)
Printer.Model = 'models/props_lab/reciever01a.mdl'
Printer.Price = 5000
Printer.Level = 20
Printer.Prestige = 0
table.insert(Printers,Printer)

local Printer={}
Printer.Name = 'Platinum Money Printer'
Printer.Type = 'platprinter'
Printer.XPPerPrint = 1800
Printer.MoneyPerPrint = 1500
Printer.Color = Color(255,255,255)
Printer.Model = 'models/props_c17/consolebox03a.mdl'
Printer.Price = 10000
Printer.Level = 30
Printer.Prestige = 0
table.insert(Printers,Printer)

local Printer={}
Printer.Name = 'Diamond Money Printer'
Printer.Type = 'diamondprinter'
Printer.XPPerPrint = 2500
Printer.MoneyPerPrint = 5000
Printer.Color = Color(135,200,250)
Printer.Model = 'models/props_c17/consolebox01a.mdl'
Printer.Price = 50000
Printer.Level = 40
Printer.Prestige = 0
table.insert(Printers,Printer)


local Printer={}
Printer.Name = 'Emerald Money Printer'
Printer.Type = 'emeraldprinter'
Printer.XPPerPrint = 3550
Printer.MoneyPerPrint = 10000
Printer.Color = Color(0,100,0)
Printer.Model = 'models/props_c17/consolebox01a.mdl'
Printer.Price = 100000
Printer.Level = 50
Printer.Prestige = 0
table.insert(Printers,Printer)

local Printer={}
Printer.Name = 'Unubtainium Money Printer'
Printer.Type = 'unubprinter'
Printer.XPPerPrint = 3500
Printer.MoneyPerPrint = 15000
Printer.Color = Color(255,255,255)
Printer.Model = 'models/props_lab/harddrive01.mdl'
Printer.Price = 120000
Printer.Level = 60
Printer.Prestige = 0
table.insert(Printers,Printer)

//XP books! PLEASE DO NOT HAVE THESE. THEY LINK MONEY DIRECTLY TO XP WHICH IS VERY BAD! IF YOU WANT A GOOD SERVER, KEEP IT OFF. Some people wanted them. For some reason.
// Also, do not allow people to donate for a free prestige. That is retarded. Also, buy my prestige system. 
// They are books that you can purchase from the F4 menu that give you XP. (Love you Xeviax)


//If you are having trouble with books, aka them not showing up in the F4 menu, then put the code for the job at the top of this file.

/*TEMPLATE CODE/*


local Book={}
Book.Name = 'Your Book Name'
Book.XPOnUse = 1000 // The amount of XP to give when E is pressed on the book
Book.Model = "models/props_lab/bindergraylabel01a.mdl" // The model of the book
Book.Level = 1 // The level required to purchase it
Book.Price = 10000 // The price of the book
Book.Allowed = {} // The teams allowed to purchase the book. 
Book.Type = 'yourbookname' // A unique identifier (NO SPACES!)
Book.CustomCheck = function() end // Some custom check here. For VIP books and stuff. 
Book.Prestige = 0 // The prestige required to purchase the book. Only works with my prestige DLC.
table.insert(XPBooks,Book) // Leave this :)


*/

// A sample book: (Remove the /* and */ if you want to use this one.)
/*
local Book={}
Book.Name = '1000XP Book'
Book.XPOnUse = 1000
Book.Type = '1000xpbookxoxo'
Book.Model = "models/props_lab/bindergraylabel01a.mdl"
Book.Level = 1 
Book.Allowed = {TEAM_CITIZEN}
Book.Price = 10000
table.insert(XPBooks,Book)
*/




// Leave this. Seriously, if you edit this and break it some how, I am not going to help you.


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
			allowed=v.Allowed,
			cmd=v.Type,
			max = 4,
			prestige=(v.Prestige or 0),
			customCheck = (v.CustomCheck or function() end),
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
			vrondakisOverheat = LevelSystemConfiguration.PrinterOverheat,
			PrinterMaxP = LevelSystemConfiguration.PrinterMaxP,
			vrondakisPrinterTime = LevelSystemConfiguration.PrinterTime,
			vrondakisIsBuyerRetarded = LevelSystemConfiguration.KeepThisToTrue,
			vrondakisEpileptic = LevelSystemConfiguration.Epilepsy
		})

	end



