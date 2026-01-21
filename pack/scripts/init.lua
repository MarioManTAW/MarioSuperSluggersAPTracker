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

function count_minigames()
	local night = Tracker:FindObjectForCode("day_night").Active
	local mario = Tracker:FindObjectForCode("blue_noki").Active and
		Tracker:FindObjectForCode("green_noki").Active and night
	local peach = Tracker:FindObjectForCode("daisy_statue").Active and night
	local wario = Tracker:FindObjectForCode("donkey_kong").Active
	local dk = wario and Tracker:FindObjectForCode("stone_tablet").CurrentStage == 3
	local yoshi = Tracker:FindObjectForCode("mario").Active and
		Tracker:FindObjectForCode("yoshi").Active
	local toy_field = Tracker:FindObjectForCode("toy_field_pass").Active
	local daisy = Tracker:FindObjectForCode("cruiser_pass").Active
	local luigi = Tracker:FindObjectForCode("luigi_flashlight").Active and night
	local bowser_jr = characters()
	local bowser = bowser_jr and night
	local count = 0
	for _,v in ipairs({mario, peach, wario, dk, yoshi, toy_field, daisy, luigi, bowser, bowser_jr}) do
		if v then count = count + 1 end
	end
	return count
end

function shops()
	return count_minigames() > 0
end

function minigames()
	return count_minigames() == 10
end

Tracker:AddLocations("locations/locations.json")