#macro BASE_CHARACTER_NAME "Base"
#macro DEFAULT_CHARACTER_NAME "Narrator"

function get_character(_character_id = "") {
	// Set default id
	if (_character_id == "") {
		_character_id = DEFAULT_CHARACTER_NAME;
	}
	// Fetch character from cache if able
	if (struct_exists(state.characters_cache, _character_id)) {
		return struct_get(state.characters_cache, _character_id);
	}
	// Fail if base character not available, then fetch base character.
	if (!struct_exists(state.characters, BASE_CHARACTER_NAME)) {
		return;
	}
	var _base_character = struct_get(state.characters, BASE_CHARACTER_NAME);

	var _character_names = string_split(_character_id, ".", true);

	_character_queue = [_base_character, {name: _character_names[0]}]; // Function scoped
	_last_character = undefined; // Function scoped

	array_foreach(_character_names, function(_name) {
		var _character = is_struct(_last_character)
		&& struct_exists(_last_character, "variants")
		&& struct_exists(_last_character.variants, _name)
			? struct_get(_last_character.variants, _name)
			: (struct_exists(state.characters, _name)
				? struct_get(state.characters, _name)
				: undefined);
		if (is_struct(_character)) {
			array_push(_character_queue, _character);
			_last_character = _character;
		}
	});
    
    log(_last_character);
    log(_character_queue);

	// Get values
	var _sound_name = struct_get_merged_value(_character_queue, "sound");
	_sound_name = add_prefix(_sound_name, "snd_");
	var _sound = asset_get_index(_sound_name);
	if (asset_get_type(_sound) != asset_sound) {
		_sound = undefined;
	}

	var _background_name = struct_get_merged_value(_character_queue, "background");
	_background_name = add_prefix(_background_name, "spr_");
	var _background = asset_get_index(_background_name);
	if (asset_get_type(_background) != asset_sprite) {
		_background = undefined;
	}

	var _character = {
		id: _character_id,
		name: struct_get_merged_value(_character_queue, "name"),
		name_color: struct_get_merged_value(_character_queue, "name_color"),
		text_color: struct_get_merged_value(_character_queue, "text_color"),
		text_speed: struct_get_merged_value(_character_queue, "text_speed"),
		prefix: struct_get_merged_value(_character_queue, "prefix"),
		suffix: struct_get_merged_value(_character_queue, "suffix"),
		sound: _sound,
		sound_pitch: struct_get_merged_value(_character_queue, "sound_pitch"),
		sound_spacing: struct_get_merged_value(_character_queue, "sound_spacing"),
		background: _background,
	};

	struct_set(state.characters_cache, _character_id, _character);

	return _character;
}
