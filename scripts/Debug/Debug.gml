function debug_create() {
	debug_run_all_tests();
}

function debug_step() {
	if (keyboard_check_pressed(vk_escape)) {
		global.state.save_slot = global.initial_state.save_slot;
		obj_game.alarm[3] = 1;
	}
}

function debug_load_chatterbox_full_text_from_buffer(_buffer) {
	global.debug_chatterbox_full_text = buffer_read(_buffer, buffer_string);
}

function debug_run_all_tests() {
	show_debug_message("\n-- Debug Mode Active --\n\n - Running all tests.");
	show_debug_message("  - Running printed dialogue line count test.");
	test_printed_dialogue_line_count();
	show_debug_message("\n");
}

function test_printed_dialogue_line_count() {
	line_width = global.view_width - 216;

	var _buffer = buffer_create(1048576, buffer_grow, 1);
	load_all_chatterbox_files_to_buffer(_buffer);
	var _full_text = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	var _lines = string_split(_full_text, "\n", true);

	array_foreach(_lines, function(_line, _i) {
		_line = string_trim(_line);

		if (string_starts_with(_line, "<") || string_starts_with(_line, "-")) {
			return;
		}

		var _name = "";
		var _data = "";

		var _split = string_split(_line, ": ", true);
		if (array_length(_split) > 1) {
			_name = _split[0];
			_line = _split[1];
			var _split2 = string_split_ext(_name, ["[", "]"], true);
			if (array_length(_split2) > 1) {
				_name = _split2[0];
				_data = _split2[1];
			}
		}

		var _character = get_character(_name, _data);

		var _printed_line_count = scribble(
			$"{_character.prefix}{_line}{_character.suffix}"
		)
			.wrap(line_width)
			.get_line_count();

		if (_printed_line_count > 3) {
			show_debug_message($"   - Line too long: \"{_line}\"");
			return false;
		}
	});

	return true;
}
