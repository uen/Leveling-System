util.AddNetworkString("Vrondakis.ShowXPBar")

hook.Add("PlayerXPChanged", "DisplayXPBarOnChange", function(ply, oldXP, newXP)
    --[[local data = {
        oldXP = oldXP,
        newXP = newXP
    }

    data = util.Compress(util.TableToJSON(data))--]]

	net.Start("Vrondakis.ShowXPBar")
        net.WriteInt(oldXP, 20)
        net.WriteInt(newXP, 20)
        net.WriteInt(ply:getMaxXP(), 20)
    net.Send(ply)
end)