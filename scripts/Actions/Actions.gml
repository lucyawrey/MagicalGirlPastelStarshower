function background(_background_name) {
	if (_background_name == "none") {
		obj_dialogue.current_background_sprite = undefined;
	} else {
		_background_name = add_prefix(_background_name, "spr_");
		var _sprite = asset_get_index(_background_name);
		if (asset_get_type(_sprite) == asset_sprite) {
			obj_dialogue.current_background_sprite = _sprite;
		} else {
			obj_dialogue.current_background_sprite = undefined;
		}
	}
}

function delay(_time_in_seconds = 1, _behavior = "stay") {
	if (obj_dialogue.loading) {
		return;
	}
	obj_game.pause(_time_in_seconds);
	if (_behavior != "next") {
		ChatterboxWait(obj_dialogue.chatterbox);
	}
	obj_dialogue.delay_behavior = _behavior;
}

function show(_sprite_name, _position, _y_position) {
	_sprite_name = add_prefix(_sprite_name, "spr_");
	var _sprite = asset_get_index(_sprite_name);
	if (asset_get_type(_sprite) != asset_sprite) {
		return;
	}
	var _x_pos = 0;
	var _y_pos = 0;
	var _x_scale = 1; // Set to -1 to mirror image along the x axis
	if (is_string(_position)) {
		if (_position == "center") {
			_x_pos = (global.view_width * 0.3) - (sprite_get_width(_sprite) * 0.5);
		} else if (_position == "left") {
			_x_pos = (global.view_width * 0.08) + (sprite_get_width(_sprite) * 0.5);
		} else if (_position == "right") {
			_x_pos = (global.view_width * 0.7) - (sprite_get_width(_sprite) * 0.5);
		}
		_y_pos = 504 - sprite_get_height(_sprite);
	} else if (is_real(_position) && is_real(_y_position)) {
		_x_pos = _position;
		_y_pos = _y_position;
	}
	struct_set(
		obj_dialogue.current_shown_sprites,
		_sprite_name,
		{sprite: _sprite, x_pos: _x_pos, y_pos: _y_pos, x_scale: _x_scale}
	);
}

function block(_character_id = "", _position = 0) {
	if (_character_id == "") {
		obj_dialogue.current_character_blocking = {};
	} else {
		struct_set(obj_dialogue.current_character_blocking, _character_id, _position);
	}
}

function hide(_sprite_name = undefined) {
	if (is_undefined(_sprite_name)) {
		obj_dialogue.current_shown_sprites = {};
	} else if (struct_exists(obj_dialogue.current_shown_sprites, _sprite_name)) {
		struct_remove(obj_dialogue.current_shown_sprites, _sprite_name);
	}
}

function play(_audio_type, _audio_name, _volume = 1) {
	_audio_name = add_prefix(_audio_name, "snd_");
	var _audio = asset_get_index(_audio_name);
	if (asset_get_type(_audio) == asset_sound) {
		if (_audio_type == "music") {
			if (!is_undefined(obj_dialogue.current_music)) {
				audio_stop_sound(obj_dialogue.current_music);
			}
			audio_play_sound(_audio, 1, true, _volume);
			obj_dialogue.current_music = _audio;
		} else if (_audio_type == "sound") {
			audio_play_sound(_audio, 1, false, _volume);
		}
	}
}

function pause(_audio_name = undefined) {
	if (is_undefined(_audio_name)) {
		audio_stop_all();
		return;
	}
	var _audio = asset_get_index(_audio_name);
	if (asset_get_type(_audio) == asset_sound) {
		audio_stop_sound(_audio);
	}
}

function input(_variable_name) {
	obj_dialogue.current_state = DIALOGUE_STATE.INPUT;
	obj_dialogue.current_input_text = "";
	keyboard_lastchar = "";
	obj_dialogue.current_input_variable = _variable_name;
}
