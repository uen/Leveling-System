include("shared.lua")


surface.CreateFont("TargetID", {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
	antialias = true,
})
function ENT:Initialize()
	self.PrinterName = self:GetNWString("PrinterName") // Why is self.DarkRPItem not clientside?
	self.PrinterType = self:GetNWString("PrinterType")
end


function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")
	local amount = "Unknown"
	if(self:GetNWInt("MaxConfig") == 0) then
		amount = DarkRP.formatMoney(self:GetNWInt("MoneyAmount"))
	else
		amount = (DarkRP.formatMoney(self:GetNWInt("MoneyAmount")).." / "..DarkRP.formatMoney(self:GetNWInt("MaxConfig")*self:GetNWInt("MoneyPerPrint")))
	end

	surface.SetFont("HUDNumber5")
	local text = self:GetNWString("PrinterName", "Unknown")
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner)
	local TextWidth3 = surface.GetTextSize(amount)

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
		draw.WordBox(2, -TextWidth*0.5, -30, text, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5, 18, owner, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth3*0.5, 60, amount, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))

		
	cam.End3D2D()
end


function ENT:Think()
end
