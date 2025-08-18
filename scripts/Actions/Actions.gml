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

function show(sprite_name, position, y_position) {
	var spr = asset_get_index(sprite_name);
	if (asset_get_type(spr) != asset_sprite) {
		return;
	}
	var x_pos = 0;
	var y_pos = 0;
	if (is_string(position)) {
		if (position == "center") {
			x_pos = (display_get_gui_width() * 0.5) - (sprite_get_width(spr) * 0.5);
			y_pos = (display_get_gui_height() * 0.5) - (sprite_get_height(spr) * 0.5);
		} else if (position == "left") {
			x_pos = (display_get_gui_width() * 0.25) - (sprite_get_width(spr) * 0.5);
			y_pos = (display_get_gui_height() * 0.5) - (sprite_get_height(spr) * 0.5);
		} else if (position == "right") {
			x_pos = (display_get_gui_width() * 0.75) - (sprite_get_width(spr) * 0.5);
			y_pos = (display_get_gui_height() * 0.5) - (sprite_get_height(spr) * 0.5);
		}
	} else if (is_real(position) && is_real(y_position)) {
		x_pos = position;
		y_pos = y_position;
	}
	struct_set(
		Dialogue_Manager.current_shown_sprites,
		sprite_name,
		{sprite: spr, x_pos, y_pos}
	);
}

function hide(sprite_name = undefined) {
	if (is_undefined(sprite_name)) {
		Dialogue_Manager.current_shown_sprites = {};
	} else if (struct_exists(Dialogue_Manager.current_shown_sprites, sprite_name)) {
		struct_remove(Dialogue_Manager.current_shown_sprites, sprite_name);
	}
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

function pause(audio_name = undefined) {
	if (is_undefined(audio_name)) {
		audio_stop_all();
		return;
	}
	var audio = asset_get_index(audio_name);
	if (asset_get_type(audio) == asset_sound) {
		audio_stop_sound(audio);
	}
}

function input(variable_name) {
	// TODO implement user text input
	Dialogue_Manager.current_state = DialogueState.Input;
}
