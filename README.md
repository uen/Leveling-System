DarkRP Leveling System
======================
For DarkRP 2.5.0 and above.
The most popular (and best) leveling system for Garry's Mod!


Features
-------
**7 Money Printers** - They work like normal printers, apart from the fact that they store money and XP. 

**Database Support** - This script integrates directly into DarkRP's database. This means that it works with SQLite and MySQL! No tweaky setup required!

**HUD** - The HUD looks good and provides level infomation to players. The XP bar is animated, and fits right in!

**Easy Installation** - Drag and drop one folder

**Supports future versions of DarkRP** - This script doesn't edit any of DarkRP's core files, so you don't have to worry about reinstalling the script when you update

**ULX Support** - Allows you to set levels and add/remove XP with ULX (optional)

**Huge Configuration** - This script is VERY easy to customize. You can change everything from one file.  


Installation
-------
Drag and drop all 3 folders inside this folder into your servers garrysmod folder. The folders should merge with your current ones.


Level Requirements
--------
If you want to add required levels to jobs or entities or anything like that, add them as you normally would, but add a level parameter. Like this:

![Leveling](http://i.imgur.com/sIputUy.png)

It’s exactly the same for an entity, vehicle or shipment or anything.

If you want to add/edit printers, change settings or anything like that, edit /addons/darkrpmodification/lua/darkrp_modules/sh_config.lua

You can change most things from that file, and also enable a lot of cool stuff


ULX Support:
---------------------
If you want ULX support, go here:http://pastebin.com/raw.php?i=ywki03me
Make a file called levels.lua in /addons/ULX/lua/ulx/modules/sh/ and put everything inside that. Then restart the server. If you don’t have ULX then you can’t set levels unless you make your own script or edit the database. 


