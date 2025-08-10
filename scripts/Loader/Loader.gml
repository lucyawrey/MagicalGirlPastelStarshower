function load_all_files_to_buffer(buffer, directory = "") {
	var filename = file_find_first(directory + "*.yarn", fa_readonly);
	while (filename != "") {
		show_debug_message("LOADING FILE TO BUFFER: " + directory + filename);
		buffer_load_ext(buffer, directory + filename, buffer_get_used_size(buffer));
		filename = file_find_next();
	}
	file_find_close();

	var dir = file_find_first(directory + "*", fa_directory);
	var dirs = [];
	while (dir != "") {
		array_push(dirs, dir);
		dir = file_find_next();
	}
	for (var i = 0; i < array_length(dirs); i++) {
		load_all_files_to_buffer(buffer, directory + dirs[i] + "/");
	}
}

function load_all_chatterbox_files() {
	buffer = buffer_create(1048576, buffer_grow, 1);
	load_all_files_to_buffer(buffer);
	ChatterboxLoadFromBuffer("default", buffer);
	buffer_delete(buffer);
}
