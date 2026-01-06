function load_all_chatterbox_files_to_buffer(_buffer, _directory = "") {
	load_yarn_files(_buffer, _directory);
	load_character_files(_directory);
	var _subdirs = find_directories(_directory);
	for (var _i = 0; _i < array_length(_subdirs); _i++) {
		load_all_chatterbox_files_to_buffer(_buffer, _directory + _subdirs[_i] + "/");
	}
}

function load_all_chatterbox() {
	var _buffer = buffer_create(1048576, buffer_grow, 1);
	load_all_chatterbox_files_to_buffer(_buffer);
	ChatterboxLoadFromBuffer("default", _buffer);
	buffer_delete(_buffer);
}

function load_yarn_files(_buffer, _directory) {
	var _yarn_files = find_files(_directory + "*.yarn");
	show_debug_message(_yarn_files);
	for (var _i = 0; _i < array_length(_yarn_files); _i++) {
		var _yarn_file = _directory + _yarn_files[_i];
		buffer_load_ext(_buffer, _yarn_file, buffer_get_used_size(_buffer));
	}
}

function load_character_files(_directory) {
	var _character_files = find_files(_directory + "*characters.json");
	for (var _i = 0; _i < array_length(_character_files); _i++) {
		var _character_file = _character_files[_i];
		var _character_json = read_text_from_file_by_filename(_character_file);
		var _characters = json_parse(_character_json);
		struct_merge(state.characters, _characters);
	}
}

// Finds matching files for the provided mask
function find_files(_mask) {
	var _files = [];
	var _filename = file_find_first(_mask, fa_directory | fa_none);
	while (_filename != "") {
		array_push(_files, _filename);
		_filename = file_find_next();
	}
	file_find_close();
	return _files;
}

function find_directories(_mask) {
	var _files = find_files(_mask + "*");
	var _dirs = [];
	for (var _i = 0; _i < array_length(_files); _i++) {
		var _file = _files[_i];
		if (directory_exists(_file)) {
			array_push(_dirs, _file);
		}
	}
	return _dirs;
}
