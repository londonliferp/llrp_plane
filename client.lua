lsiaToSandy = {
        {["x"]= -1504.135, ["y"]= -2853.891, ["z"]= 20.07338}, 
        {["x"]= -1941.148, ["y"]= -2599.741, ["z"]= 126.0164},
        {["x"]= -2397.946, ["y"]= -2231.195, ["z"]= 197.5916},
        {["x"]= -2659.501, ["y"]= -1683.18, ["z"]= 248.7708},
        {["x"]= -2721.868, ["y"]= -1062.945, ["z"]= 298.7169},
        {["x"]= -2464.366, ["y"]= -442.1061, ["z"]= 339.2007},
        {["x"]= -2178.032, ["y"]= 171.8818, ["z"]= 383.4493},
        {["x"]= -1886.238, ["y"]= 789.0176, ["z"]= 412.8488},
        {["x"]= -1573.271, ["y"]= 1416.826, ["z"]= 399.9329},
        {["x"]= -1126.344, ["y"]= 1981.312, ["z"]= 356.7897},
        {["x"]= -542.8171, ["y"]= 2451.097, ["z"]= 274.4182},
        {["x"]= 14.75712, ["y"]= 2803.512, ["z"]= 185.0805},
        {["x"]= 620.2378, ["y"]= 2954.043, ["z"]= 135.0634},
        {["x"]= 1182.772, ["y"]= 3110.573, ["z"]= 49.88665},
        {["x"]= 1525.337, ["y"]= 3204.074, ["z"]=41.00412},
}

sandyToGrapeseed = {
	{["x"] = 1447.509, ["y"] = 3181.826, ["z"] = 42.55862},
        {["x"] = 925.2449, ["y"] = 3045.765, ["z"] = 115.6862},
        {["x"] = 383.484, ["y"] = 3224.17, ["z"] = 144.2868},
        {["x"] = 331.827, ["y"] = 3798.025, ["z"] = 138.563},
        {["x"] = 824.579, ["y"] = 4138.139, ["z"] = 136.2286},
        {["x"] = 1364.943, ["y"] = 4423.049, ["z"] = 105.953},
        {["x"] = 1868.965, ["y"] = 4681.101, ["z"] = 53.60704},
}

local createdCheckpoints = {} -- This table is actively used for keeping track of the checkpoints created by this script.
local hidePaths = false -- Defaulted to false, so it shows all paths.

RegisterCommand("printcoords", function(source, args, rawCommand)
	if args[1] == nil then args[1] = 10000 end -- Default to every 10 seconds.
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(tonumber(args[1]))
			local coords = GetEntityCoords(GetPlayerPed(-1))
			TriggerEvent("esx:showNotification", coords)
		end
	end)
end)

RegisterCommand("hidepaths", function(source, args, rawCommand)
	if not hidePaths then
		hidePaths = true
		TriggerEvent("esx:showNotification", "~r~All Flight Paths are no longer visible.")
	else
		hidePaths = false
		TriggerEvent("esx:showNotification", "~g~All Flight Paths are now visible.")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k,v in ipairs(createdCheckpoints) do
			DeleteCheckpoint(v)
		end
		if IsPedInAnyPlane(GetPlayerPed(-1)) and not hidePaths then
                	for k,v in ipairs(lsiaToSandy) do
                        	local checkpoint = CreateCheckpoint(35, v.x, v.y, v.z, 0.0, 0.0, 0.0, 24.0, 255, 0, 0, 100, 0)
                        	table.insert(createdCheckpoints, checkpoint)
                	end
                	for k,v in ipairs(sandyToGrapeseed) do
                        	local checkpoint = CreateCheckpoint(35, v.x, v.y, v.z, 0.0, 0.0, 0.0, 24.0, 100, 150, 0, 100, 0)
                        	table.insert(createdCheckpoints, checkpoint)
                	end
		end
	end
end)
