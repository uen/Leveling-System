// You can add/change XP Books in this file.    



/*Template Code/*
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

// Here's a sample book you can use (Remove the /* and */ if you want to use this one.)
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
