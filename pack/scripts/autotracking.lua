ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

LEVEL_UNLOCKS = {}



CUR_INDEX = -1
SLOT_DATA = nil


function onClear(slot_data)
	SLOT_DATA = slot_data
	CUR_INDEX = -1

	for _, v in pairs(ITEM_MAPPING) do
		if v[1] then
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				if v[2] == "toggle" then
					obj.Active = false
				elseif v[2] == "progressive" then
					if obj.Active then
						obj.CurrentStage = 0
					else
						obj.Active = true
					end
				elseif v[2] == "consumable" then
					obj.AcquiredCount = 0
				end
			end
		end
	end
	local c = Tracker:FindObjectForCode("characters")
	c.AcquiredCount = 0
	for _, v in pairs(SETTINGS_MAPPING) do
		if v[1] then
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				obj.AcquiredCount = 0
			end
		end
	end

	for _, v in pairs(LOCATION_MAPPING) do
		for _, loc in ipairs(v) do
			if loc:sub(1, 1) == "@" then
				local obj = Tracker:FindObjectForCode(loc)
				if obj then
					obj.AvailableChestCount = obj.ChestCount
				end
			end
		end
	end

	if SLOT_DATA == nil then
		return
	end

	if slot_data['goal_condition'] then
		local goal_condition = Tracker:FindObjectForCode("goal_condition")
		if goal_condition then
			goal_condition.CurrentStage = (slot_data['goal_condition'])
		end
	end

	if slot_data['goal_characters'] then
		local goal_characters = Tracker:FindObjectForCode("goal_characters")
		if goal_characters then
			goal_characters.AcquiredCount = (slot_data['goal_characters'])
		end
	end

	if slot_data['randomize_shops'] then
		local randomize_shops = Tracker:FindObjectForCode("shops")
		if randomize_shops then
			randomize_shops.CurrentStage = (slot_data['randomize_shops'])
		end
	end

	if slot_data['randomize_stars'] then
		local randomize_stars = Tracker:FindObjectForCode("randomize_stars")
		if randomize_stars then
			randomize_stars.Active = (slot_data['randomize_stars'])
		end
	end
end

function onItem(index, item_id, item_name, player_number)
	if index <= CUR_INDEX then return end
	CUR_INDEX = index;

	local v = ITEM_MAPPING[item_id]
	if not v then
		return
	end

	if not v[1] then
		return
	end

	local obj = Tracker:FindObjectForCode(v[1])
	local chars = {
		["Mario"] = true,
		["Luigi"] = true,
		["Donkey Kong"] = true,
		["Diddy Kong"] = true,
		["Peach"] = true,
		["Daisy"] = true,
		["Yoshi"] = true,
		["Baby Mario"] = true,
		["Baby Luigi"] = true,
		["Bowser"] = true,
		["Wario"] = true,
		["Waluigi"] = true,
		["Koopa"] = true,
		["Red Toad"] = true,
		["Boo"] = true,
		["Toadette"] = true,
		["Shy Guy"] = true,
		["Birdo"] = true,
		["Monty Mole"] = true,
		["Bowser Jr."] = true,
		["Paratroopa"] = true,
		["Blue Pianta"] = true,
		["Red Pianta"] = true,
		["Yellow Pianta"] = true,
		["Blue Noki"] = true,
		["Red Noki"] = true,
		["Green Noki"] = true,
		["Hammer Bro"] = true,
		["Toadsworth"] = true,
		["Blue Toad"] = true,
		["Yellow Toad"] = true,
		["Green Toad"] = true,
		["Purple Toad"] = true,
		["Magikoopa"] = true,
		["Red Magikoopa"] = true,
		["Green Magikoopa"] = true,
		["Yellow Magikoopa"] = true,
		["King Boo"] = true,
		["Petey Piranha"] = true,
		["Dixie Kong"] = true,
		["Goomba"] = true,
		["Paragoomba"] = true,
		["Red Koopa"] = true,
		["Green Paratroopa"] = true,
		["Blue Shy Guy"] = true,
		["Yellow Shy Guy"] = true,
		["Green Shy Guy"] = true,
		["Gray Shy Guy"] = true,
		["Dry Bones"] = true,
		["Green Dry Bones"] = true,
		["Dark Bones"] = true,
		["Blue Dry Bones"] = true,
		["Fire Bro"] = true,
		["Boomerang Bro"] = true,
		["Wiggler"] = true,
		["Blooper"] = true,
		["Funky Kong"] = true,
		["Tiny Kong"] = true,
		["Kritter"] = true,
		["Blue Kritter"] = true,
		["Red Kritter"] = true,
		["Brown Kritter"] = true,
		["King K. Rool"] = true,
		["Baby Peach"] = true,
		["Baby Daisy"] = true,
		["Baby DK"] = true,
		["Red Yoshi"] = true,
		["Blue Yoshi"] = true,
		["Yellow Yoshi"] = true,
		["Light Blue Yoshi"] = true,
		["Pink Yoshi"] = true,
	}
	local c = Tracker:FindObjectForCode("characters")
	if obj and c then
		if v[2] == "toggle" then
			if chars[item_name] and not obj.Active then c.AcquiredCount = c.AcquiredCount + c.Increment end
			obj.Active = true
		elseif v[2] == "progressive" then
			if obj.Active then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif v[2] == "consumable" then
			obj.AcquiredCount = obj.AcquiredCount + obj.Increment
		end
	end
end

function onLocation(location_id, location_name)
	local location_array = LOCATION_MAPPING[location_id]
	if not location_array or not location_array[1] then
		print(string.format("onLocation: could not find location mapping for id %s", location_id))
		return
	end

	for _, location in pairs(location_array) do
		local obj = Tracker:FindObjectForCode(location)
		if obj then
			if location:sub(1,1) == "@" then
				obj.AvailableChestCount = obj.AvailableChestCount - 1 
			else
				obj.Active = true
			end
		else 
			print(string.format("onLocation: could not find object for code %s", location))
		end
	end
end


Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
