function get_character(_character_name = "", _character_data = "") {
	if (_character_name == "") {
		_character_name = global.default_character_name;
	}

	var _character_id =
		_character_name + (_character_data == "" ? "" : "." + _character_data);
	if (struct_exists(global.characters_cache, _character_id)) {
		return struct_get(global.characters_cache, _character_id);
	}

	if (!struct_exists(global.characters, global.default_character_name)) {
		return;
	}
	var _default_character = struct_get(global.characters, global.default_character_name);
	var _base_character = struct_exists(global.characters, _character_name)
		? struct_get(global.characters, _character_name)
		: undefined;
	var _variant = is_struct(_base_character)
	&& struct_exists(_base_character, "variants")
	&& struct_exists(_base_character.variants, _character_data)
		? struct_get(_base_character.variants, _character_data)
		: undefined;
	var _queue = [_default_character, _base_character, _variant];
	
    var _sound_name = struct_get_merged_value(_queue, "sound");
	_sound_name = add_prefix(_sound_name, "snd_");
	var _sound = asset_get_index(_sound_name);
    if (asset_get_type(_sound) != asset_sound) {
        _sound = undefined;
    }
    
    var _background_name = struct_get_merged_value(_queue, "background");
    _background_name = add_prefix(_background_name, "spr_");
	var _background = asset_get_index(_background_name);
	if (asset_get_type(_background) != asset_sprite) {
        _background = undefined;
    }

	var _character = {
		id: _character_id,
		name: struct_get_merged_value(
			[_default_character, _character_name, _base_character, _variant],
			"name"
		),
		name_color: struct_get_merged_value(_queue, "name_color"),
		text_color: struct_get_merged_value(_queue, "text_color"),
		text_speed: struct_get_merged_value(_queue, "text_speed"),
		prefix: struct_get_merged_value(_queue, "prefix"),
		suffix: struct_get_merged_value(_queue, "suffix"),
		sound: _sound,
		sound_pitch: struct_get_merged_value(_queue, "sound_pitch"),
		sound_spacing: struct_get_merged_value(_queue, "sound_spacing"),
        background: _background,
	};

	struct_set(global.characters_cache, _character_id, _character);

	return _character;
}
