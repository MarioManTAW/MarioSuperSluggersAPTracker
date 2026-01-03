Tracker:AddItems("items/items.json")
Tracker:AddItems("items/options.json")

Tracker:AddMaps("maps/maps.json")

Tracker:AddLayouts("layouts/items.json")
ScriptHost:LoadScript("scripts/autotracking.lua")

Tracker:AddLayouts("layouts/tracker.json")

function characters()
	return Tracker:FindObjectForCode("characters").AcquiredCount >=
		Tracker:FindObjectForCode("goal_characters").AcquiredCount
end

Tracker:AddLocations("locations/locations.json")