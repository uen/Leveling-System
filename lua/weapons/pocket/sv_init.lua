local meta = FindMetaTable("Player")
if not(DarkRP) then return false end

/*---------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------*/
-- workaround: GetNetworkVars doesn't give entities because the /duplicator/ doesn"t want to save entities
local function getDTVars(ent)
	if not ent.GetNetworkVars then return nil end
	local name, value = debug.getupvalue(ent.GetNetworkVars, 1)
	if name ~= "datatable" then
		ErrorNoHalt("Warning: Datatable cannot be stored properly in pocket. Tell a developer!")
	end

	local res = {}

	for k,v in pairs(value) do
		res[k] = v.GetFunc(ent, v.index)
	end

	return res
end

local function serialize(ent)
	local serialized = duplicator.CopyEntTable(ent)
	serialized.DT = getDTVars(ent)
	serialized.DarkRPItem = ent.DarkRPItem or {}
	serialized.StoredMoney = ent.StoredMoney or 0
	serialized.StoredXP = ent.StoredXP or 0
	return serialized
end

local function deserialize(ply, item)
	local ent = ents.Create(item.Class)
	duplicator.DoGeneric(ent, item)
	ent.DarkRPItem = item.DarkRPItem
	ent.StoredMoney = item.StoredMoney
	ent.StoredXP = item.StoredXP
	ent:Spawn()
	ent:Activate()


	duplicator.DoGenericPhysics(ent, ply, item)
	table.Merge(ent:GetTable(), item)

	local pos, mins = ent:GetPos(), ent:WorldSpaceAABB()
	local offset = pos.z - mins.z

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)
	ent:SetPos(tr.HitPos + Vector(0, 0, offset))

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end

	return ent
end

local function dropAllPocketItems(ply)
	for k,v in pairs(ply.darkRPPocket or {}) do
		ply:dropPocketItem(k)
	end
end

util.AddNetworkString("DarkRP_Pocket")
local function sendPocketItems(ply)
	net.Start("DarkRP_Pocket")
		net.WriteTable(ply:getPocketItems())
	net.Send(ply)
end

/*---------------------------------------------------------------------------
Interface functions
---------------------------------------------------------------------------*/
function meta:addPocketItem(ent)
	if not IsValid(ent) then error("Entity not valid", 2) end

	local serialized = serialize(ent)

	hook.Call("onPocketItemAdded", nil, self, ent, serialized)

	ent:Remove()

	self.darkRPPocket = self.darkRPPocket or {}

	local id = table.insert(self.darkRPPocket, serialized)
	sendPocketItems(self)
	return id
end

function meta:removePocketItem(item)
	if not self.darkRPPocket or not self.darkRPPocket[item] then error("Player does not contain " .. item .. " in their pocket.", 2) end

	hook.Call("onPocketItemRemoved", nil, self, item)

	self.darkRPPocket[item] = nil
	sendPocketItems(self)
end

function meta:dropPocketItem(item)
	if not self.darkRPPocket or not self.darkRPPocket[item] then error("Player does not contain " .. item .. " in their pocket.", 2) end

	local id = self.darkRPPocket[item]
	local ent = deserialize(self, id)

	self:removePocketItem(item)
	return ent
end

-- serverside implementation
function meta:getPocketItems()
	self.darkRPPocket = self.darkRPPocket or {}

	local res = {}
	for k,v in pairs(self.darkRPPocket) do
		res[k] = {
			model = v.Model,
			class = v.Class
		}
	end

	return res
end

/*---------------------------------------------------------------------------
Commands
---------------------------------------------------------------------------*/
util.AddNetworkString("DarkRP_spawnPocket")
net.Receive("DarkRP_spawnPocket", function(len, ply)
	local item = net.ReadFloat()
	if not ply.darkRPPocket[item] then return end
	ply:dropPocketItem(item)
end)

/*---------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------*/

local function onAdded(ply, ent, serialized)
	if not ent:IsValid() or not ent.DarkRPItem or not ent.Getowning_ent or not IsValid(ent:Getowning_ent()) then return end

	local ply = ent:Getowning_ent()
	local cmdname = string.gsub(ent.DarkRPItem.ent, " ", "_")

	ply:addCustomEntity(ent.DarkRPItem)
end
hook.Add("onPocketItemAdded", "defaultImplementation", onAdded)

local function canPocket(ply, item)
	if not IsValid(item) then return false end
	local class = item:GetClass()

	if item.Removed then return false, DarkRP.getPhrase("cannot_pocket_x") end
	if not item:CPPICanPickup(ply) then return false, DarkRP.getPhrase("cannot_pocket_x") end
	if item.jailWall then return false, DarkRP.getPhrase("cannot_pocket_x") end
	if GAMEMODE.Config.PocketBlacklist[class] then return false, DarkRP.getPhrase("cannot_pocket_x") end
	if string.find(class, "func_") then return false, DarkRP.getPhrase("cannot_pocket_x") end

	local trace = ply:GetEyeTrace()
	if ply:EyePos():Distance(trace.HitPos) > 150 then return false end

	local phys = trace.Entity:GetPhysicsObject()
	if not phys:IsValid() then return false end

	local mass = trace.Entity.RPOriginalMass and trace.Entity.RPOriginalMass or phys:GetMass()
	if mass > 100 then return false, DarkRP.getPhrase("object_too_heavy") end

	local job = ply:Team()
	local max = RPExtraTeams[job].maxpocket or GAMEMODE.Config.pocketitems
	if table.Count(ply.darkRPPocket or {}) >= max then return false, DarkRP.getPhrase("pocket_full") end

	return true
end
hook.Add("canPocket", "defaultRestrictions", canPocket)


-- Drop pocket items on death
hook.Add("PlayerDeath", "DropPocketItems", function(ply)
	if not GAMEMODE.Config.droppocketdeath or not ply.darkRPPocket then return end
	dropAllPocketItems(ply)
end)

hook.Add("playerArrested", "DropPocketItems", function(ply)
	if not GAMEMODE.Config.droppocketarrest then return end
	dropAllPocketItems(ply)
end)
