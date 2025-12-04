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
    line_width = global.gui_width - 54 * global.gui_scale * 2;
    
    var _buffer = buffer_create(1048576, buffer_grow, 1);
	load_all_chatterbox_files_to_buffer(_buffer);
    var _full_text = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	var _lines = string_split(_full_text, "\n", true);

	array_foreach(_lines, function(_line, _i) {
		var _character_prefix = "";
		var _character_suffix = "";
		var _printed_line_count = scribble(
			$"{_character_prefix}{_line}{_character_suffix}"
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
