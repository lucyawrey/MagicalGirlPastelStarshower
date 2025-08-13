function show_dialogue(node, node_position = 0) {
	if (!instance_exists(Dialogue_Manager)) {
		return;
	}

	ChatterboxJump(Dialogue_Manager.chatterbox, node);

	if (node_position > 0) {
		skip_to_position(node_position);
	}

	Dialogue_Manager.get_current_content();
	Dialogue_Manager.visible = true;
}

function hide_dialogue() {
	if (instance_exists(Dialogue_Manager)) {
		Dialogue_Manager.visible = false;
	}
}

function skip_to_position(node_position) {
	repeat (node_position) {
		ChatterboxContinue(Dialogue_Manager.chatterbox);
	}
	Game.state.save_slot.current_node_position = node_position;
	touch_slot();
}

function on_node_change(_old_node, new_node, _action) {
	Game.state.save_slot.current_node_position = 0;
	Game.state.save_slot.current_node = new_node;
	touch_slot();
	Dialogue_Manager.is_new_node = true;
}

function get_content() {
	if (!instance_exists(Dialogue_Manager)) {
		return;
	}

	var character_name = ChatterboxGetContentSpeaker(Dialogue_Manager.chatterbox, 0);
	var character_data = ChatterboxGetContentSpeakerData(Dialogue_Manager.chatterbox, 0);
	var character = get_character(character_name, character_data);
	var metadata = ChatterboxGetContentMetadata(Dialogue_Manager.chatterbox, 0);
	var text = ChatterboxGetContentSpeech(Dialogue_Manager.chatterbox, 0);

	if (character.suffix != "") {
		text += character.suffix;
	}
	if (character.prefix != "") {
		text = character.prefix + text;
	}

	return {character, metadata, text};
}

function add_text_line_breaks(input_text, line_width, char_width) {
	var char_limit = line_width / char_width;
	var output_text = "";
	var current_char = 0;
	var tokens = string_split(input_text, " ", true);
	for (var i = 0; i < array_length(tokens); i++) {
		var token = tokens[i];
		var length = string_length(token);
		current_char += length;
		if (current_char == length) {
			output_text += token;
		} else if (current_char > char_limit) {
			current_char = length;
			output_text += "\n" + token;
		} else {
			output_text += " " + token;
		}
	}
	return output_text;
}

function load_chatterbox_from_state() {
    ChatterboxVariableSet("player_name", Game.state.player.name);
}
