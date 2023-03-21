function data()
return {
	info = {
		minorVersion = 1,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		params = {			
			{
				key = "endless_mode",
				name = _("Endlosmodus"),
				uiType = "CHECKBOX",
				values = { "No", "Yes", },				
				defaultIndex = 0,	
			},
			{
				key = "pr_signal_waypoint",
				name = _("Wegpunkte"),
				uiType = "CHECKBOX",
				values = { "No", "Yes", },				
				defaultIndex = 1,	
			},
		},
		modid = "modwerkstatt_pr_Signale_1",
		authors = {
			{
				name = "ModWerkstatt",
				role = "CREATOR",	
			}, 
		},
		url = "",		
		steamId = 0, 
		tags = { "europe", "preussen", "signal", "prussian" },  		
		dependencies = {},
	},

	runFn = function (settings, modParams)
		
		local function waypointFilter(fileName, data)		
			if data.metadata.signal and data.metadata.prSignale and data.metadata.prSignale.waypoint == true then		
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2
				--return false
			end
			--return true
			return data
		end
		local function endlessFilter(fileName, data)	
			if data.metadata.signal and data.metadata.prSignale then
                data.metadata.availability.yearTo = 0					
            end
			return data	
		end 

		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]					
			if params["pr_signal_waypoint"] == 0 then				
				--addFileFilter("model/signal", waypointFilter)					
				addModifier("loadModel", waypointFilter)
			end
			if params["endless_mode"] == 1 then				
				addModifier("loadModel", endlessFilter)
			end
			
		else
			--addFileFilter("model/signal", waypointFilter)		
			addModifier("loadModel", endlessFilter)
		end	
	end
}
end
