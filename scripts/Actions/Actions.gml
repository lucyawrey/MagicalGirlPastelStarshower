function background(background_name) {
	if (background_name == "none") {
		obj_dialogue.current_background_sprite = undefined;
	} else {
        background_name = add_prefix(background_name, "spr_")
		var spr = asset_get_index(background_name);
		if (asset_get_type(spr) == asset_sprite) {
			obj_dialogue.current_background_sprite = spr;
		} else {
			obj_dialogue.current_background_sprite = undefined;
		}
	}
}

function delay(time_in_seconds = 1, behavior = "stay") {
	if (obj_dialogue.loading) {
		return;
	}
	obj_game.pause(time_in_seconds);
	if (behavior != "next") {
		ChatterboxWait(obj_dialogue.chatterbox);
	}
	if (behavior == "clear") {
		obj_dialogue.get_current_content();
	}
	obj_dialogue.delay_behavior = behavior;
}

function show(sprite_name, position, y_position) {
    sprite_name = add_prefix(sprite_name, "spr_");
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
		obj_dialogue.current_shown_sprites,
		sprite_name,
		{sprite: spr, x_pos, y_pos}
	);
}

function hide(sprite_name = undefined) {
	if (is_undefined(sprite_name)) {
		obj_dialogue.current_shown_sprites = {};
	} else if (struct_exists(obj_dialogue.current_shown_sprites, sprite_name)) {
		struct_remove(obj_dialogue.current_shown_sprites, sprite_name);
	}
}

function play(audio_type, audio_name, volume = 1) {
    audio_name = add_prefix(audio_name, "snd_")
	var audio = asset_get_index(audio_name);
	if (asset_get_type(audio) == asset_sound) {
		if (audio_type == "music") {
			if (!is_undefined(obj_dialogue.current_music)) {
				audio_stop_sound(obj_dialogue.current_music);
			}
			audio_play_sound(audio, 1, true, volume);
			obj_dialogue.current_music = audio;
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
	obj_dialogue.current_state = DialogueState.Input;
	obj_dialogue.current_input_text = "";
	keyboard_lastchar = "";
	obj_dialogue.current_input_variable = variable_name;
}
