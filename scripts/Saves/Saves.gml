function save_game() {
	if (global.state.shared.developer_mode) {
		exit;
	}

	obj_game.alarm[0] = global.autosave_interval;

	if (global.state.shared_is_touched) {
		var _shared_json = json_stringify(global.state.shared);
		write_text_to_file_by_filename(global.shared_path, _shared_json);
		global.state.shared_is_touched = false;
	}

	if (global.state.secret_is_touched) {
		var _secret_json = json_stringify(global.state.secret);
		var _secret_base64 = base64_encode(_secret_json);
		write_text_to_file_by_filename(global.secret_path, _secret_base64);
		global.state.secret_is_touched = false;
	}

	if (global.state.save_slot_is_touched) {
		var _save_slot_json = json_stringify(global.state.save_slot);
		var _number_string = string(global.state.shared.active_save_slot_id);
		var _filename = global.slot_path + _number_string + global.json_ext;
		write_text_to_file_by_filename(_filename, _save_slot_json);
		global.state.shared_is_touched = false;
	}

	if (global.state.player_is_touched) {
		var _player_json = json_stringify(global.state.player);
		var _number_string = string(global.state.shared.active_player_id);
		var _filename = global.player_path + _number_string + global.json_ext;
		write_text_to_file_by_filename(_filename, _player_json);
		global.state.shared_is_touched = false;
	}
}

function load_game() {
	if (file_exists(global.shared_path)) {
		var _shared_json = read_text_from_file_by_filename(global.shared_path);
		global.state.shared = json_parse(_shared_json);
	} else {
		touch_shared();
	}

	if (file_exists(global.secret_path)) {
		var _secret_base64 = read_text_from_file_by_filename(global.secret_path);
		var _secret_json = base64_decode(_secret_base64);
		global.state.secret = json_parse(_secret_json);
	} else {
		touch_secret();
	}

	var _slot_number_string = string(global.state.shared.active_save_slot_id);
	var _slot_filename = global.slot_path + _slot_number_string + global.json_ext;
	if (file_exists(_slot_filename)) {
		var _save_slot_json = read_text_from_file_by_filename(_slot_filename);
		global.state.save_slot = json_parse(_save_slot_json);
	} else {
		touch_slot();
	}

	var _player_number_string = string(global.state.shared.active_player_id);
	var _player_filename = global.player_path + _player_number_string + global.json_ext;
	if (file_exists(_player_filename)) {
		var _player_json = read_text_from_file_by_filename(_player_filename);
		global.state.player = json_parse(_player_json);
	} else {
		touch_player();
	}

	load_chatterbox_variables_from_state();
	save_game();
}

function switch_slot(_slot_number, _update_player = true) {
	if (_slot_number >= global.available_save_slots) {
		return;
	}
	if (global.state.shared.active_save_slot_id == _slot_number) {
		return;
	}
	save_game();
	global.state.shared.active_save_slot_id = _slot_number;
	touch_shared();
	save_game();
	global.state.save_slot = variable_clone(global.initial_state.save_slot);
	load_game();
	if (_update_player && global.state.save_slot.player_id != -1) {
		switch_player(global.state.save_slot.player_id);
	}
	ChatterboxVariablesResetAll();
}

function switch_player(_player_id) {
	if (_player_id >= global.available_player_slots) {
		return;
	}
	if (global.state.shared.active_player_id == _player_id) {
		return;
	}
	save_game();
	global.state.shared.active_player_id = _player_id;
	touch_shared();
	save_game();
	global.state.player = variable_clone(global.initial_state.player);
	load_game();
}

function switch_player_new() {
	var _player_count = global.state.shared.player_count;
	global.state.shared.player_count++;
	switch_player(_player_count);
}

function write_text_to_file_by_filename(_filename, _text) {
	var _file = file_text_open_write(_filename);
	file_text_write_string(_file, _text);
	file_text_close(_file);
}

function read_text_from_file_by_filename(_filename) {
	var _file_buffer = buffer_load(_filename);
	var _text = buffer_read(_file_buffer, buffer_string);
	buffer_delete(_file_buffer);
	return _text;
}

function touch_shared() {
	global.state.shared_is_touched = true;
}

function touch_secret() {
	global.state.secret_is_touched = true;
}

function touch_slot() {
	global.state.save_slot_is_touched = true;
}

function touch_player() {
	global.state.player_is_touched = true;
}

function get(_name) {
	if (string_starts_with(_name, "player_")) {
		_name = string_delete(_name, 1, 7);
		if (array_contains(global.player_base_variables, _name)) {
			return struct_get(global.state.player, _name);
		}
		return struct_get(global.state.player.data, _name);
	} else if (string_starts_with(_name, "secret_")) {
		_name = string_delete(_name, 1, 7);
		return struct_get(global.state.secret.data, _name);
	} else {
		if (array_contains(global.slot_base_variables, _name)) {
			return struct_get(global.state.save_slot, _name);
		}
		return struct_get(global.state.save_slot.data, _name);
	}
}

function set(_name, _value) {
	if (string_starts_with(_name, "player_")) {
		ChatterboxVariableSet(_name, _value);
	} else if (string_starts_with(_name, "secret_")) {
		ChatterboxVariableSet(_name, _value);
	} else {
		ChatterboxVariableSet(_name, _value);
	}
}

function load_chatterbox_variables_from_state() {
	import = {};
	array_foreach(global.slot_base_variables, function(_name) {
		struct_set(import, _name, struct_get(global.state.save_slot, _name));
	});
	array_foreach(global.player_base_variables, function(_name) {
		struct_set(import, "player_" + _name, struct_get(global.state.player, _name));
	});
	struct_foreach(global.state.secret.data, function(_name, _value) {
		struct_set(import, "secret_" + _name, _value);
	});
	struct_foreach(global.state.save_slot.data, function(_name, _value) {
		struct_set(import, _name, _value);
	});
	struct_foreach(global.state.player.data, function(_name, _value) {
		struct_set(import, "player_" + _name, _value);
	});
	struct_foreach(global.state.player.visited_nodes, function(_name, _value) {
		struct_set(import, "visited(default:" + _name + ")", _value);
	});
	struct_foreach(get_pronoun_list(global.state.player.gender_pronouns), function(
		_name,
		_value
	) {
		struct_set(import, _name, _value);
	});

	ChatterboxVariablesImport(json_stringify(import));
}

function on_chatterbox_variable_set(_name, _value) {
	if (string_starts_with(_name, "player_gender_pronoun_")) {
		return;
	}
	if (string_starts_with(_name, "visited(default:")) {
		touch_player();
		_name = string_delete(_name, 1, 16);
		_name = string_delete(_name, string_length(_name), 1);
		struct_set(global.state.player.visited_nodes, _name, _value);
	} else if (string_starts_with(_name, "player_")) {
		touch_player();
		_name = string_delete(_name, 1, 7);
		if (array_contains(global.player_base_variables, _name)) {
			struct_set(global.state.player, _name, _value);
		} else {
			struct_set(global.state.player.data, _name, _value);
		}
	} else if (string_starts_with(_name, "secret_")) {
		touch_secret();
		_name = string_delete(_name, 1, 7);
		struct_set(global.state.secret.data, _name, _value);
	} else {
		touch_slot();
		if (array_contains(global.slot_base_variables, _name)) {
			struct_set(global.state.save_slot, _name, _value);
		} else {
			struct_set(global.state.save_slot.data, _name, _value);
		}
	}
	if (_name == "gender_pronouns") {
		struct_foreach(get_pronoun_list(_value), function(_pronoun_type, _pronoun) {
			ChatterboxVariableSet(_pronoun_type, _pronoun);
		});
	}
}
