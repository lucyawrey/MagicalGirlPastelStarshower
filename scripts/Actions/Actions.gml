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
    if (Dialogue_Manager.loading) {
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

function play(audio_type, audio_name, volume = 1) {
    var audio = asset_get_index(audio_name);
    if (asset_get_type(audio) == asset_sound) {
        if (audio_type == "music") {
            if (!is_undefined(Dialogue_Manager.current_music)) {
                audio_stop_sound(Dialogue_Manager.current_music);
            }
            audio_play_sound(audio, 1, true, volume);
            Dialogue_Manager.current_music = audio;
            
        } else if (audio_type == "sound") {
            audio_play_sound(audio, 1, false, volume);
        }
    }
}

function input(variable_name) {
	// TODO implement user text input
}
