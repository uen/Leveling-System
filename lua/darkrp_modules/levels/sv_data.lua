// Love Manolis Vrondakis. @vrondakis

if (guthlogsystem) then
	guthlogsystem.addCategory( "DarkRP Leveling System", Color(255, 0, 255) )
end

function DarkRPInit()	
		MySQLite.query([[CREATE TABLE IF NOT EXISTS darkrp_levels(
				uid VARCHAR(32) NOT NULL,
				level int NOT NULL,
				xp int NOT NULL,
				UNIQUE(uid) 
			);
		]])
end
hook.Add("DarkRPDBInitialized", "manolis:MVLevels:DarkRPDBInitializedBB", DarkRPInit)

function DarkRP.retrievePlayerLevelXP(ply, callback)
	MySQLite.query("SELECT level,xp FROM darkrp_levels WHERE uid = ".. MySQLite.SQLStr(ply:UniqueID())..";", function(r)callback(r)end)
end

function DarkRP.createPlayerLevelData(ply)
	MySQLite.query([[REPLACE INTO darkrp_levels VALUES(]]..MySQLite.SQLStr(ply:UniqueID()) .. [[,"1","0")]])
end


function DarkRP.retrievePlayerLevelData(ply)
	DarkRP.retrievePlayerLevelXP(ply,function(data)
		if not IsValid(ply) then return end
		local info = data and data[1] or {}
		info.xp = (info.xp or 0)
		info.level = (info.level or 1)
		ply:setDarkRPVar("xp", tonumber(info.xp))
		ply:setDarkRPVar("level", tonumber(info.level))
		if not data then DarkRP.createPlayerLevelData(ply) end
	end)
end



function DarkRP.storeXPData(ply, level, xp)
	xp = math.max(xp,0)
	MySQLite.query("UPDATE darkrp_levels SET level = " ..MySQLite.SQLStr(level) ..", xp = "..MySQLite.SQLStr(xp).." WHERE uid = "..MySQLite.SQLStr(ply:UniqueID()))
end

local function resetAllXP(ply, cmd, args)
    if ply:EntIndex() ~= 0 and not ply:IsSuperAdmin() then return end
    MySQLite.query("UPDATE darkrp_levels SET level = 1 ;")
    MySQLite.query("UPDATE darkrp_levels SET xp = 0 ;")
    for _, v in ipairs(player.GetAll()) do
        v:setDarkRPVar("level", 1)
        v:setDarkRPVar("xp", 0)
    end
    if ply:IsPlayer() then
        DarkRP.notifyAll(0, 4, "Levels have been reseted by an administrator")
    else
        DarkRP.notifyAll(0, 4, "Levels have been reseted by the console")
    end
end
concommand.Add("rp_resetallxp", resetAllXP)



