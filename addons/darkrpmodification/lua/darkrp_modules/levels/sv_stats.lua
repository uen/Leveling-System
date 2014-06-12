hook.Add('Initialize','codetotrackpeopleusingthisscript', function()
	http.Post('http://vrondakis.com/api/server/usage', {
		port = GetConVarString('hostport'),
		hostname = GetHostName()
	})
end)

// I just like to look sometimes guys :)