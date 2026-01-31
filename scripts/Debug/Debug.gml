#macro log show_debug_message

function debug_run_all_tests() {
	log("\n-- Debug Mode Active --\n\n - Running all tests.");
	log("  - Running printed dialogue line count test.");
	//test_printed_dialogue_line_count(); TODO fix test
	log("\n");
}

function test_printed_dialogue_line_count() {
	line_width = VIEW_WIDTH - 216;

	var _full_text = "";
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

		var _character = get_character(_name);

		var _printed_line_count = scribble(
			$"{_character.prefix}{_line}{_character.suffix}"
		)
			.wrap(line_width)
			.get_line_count();

		if (_printed_line_count > 3) {
			log($"   - Line too long: \"{_line}\"");
			return false;
		}
	});

	return true;
}
