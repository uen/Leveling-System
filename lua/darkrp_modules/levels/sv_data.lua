// Love Manolis Vrondakis. @vrondakis
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
	MySQLite.query([[REPLACE INTO darkrp_levels VALUES(]]..MySQLite.SQLStr(ply:UniqueID()) .. [[,'1','0')]])
end


function DarkRP.retrievePlayerLevelData(ply)
	DarkRP.retrievePlayerLevelXP(ply,function(data)
		if not IsValid(ply) then return end
		local info = data and data[1] or {}
		info.xp = (info.xp or 0)
		info.level = (info.level or 1)
		ply:setDarkRPVar('xp', tonumber(info.xp))
		ply:setDarkRPVar('level', tonumber(info.level))
		if not data then DarkRP.createPlayerLevelData(ply) end
	end)
end



function DarkRP.storeXPData(ply, level, xp)
	xp = math.max(xp,0)
	MySQLite.query("UPDATE darkrp_levels SET level = " ..MySQLite.SQLStr(level) ..", xp = "..MySQLite.SQLStr(xp).." WHERE uid = "..MySQLite.SQLStr(ply:UniqueID()))
end



