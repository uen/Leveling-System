// Love Manolis Vrondakis. @vrondakis

surface.CreateFont( "HeadBar", { // XP Bar font
	 font = "Tahoma",
	 size = 13,
	 weight = 500,
	 blursize = 0,
	 scanlines = 0,
} )

surface.CreateFont("LevelPrompt", { // Level prompt font
	font = "Francois One",
	size = 70,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
}) 


// I hate this fucking DrawDisplay function. Eurgh.
local function DrawDisplay()
local shouldDraw, players = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_EntityDisplay")
	if shouldDraw == false then return end
	local shootPos = LocalPlayer():GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()
	if(LevelSystemConfiguration.DisplayLevel) then
		for k, ply in pairs(players or player.GetAll()) do
			if not ply:Alive() then continue end
			if ply:GetRenderMode() == RENDERMODE_TRANSALPHA then continue end // player is cloaked (ULX)
			if ply == LocalPlayer() then continue end
			local hisPos = ply:GetShootPos()
			if GAMEMODE.Config.globalshow and ply ~= localplayer then
					local pos = ply:EyePos()
					pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
					pos = pos:ToScreen()
					pos.y = pos.y-20
					draw.DrawText("Level: "..(ply:getDarkRPVar("level") or 0), "DarkRPHUD2", pos.x+1, pos.y -56, Color(0,0,0,255), 1)
					draw.DrawText("Level: "..(ply:getDarkRPVar("level") or 0), "DarkRPHUD2", pos.x, pos.y -55, Color(255,255,255,200), 1)
			elseif not GAMEMODE.Config.globalshow and hisPos:Distance(shootPos) < 250 then
				local pos = hisPos - shootPos
				local unitPos = pos:GetNormalized()
	
					local trace = util.QuickTrace(shootPos, pos, localplayer)
					if trace.Hit and trace.Entity ~= ply then return end
						local pos = ply:EyePos()
						pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
						pos = pos:ToScreen()
						pos.y = pos.y-20
						draw.DrawText("Level: "..(ply:getDarkRPVar("level") or 0), "DarkRPHUD2", pos.x, pos.y -58, Color(0,0,0,255), 1)
						draw.DrawText("Level: "..(ply:getDarkRPVar("level") or 0), "DarkRPHUD2", pos.x+1, pos.y -57, Color(255,255,255,200), 1)
			end
		end
	end
 
	local tr = LocalPlayer():GetEyeTrace()

end
local OldXP = 0
local xp_bar = Material("vrondakis/xp_bar.png","noclamp smooth")
local function HUDPaint()
	if not LevelSystemConfiguration then return end
	local PlayerLevel = LocalPlayer():getDarkRPVar("level")
	local PlayerXP = LocalPlayer():getDarkRPVar("xp")
	
	local percent = ((PlayerXP or 0)/(((10+(((PlayerLevel or 1)*((PlayerLevel or 1)+1)*90))))*LevelSystemConfiguration.XPMult)) // Gets the accurate level up percentage
	
	local drawXP = Lerp(8*FrameTime(),OldXP,percent)
	OldXP = drawXP
	local percent2 = percent*100
	percent2 = math.Round(percent2)
	percent2 = math.Clamp(percent2, 0, 99) //Make sure it doesn't round past 100%
	
	if LevelSystemConfiguration.EnableBar then
		// Draw the XP Bar
		surface.SetDrawColor(0,0,0,200)
		surface.DrawRect(ScrW()/2-300,(LevelSystemConfiguration.XPBarYPos or 0),580,25)
	
		// Draw the XP Bar before the texture
		surface.SetDrawColor(LevelSystemConfiguration.LevelBarColor[1],LevelSystemConfiguration.LevelBarColor[2],LevelSystemConfiguration.LevelBarColor[3],255)
		surface.DrawRect(ScrW()/2-300,(LevelSystemConfiguration.XPBarYPos or 0),580*drawXP,25)

		//Render the texture
		surface.SetMaterial(xp_bar)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect( ScrW()/2-371, 0+(LevelSystemConfiguration.XPBarYPos or 0),  742,46)
	end
	
	// Render the text
	if LevelSystemConfiguration.BarText then
		draw.DrawText("Level "..(LocalPlayer():getDarkRPVar("level") or 0).." - "..percent2 .."%", "HeadBar", ScrW()/2,7+(LevelSystemConfiguration.XPBarYPos or 0),(LevelSystemConfiguration.XPTextColor or Color(255,255,255,255)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	if LevelSystemConfiguration.LevelText then
		draw.SimpleText("Level: " ..(LocalPlayer():getDarkRPVar("level") or 0), "LevelPrompt", LevelSystemConfiguration.LevelTextPos[1],ScrH()-LevelSystemConfiguration.LevelTextPos[2],((Color(0,0,0,255))), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
		draw.SimpleText("Level: " ..(LocalPlayer():getDarkRPVar("level") or 0), "LevelPrompt", LevelSystemConfiguration.LevelTextPos[1]+1,ScrH()-LevelSystemConfiguration.LevelTextPos[2]-1,(LevelSystemConfiguration.LevelColor or (Color(0,0,0,255))), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	end
	
	DrawDisplay()
end
hook.Add("HUDPaint", "manolis:MVLevels:HUDPaintA", HUDPaint) // IS THAT UNIQUE ENOUGH FOR YOU, FUCKING GMOD HOOKING BULLSHIT.


