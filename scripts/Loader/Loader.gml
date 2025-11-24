function load_all_chatterbox_files_to_buffer(_buffer, _directory = "") {
	// Load chatterbox files
	var _filename = file_find_first(_directory + "*.yarn", fa_readonly);
	while (_filename != "") {
		buffer_load_ext(_buffer, _directory + _filename, buffer_get_used_size(_buffer));
		_filename = file_find_next();
	}
	file_find_close();

	// Load character definition JSON files
	var _character_filename = file_find_first(_directory + "*characters.json", fa_readonly);
	while (_character_filename != "") {
		var _json = read_text_from_file_by_filename(_directory + _character_filename);
		var _characters = json_parse(_json);
		struct_merge(global.characters, _characters);
		_character_filename = file_find_next();
	}
	file_find_close();

	var _dir = file_find_first(_directory + "*", fa_directory);
	var _dirs = [];
	while (_dir != "") {
		array_push(_dirs, _dir);
		_dir = file_find_next();
	}
	for (var _i = 0; _i < array_length(_dirs); _i++) {
		load_all_chatterbox_files_to_buffer(_buffer, _directory + _dirs[_i] + "/");
	}
}

function load_all_chatterbox() {
	var _buffer = buffer_create(1048576, buffer_grow, 1);
	load_all_chatterbox_files_to_buffer(_buffer);
	ChatterboxLoadFromBuffer("default", _buffer);
	buffer_delete(_buffer);
}
