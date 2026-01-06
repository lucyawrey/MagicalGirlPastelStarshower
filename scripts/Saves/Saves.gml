#macro SAVE_SLOT_COUNT 12
#macro SAVE_PATH "game_data/save_"
#macro SHARED_PATH "game_data/save_shared.json"
#macro SECRET_PATH "game_data/internal.dat"
#macro JSON_EXT ".json"
#macro AUTOSAVE_INTERVAL 5 * 60

function save_game() {
	obj_game.alarm[0] = AUTOSAVE_INTERVAL;

	if (state.save_is_touched) {
		var _save_json = json_stringify(state.save);
		var _number_string = string(state.shared.active_save_id);
		var _filename = SAVE_PATH + _number_string + JSON_EXT;
		write_text_to_file_by_filename(_filename, _save_json);
		state.shared_is_touched = false;
	}

	if (state.shared_is_touched) {
		var _shared_json = json_stringify(state.shared);
		write_text_to_file_by_filename(SHARED_PATH, _shared_json);
		state.shared_is_touched = false;
	}

	if (state.secret_is_touched) {
		var _secret_json = json_stringify(state.secret);
		var _secret_base64 = base64_encode(_secret_json);
		write_text_to_file_by_filename(SECRET_PATH, _secret_base64);
		state.secret_is_touched = false;
	}
}

function load_game() {
	var _save_slot_number_string = string(state.shared.active_save_id);
	var _slot_filename = SAVE_PATH + _save_slot_number_string + JSON_EXT;
	if (file_exists(_slot_filename)) {
		var _save_json = read_text_from_file_by_filename(_slot_filename);
		state.save = json_parse(_save_json);
	} else {
		touch_save();
	}

	if (file_exists(SHARED_PATH)) {
		var _shared_json = read_text_from_file_by_filename(SHARED_PATH);
		state.shared = json_parse(_shared_json);
	} else {
		touch_shared();
	}

	if (file_exists(SECRET_PATH)) {
		var _secret_base64 = read_text_from_file_by_filename(SECRET_PATH);
		var _secret_json = base64_decode(_secret_base64);
		state.secret = json_parse(_secret_json);
	} else {
		touch_secret();
	}

	reload_chatterbox_variables();
	save_game();
}

function switch_slot(_save_id) {
	if (_save_id >= SAVE_SLOT_COUNT) {
		return;
	}
	if (state.shared.active_save_id == _save_id) {
		return;
	}
	save_game();
	state.shared.active_save_id = _save_id;
	touch_shared();
	save_game();
	state.save = variable_clone(INITIAL_STATE.save);
	load_game();
}

function reload_chatterbox_variables() {
	ChatterboxVariablesResetAll();
	load_chatterbox_variables_from_state();
}

function reset_save_state() {
	state.save = variable_clone(INITIAL_STATE.save);
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

function load_chatterbox_variables_from_state() {
	import = {};
	array_foreach(SAVE_BASE_VARIABLES, function(_name) {
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

function set_sync_variable(_name, _value) {
    if (string_starts_with(_name, "secret_")) {
		touch_secret();
		struct_set(state.secret.data, string_delete(_name, 1, 7), _value);
	} else {
		touch_save();
		if (array_contains(SAVE_BASE_VARIABLES, _name)) {
			struct_set(state.save, _name, _value);
		} else {
			struct_set(state.save.data, _name, _value);
		}
	}
    ChatterboxVariableSet(_name, _value);
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
		if (array_contains(SAVE_BASE_VARIABLES, _name)) {
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
