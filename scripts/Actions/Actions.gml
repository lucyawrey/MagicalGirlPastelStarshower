function background(background_name) {
	if (background_name == "none") {
		Dialogue_Manager.current_background_sprite = undefined;
	} else {
		var spr = asset_get_index(background_name);
		if (asset_get_type(spr) == asset_sprite) {
			Dialogue_Manager.current_background_sprite = spr;
		} else {
			Dialogue_Manager.current_background_sprite = undefined;
		}
	}
}

function delay(time_in_seconds = 1, behavior = "stay") {
    if (Dialogue_Manager.skipping) {
        return;
    }
	Game.pause(time_in_seconds);
    if (behavior != "next") {
        ChatterboxWait(Dialogue_Manager.chatterbox);
    }
    if (behavior == "clear") {
        Dialogue_Manager.get_current_content();
    }
    Dialogue_Manager.delay_behavior = behavior;
}

function show(sprite_name, position) {
	// TODO implement sprite drawing
}

function play(audio_type, audio_name) {
	// TODO implement audio playing
}

function input(variable_name) {
	// TODO implement user text input
}
