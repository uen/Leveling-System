surface.CreateFont("Vrondakis.XPBarLevelFont", {
    font = "Roboto",
    size = ScreenScale(12)
})

surface.CreateFont("Vrondakis.XPBarLevelFont", {
    font = "Roboto",
    size = ScreenScale(12)
})

surface.CreateFont("Vrondakis.XPBarText", {
    font = "Roboto",
    size = ScreenScale(5.75)
})

local PANEL = {}

function PANEL:Init()
    -- Animiation init
    --self.startBarAnim = 0

    self.viewingTime = 0
    --self:SetViewingTime(self.viewingTime)

    -- Box area where the level will reside
    
    self.levelArea = self:Add("DPanel")
    self.levelArea:Dock(LEFT)
    self.levelArea:SetWide(100)

    self.levelArea.Paint = function(me, w, h)
        draw.RoundedBox(8, 0, 0, w, h, LevelSystemConfiguration.AlternativeBarBGColor)

        if not self.currentLevel then return end
        draw.SimpleText(self.currentLevel, "Vrondakis.XPBarLevelFont", w / 2, h / 2, Color(210, 210, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    -- The actual xp bar
    
    self.xpBar = self:Add("DPanel")
    self.xpBar:Dock(FILL)
    self.xpBar:DockMargin(0, self.levelArea:GetTall() * 1.8, 0, self.levelArea:GetTall() * 1.8)

    self.xpBar.Paint = function(me, w, h)
        draw.RoundedBoxEx(4, 0, 0, w, h, LevelSystemConfiguration.AlternativeBarBGColor, false, true, false, true)
        
        if not self.oldXP or not self.newXP or not self.maxXP then return end
        
        local xpWidthMultiplier = math.Clamp(self.newXP / self.maxXP, 0, 1)
        local barColor = Color(LevelSystemConfiguration.LevelBarColor.r,LevelSystemConfiguration.LevelBarColor.g,LevelSystemConfiguration.LevelBarColor.b)
        draw.RoundedBoxEx(4, 0, 0, w * xpWidthMultiplier, h, barColor, false, false, false, false)

        if LevelSystemConfiguration.BarText then
            local text = ""

            if LevelSystemConfiguration.BarTextPercentage then
                local percent = xpWidthMultiplier * 100
                percent = math.Round(percent)
                percent = math.Clamp(percent, 0, 99)

                text = percent .. "%"
            else
                text = self.newXP .. " / " .. self.maxXP
            end
            
            draw.SimpleText(text, "Vrondakis.XPBarText", w / 2, h / 2, LevelSystemConfiguration.XPTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

function PANEL:SetData(oldXP, newXP, maxXP, currentLevel)
    self.oldXP = oldXP
    self.newXP = newXP
    self.maxXP = maxXP
    self.currentLevel = currentLevel

    -- Animation stuff
    --[[self.barPercent = math.Clamp(self.newXP / self.maxXP, 0, 1)
    self.barPercent = Lerp(8 * FrameTime(), self.startBarAnim, self.barPercent)
    self.startBarAnim = self.barPercent

    print(self.barPercent)--]]
end

function PANEL:SetViewingTime(time)
    time = time or 5
    self.viewingTime = time
    self.removeTime = CurTime() + time
end

function PANEL:ResetViewingTime()
    self:SetViewingTime(self.viewingTime)
end

function PANEL:Think()
    if self.viewingTime <= 0 then return end
    
    if self.removeTime and CurTime() > self.removeTime then
        self:Remove()
    end
end

function PANEL:Paint()
end

vgui.Register("Vrondakis.XPBar", PANEL, "DPanel")