// You can add/change printers in this file.


/*Template Code/*
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

// Default printers:

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
