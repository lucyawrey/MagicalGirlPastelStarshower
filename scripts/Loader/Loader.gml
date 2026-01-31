#macro CHARACTER_FILES_GLOB "*characters.json"

function load_character_files() {
	var _character_files = find_files(CHARACTER_FILES_GLOB);
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

function copy_datafile_to_save(_source_filename, _dest_filename) {
    var _file_buffer = buffer_load(_source_filename);
	buffer_save(_file_buffer, _dest_filename);
    buffer_delete(_file_buffer);
}
