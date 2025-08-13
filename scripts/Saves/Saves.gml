function save_game() {
	Game.alarm[0] = global.autosave_interval;

	if (Game.state.shared_is_touched) {
		var shared_json = json_stringify(Game.state.shared);
		write_text_to_file_by_filename(global.shared_path, shared_json);
		Game.state.shared_is_touched = false;
	}

	if (Game.state.secret_is_touched) {
		var secret_json = json_stringify(Game.state.secret);
		// TODO encrypt secrets with static secret key instead of encoding them.
		// TODO it would be a fun to see players decrypt them, so actual security does not matter!
		var secret_base64 = base64_encode(secret_json);
		write_text_to_file_by_filename(global.secret_path, secret_base64);
		Game.state.secret_is_touched = false;
	}

	if (Game.state.save_slot_is_touched) {
		var save_slot_json = json_stringify(Game.state.save_slot);
		var number_string = string(Game.state.shared.active_save_slot_id);
		var filename = global.slot_path + number_string + global.json_ext;
		write_text_to_file_by_filename(filename, save_slot_json);
		Game.state.shared_is_touched = false;
	}

	if (Game.state.player_is_touched) {
		var player_json = json_stringify(Game.state.player);
		var number_string = string(Game.state.shared.active_player_id);
		var filename = global.player_path + number_string + global.json_ext;
		write_text_to_file_by_filename(filename, player_json);
		Game.state.shared_is_touched = false;
	}
}

function load_game() {
	if (file_exists(global.shared_path)) {
		var shared_json = read_text_from_file_by_filename(global.shared_path);
		Game.state.shared = json_parse(shared_json);
	} else {
		touch_shared();
	}

	if (file_exists(global.secret_path)) {
		var secret_base64 = read_text_from_file_by_filename(global.secret_path);
		var secret_json = base64_decode(secret_base64);
		Game.state.secret = json_parse(secret_json);
	} else {
		touch_secret();
	}

	var slot_number_string = string(Game.state.shared.active_save_slot_id);
	var slot_filename = global.slot_path + slot_number_string + global.json_ext;
	if (file_exists(slot_filename)) {
		var save_slot_json = read_text_from_file_by_filename(slot_filename);
		Game.state.save_slot = json_parse(save_slot_json);
	} else {
		touch_slot();
	}

	var player_number_string = string(Game.state.shared.active_player_id);
	var player_filename = global.player_path + player_number_string + global.json_ext;
	if (file_exists(player_filename)) {
		var player_json = read_text_from_file_by_filename(player_filename);
		Game.state.player = json_parse(player_json);
	} else {
		touch_player();
	}

	load_chatterbox_variables_from_state();
	save_game();
}

function switch_slot(slot_number, update_player = true) {
	if (slot_number >= global.available_save_slots) {
		return;
	}
	if (Game.state.shared.active_save_slot_id == slot_number) {
		return;
	}
	save_game();
	Game.state.shared.active_save_slot_id = slot_number;
	touch_shared();
	save_game();
	Game.state.save_slot = variable_clone(Game.initial_state.save_slot);
	load_game();
	if (update_player && Game.state.save_slot.player_id != -1) {
		switch_player(Game.state.save_slot.player_id);
	}
}

function switch_player(player_id) {
	if (player_id >= global.available_player_slots) {
		return;
	}
	if (Game.state.shared.active_player_id == player_id) {
		return;
	}
	save_game();
	Game.state.shared.active_player_id = player_id;
	touch_shared();
	save_game();
	Game.state.player = variable_clone(Game.initial_state.player);
	load_game();
}

function switch_player_new() {
	var player_count = Game.state.shared.player_count;
	Game.state.shared.player_count++;
	switch_player(player_count);
}

function write_text_to_file_by_filename(filename, text) {
	var file = file_text_open_write(filename);
	file_text_write_string(file, text);
	file_text_close(file);
}

function read_text_from_file_by_filename(filename) {
	var file_buffer = buffer_load(filename);
	var text = buffer_read(file_buffer, buffer_string);
	buffer_delete(file_buffer);
	return text;
}

function touch_shared() {
	Game.state.shared_is_touched = true;
}

function touch_secret() {
	Game.state.secret_is_touched = true;
}

function touch_slot() {
	Game.state.save_slot_is_touched = true;
}

function touch_player() {
	Game.state.player_is_touched = true;
}

function get(name) {
	if (string_starts_with(name, "player_")) {
		name = string_delete(name, 1, 7);
		if (array_contains(global.player_base_variables, name)) {
			return struct_get(Game.state.player, name);
		}
		return struct_get(Game.state.player.data, name);
	} else if (string_starts_with(name, "secret_")) {
		name = string_delete(name, 1, 7);
		return struct_get(Game.state.secret.data, name);
	} else {
		if (array_contains(global.slot_base_variables, name)) {
			return struct_get(Game.state.save_slot, name);
		}
		return struct_get(Game.state.save_slot.data, name);
	}
}

function set(name, value) {
	if (string_starts_with(name, "player_")) {
		ChatterboxVariableSet(name, value);
	} else if (string_starts_with(name, "secret_")) {
		ChatterboxVariableSet(name, value);
	} else {
		ChatterboxVariableSet(name, value);
	}
}

function load_chatterbox_variables_from_state() {
    import = {};
	array_foreach(global.slot_base_variables, function(name) {
		struct_set(import, name, struct_get(Game.state.save_slot, name));
	});
	array_foreach(global.player_base_variables, function(name) {
		struct_set(import, "player_" + name, struct_get(Game.state.player, name));
	});
	struct_foreach(Game.state.secret.data, function(name, value) {
		struct_set(import, "secret_" + name, value);
	});
	struct_foreach(Game.state.save_slot.data, function(name, value) {
		struct_set(import, name, value);
	});
	struct_foreach(Game.state.player.data, function(name, value) {
		struct_set(import, "player_" + name, value);
	});
	struct_foreach(Game.state.player.visited_nodes, function(name, value) {
		struct_set(import, "visited(default:" + name + ")", value);
	});
    struct_foreach(get_pronoun_list(Game.state.player.gender_pronouns), function(name, value) {
		struct_set(import, name, value);
	});
    
    ChatterboxVariablesImport(json_stringify(import));
}

function on_chatterbox_variable_set(name, value) {
    if (string_starts_with(name, "player_gender_pronoun_")) {
        return;
    }
	if (string_starts_with(name, "visited(default:")) {
		touch_player();
		name = string_delete(name, 1, 16);
		name = string_delete(name, string_length(name), 1);
		struct_set(Game.state.player.visited_nodes, name, value);
	} else if (string_starts_with(name, "player_")) {
		touch_player();
		name = string_delete(name, 1, 7);
		if (array_contains(global.player_base_variables, name)) {
			struct_set(Game.state.player, name, value);
		} else {
            struct_set(Game.state.player.data, name, value);
        }
	} else if (string_starts_with(name, "secret_")) {
		touch_secret();
		name = string_delete(name, 1, 7);
		struct_set(Game.state.secret.data, name, value);
	} else {
		touch_slot();
		if (array_contains(global.slot_base_variables, name)) {
			struct_set(Game.state.save_slot, name, value);
		} else {
            struct_set(Game.state.save_slot.data, name, value);
        }
	}
    if (name == "gender_pronouns") {
        struct_foreach(get_pronoun_list(value), function(pronoun_type, pronoun) {
		    ChatterboxVariableSet(pronoun_type, pronoun);
	    });
    }
}
