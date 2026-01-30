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

function friends()
	return Tracker:FindObjectForCode("mario").Active and
		Tracker:FindObjectForCode("peach").Active and
		Tracker:FindObjectForCode("yoshi").Active and
		Tracker:FindObjectForCode("donkey_kong").Active and
		Tracker:FindObjectForCode("wario").Active and
		Tracker:FindObjectForCode("blue_noki").Active and
		Tracker:FindObjectForCode("green_noki").Active and
		Tracker:FindObjectForCode("daisy_statue").Active and
		Tracker:FindObjectForCode("stone_tablet").CurrentStage == 3 and
		characters() and Tracker:FindObjectForCode("day_night").Active and
		Tracker:FindObjectForCode("sea_hut_key").Active and
		Tracker:FindObjectForCode("toad_statue").Active and
		Tracker:FindObjectForCode("rattle").Active and
		Tracker:FindObjectForCode("brush").Active and
		Tracker:FindObjectForCode("boo").Active and
		Tracker:FindObjectForCode("mini_boo").Active
end

function stars()
	if Tracker:FindObjectForCode("randomize_stars").Active then
		return Tracker:FindObjectForCode("star_mario").Active and
			Tracker:FindObjectForCode("star_peach").Active and
			Tracker:FindObjectForCode("star_yoshi").Active and
			Tracker:FindObjectForCode("star_donkey_kong").Active and
			Tracker:FindObjectForCode("star_wario").Active and
			Tracker:FindObjectForCode("star_luigi").Active and
			Tracker:FindObjectForCode("star_daisy").Active and
			Tracker:FindObjectForCode("star_birdo").Active and
			Tracker:FindObjectForCode("star_diddy_kong").Active and
			Tracker:FindObjectForCode("star_waluigi").Active and
			Tracker:FindObjectForCode("star_baby_mario").Active and
			Tracker:FindObjectForCode("star_baby_luigi").Active and
			Tracker:FindObjectForCode("star_baby_peach").Active and
			Tracker:FindObjectForCode("star_baby_daisy").Active and
			Tracker:FindObjectForCode("star_baby_dk").Active and
			Tracker:FindObjectForCode("star_goomba").Active and
			Tracker:FindObjectForCode("star_paragoomba").Active and
			Tracker:FindObjectForCode("star_koopa").Active and
			Tracker:FindObjectForCode("star_paratroopa").Active and
			Tracker:FindObjectForCode("star_toad").Active and
			Tracker:FindObjectForCode("star_toadette").Active and
			Tracker:FindObjectForCode("star_toadsworth").Active and
			Tracker:FindObjectForCode("star_shy_guy").Active and
			Tracker:FindObjectForCode("star_boo").Active and
			Tracker:FindObjectForCode("star_king_boo").Active and
			Tracker:FindObjectForCode("star_pianta").Active and
			Tracker:FindObjectForCode("star_noki").Active and
			Tracker:FindObjectForCode("star_monty_mole").Active and
			Tracker:FindObjectForCode("star_blooper").Active and
			Tracker:FindObjectForCode("star_petey_piranha").Active and
			Tracker:FindObjectForCode("star_wiggler").Active and
			Tracker:FindObjectForCode("star_dixie_kong").Active and
			Tracker:FindObjectForCode("star_funky_kong").Active and
			Tracker:FindObjectForCode("star_tiny_kong").Active and
			Tracker:FindObjectForCode("star_king_k_rool").Active and
			Tracker:FindObjectForCode("star_kritter").Active and
			Tracker:FindObjectForCode("star_bowser").Active and
			Tracker:FindObjectForCode("star_bowser_jr").Active and
			Tracker:FindObjectForCode("star_hammer_bro").Active and
			Tracker:FindObjectForCode("star_magikoopa").Active and
			Tracker:FindObjectForCode("star_dry_bones").Active and
			characters() and Tracker:FindObjectForCode("day_night").Active
	else
		return Tracker:FindObjectForCode("mario").Active and
			Tracker:FindObjectForCode("peach").Active and
			(Tracker:FindObjectForCode("yoshi").Active or Tracker:FindObjectForCode("blue_yoshi").Active or Tracker:FindObjectForCode("light_blue_yoshi").Active or Tracker:FindObjectForCode("pink_yoshi").Active or Tracker:FindObjectForCode("red_yoshi").Active or Tracker:FindObjectForCode("yellow_yoshi").Active) and
			Tracker:FindObjectForCode("donkey_kong").Active and
			Tracker:FindObjectForCode("wario").Active and
			Tracker:FindObjectForCode("luigi").Active and
			Tracker:FindObjectForCode("daisy").Active and
			Tracker:FindObjectForCode("birdo").Active and
			Tracker:FindObjectForCode("diddy_kong").Active and
			Tracker:FindObjectForCode("waluigi").Active and
			Tracker:FindObjectForCode("baby_mario").Active and
			Tracker:FindObjectForCode("baby_luigi").Active and
			Tracker:FindObjectForCode("baby_peach").Active and
			Tracker:FindObjectForCode("baby_daisy").Active and
			Tracker:FindObjectForCode("baby_dk").Active and
			Tracker:FindObjectForCode("goomba").Active and
			Tracker:FindObjectForCode("paragoomba").Active and
			(Tracker:FindObjectForCode("koopa").Active or Tracker:FindObjectForCode("red_koopa").Active) and
			(Tracker:FindObjectForCode("paratroopa").Active or Tracker:FindObjectForCode("green_paratroopa").Active) and
			(Tracker:FindObjectForCode("red_toad").Active or Tracker:FindObjectForCode("blue_toad").Active or Tracker:FindObjectForCode("green_toad").Active or Tracker:FindObjectForCode("purple_toad").Active or Tracker:FindObjectForCode("yellow_toad").Active) and
			Tracker:FindObjectForCode("toadette").Active and
			Tracker:FindObjectForCode("toadsworth").Active and
			(Tracker:FindObjectForCode("shy_guy").Active or Tracker:FindObjectForCode("blue_shy_guy").Active or Tracker:FindObjectForCode("gray_shy_guy").Active or Tracker:FindObjectForCode("green_shy_guy").Active or Tracker:FindObjectForCode("yellow_shy_guy").Active) and
			Tracker:FindObjectForCode("boo").Active and
			Tracker:FindObjectForCode("king_boo").Active and
			(Tracker:FindObjectForCode("blue_pianta").Active or Tracker:FindObjectForCode("red_pianta").Active or Tracker:FindObjectForCode("yellow_pianta").Active) and
			(Tracker:FindObjectForCode("blue_noki").Active or Tracker:FindObjectForCode("green_noki").Active or Tracker:FindObjectForCode("red_noki").Active) and
			Tracker:FindObjectForCode("monty_mole").Active and
			Tracker:FindObjectForCode("blooper").Active and
			Tracker:FindObjectForCode("petey_piranha").Active and
			Tracker:FindObjectForCode("wiggler").Active and
			Tracker:FindObjectForCode("dixie_kong").Active and
			Tracker:FindObjectForCode("funky_kong").Active and
			Tracker:FindObjectForCode("tiny_kong").Active and
			Tracker:FindObjectForCode("king_k_rool").Active and
			(Tracker:FindObjectForCode("kritter").Active or Tracker:FindObjectForCode("blue_kritter").Active or Tracker:FindObjectForCode("brown_kritter").Active or Tracker:FindObjectForCode("red_kritter").Active) and
			characters() and Tracker:FindObjectForCode("day_night").Active
	end
end

Tracker:AddLocations("locations/locations.json")