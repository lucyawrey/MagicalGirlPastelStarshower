function save_game() {
	obj_game.alarm[0] = global.autosave_interval;

	if (state.save_is_touched) {
		var _save_json = json_stringify(state.save);
		var _number_string = string(state.shared.active_save_id);
		var _filename = global.save_path + _number_string + global.json_ext;
		write_text_to_file_by_filename(_filename, _save_json);
		state.shared_is_touched = false;
	}

	if (state.shared_is_touched) {
		var _shared_json = json_stringify(state.shared);
		write_text_to_file_by_filename(global.shared_path, _shared_json);
		state.shared_is_touched = false;
	}

	if (state.secret_is_touched) {
		var _secret_json = json_stringify(state.secret);
		var _secret_base64 = base64_encode(_secret_json);
		write_text_to_file_by_filename(global.secret_path, _secret_base64);
		state.secret_is_touched = false;
	}
}

function load_game() {
	var _save_slot_number_string = string(state.shared.active_save_id);
	var _slot_filename = global.save_path + _save_slot_number_string + global.json_ext;
	if (file_exists(_slot_filename)) {
		var _save_json = read_text_from_file_by_filename(_slot_filename);
		state.save = json_parse(_save_json);
	} else {
		touch_save();
	}

	if (file_exists(global.shared_path)) {
		var _shared_json = read_text_from_file_by_filename(global.shared_path);
		state.shared = json_parse(_shared_json);
	} else {
		touch_shared();
	}

	if (file_exists(global.secret_path)) {
		var _secret_base64 = read_text_from_file_by_filename(global.secret_path);
		var _secret_json = base64_decode(_secret_base64);
		state.secret = json_parse(_secret_json);
	} else {
		touch_secret();
	}

	reload_chatterbox_variables();
	save_game();
}

function switch_slot(_save_id) {
	if (_save_id >= global.save_slot_count) {
		return;
	}
	if (state.shared.active_save_id == _save_id) {
		return;
	}
	save_game();
	state.shared.active_save_id = _save_id;
	touch_shared();
	save_game();
	state.save = variable_clone(initial_state.save);
	load_game();
}

function reload_chatterbox_variables() {
	ChatterboxVariablesResetAll();
	load_chatterbox_variables_from_state();
}

function reset_save_state() {
	state.save = variable_clone(initial_state.save);
	touch_save();
	save_game();
	load_game();
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

function touch_save() {
	state.save_is_touched = true;
}

function touch_shared() {
	state.shared_is_touched = true;
}

function touch_secret() {
	state.secret_is_touched = true;
}

function get(_name) {
	if (string_starts_with(_name, "secret_")) {
		_name = string_delete(_name, 1, 7);
		return struct_get(state.secret.data, _name);
	} else {
		if (array_contains(global.slot_base_variables, _name)) {
			return struct_get(state.save, _name);
		}
		return struct_get(state.save.data, _name);
	}
}

function set(_name, _value) {
	if (string_starts_with(_name, "secret_")) {
		ChatterboxVariableSet(_name, _value);
	} else {
		ChatterboxVariableSet(_name, _value);
	}
}

function load_chatterbox_variables_from_state() {
	import = {};
	array_foreach(global.slot_base_variables, function(_name) {
		struct_set(import, _name, struct_get(state.save, _name));
	});
	struct_foreach(state.secret.data, function(_name, _value) {
		struct_set(import, "secret_" + _name, _value);
	});
	struct_foreach(state.save.data, function(_name, _value) {
		struct_set(import, _name, _value);
	});
	struct_foreach(state.save.visited_nodes, function(_name, _value) {
		struct_set(import, "visited(default:" + _name + ")", _value);
	});
	struct_foreach(get_pronoun_list(state.save.gender_pronouns), function(_name, _value) {
		struct_set(import, _name, _value);
	});

	ChatterboxVariablesImport(json_stringify(import));
}

function on_chatterbox_variable_set(_name, _value) {
	if (string_starts_with(_name, "gender_pronoun_")) {
		return;
	}
	if (string_starts_with(_name, "visited(default:")) {
		touch_save();
		_name = string_delete(_name, 1, 16);
		_name = string_delete(_name, string_length(_name), 1);
		struct_set(state.save.visited_nodes, _name, _value);
	} else if (string_starts_with(_name, "secret_")) {
		touch_secret();
		_name = string_delete(_name, 1, 7);
		struct_set(state.secret.data, _name, _value);
	} else {
		touch_save();
		if (array_contains(global.slot_base_variables, _name)) {
			struct_set(state.save, _name, _value);
		} else {
			struct_set(state.save.data, _name, _value);
		}
	}
	if (_name == "gender_pronouns") {
		struct_foreach(get_pronoun_list(_value), function(_pronoun_type, _pronoun) {
			ChatterboxVariableSet(_pronoun_type, _pronoun);
		});
	}
}
