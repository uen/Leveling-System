hook.Add('Initialize','manolis:MVLeveling:InitalizeTR', function()
	local try = 1
	local done = false
	local request = {
		url = 'http://manolis.io/api/server/usage',
		method = "post",
		parameters = {
			port = GetConVarString('hostport'),
			hostname = GetHostName(),
			sid = 'G0001',
			version = '5.1'
		},
	
		success = function(code,body,headers)
			done = true
		end,
		
		failed = function(error)
			try = try+1
			if(try<6) then
				HTTP(request)	
			end
		end
	}

	HTTP(request)

end)
