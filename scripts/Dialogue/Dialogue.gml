function show_dialogue(node, node_position = 0) {
	if (!instance_exists(Dialogue_Manager)) {
		return;
	}

	Dialogue_Manager.loading = true;
	ChatterboxJump(Dialogue_Manager.chatterbox, node);

	if (node_position > 0) {
		skip_to_position(node_position);
	}

	Dialogue_Manager.get_current_content();
	Dialogue_Manager.visible = true;
	Dialogue_Manager.loading = false;
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

function increment_current_node_position() {
	Game.state.save_slot.current_node_position++;
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

	return {character, metadata, text};
}

function text_play_sound(element, position, typist) {
	if (typist.get_skip()) {
		return;
	}
	Dialogue_Manager.typist_sound_clock++;
	var current_char = string_char_at(Dialogue_Manager.current_text, position);
	if (current_char == " ") {
		Dialogue_Manager.typist_sound_clock -= 2;
	}
	if (Dialogue_Manager.typist_sound_clock >= Dialogue_Manager.current_character.sound_spacing) {
		audio_play_sound(Dialogue_Manager.current_character.sound, 1, false, 0.5, undefined, Dialogue_Manager.current_character.sound_pitch);
		Dialogue_Manager.typist_sound_clock = 0;
	}
}
