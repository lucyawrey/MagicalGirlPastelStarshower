function show_dialogue(node, node_position = 0, option_queue = []) {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	obj_dialogue.loading = true;
	ChatterboxJump(obj_dialogue.chatterbox, node);

	if (node_position > 0) {
		skip_to_position(node_position, option_queue);
	}

	obj_dialogue.get_current_content();
	obj_dialogue.visible = true;
	obj_dialogue.loading = false;
}

function hide_dialogue() {
	if (instance_exists(obj_dialogue)) {
		obj_dialogue.visible = false;
	}
}

function skip_to_position(node_position, option_queue) {
	var option_queue_index = 0;
	repeat (node_position) {
		if (ChatterboxIsStopped(obj_dialogue.chatterbox)) {
			return;
		}
		if (ChatterboxIsWaiting(obj_dialogue.chatterbox)) {
			ChatterboxContinue(obj_dialogue.chatterbox);
		} else {
			var option = option_queue[option_queue_index];
			ChatterboxSelect(obj_dialogue.chatterbox, option);
			option_queue_index++;
		}
	}
	obj_game.state.save_slot.current_node_position = node_position;
	touch_slot();
}

function increment_current_node_position() {
	obj_game.state.save_slot.current_node_position++;
	touch_slot();
}

function on_node_change(_old_node, new_node, _action) {
	obj_game.state.save_slot.current_node_position = 0;
	obj_game.state.save_slot.current_node_option_queue = [];
	obj_game.state.save_slot.current_node = new_node;
	touch_slot();
	obj_dialogue.is_new_node = true;
}

function get_content() {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	var character_name = ChatterboxGetContentSpeaker(obj_dialogue.chatterbox, 0);
	var character_data = ChatterboxGetContentSpeakerData(obj_dialogue.chatterbox, 0);
	var character = get_character(character_name, character_data);
	var metadata = ChatterboxGetContentMetadata(obj_dialogue.chatterbox, 0);
	var text = ChatterboxGetContentSpeech(obj_dialogue.chatterbox, 0);

	return {character, metadata, text};
}

function text_play_sound(element, position, typist) {
	var current_char = string_char_at(obj_dialogue.current_text, position);
	if (typist.get_skip() || current_char == " ") {
		return;
	}
	if (
		obj_dialogue.typist_sound_clock
		>= obj_dialogue.current_character.sound_spacing
	) {
		audio_play_sound(
			obj_dialogue.current_character.sound,
			1,
			false,
			0.5,
			undefined,
			obj_dialogue.current_character.sound_pitch
		);
		obj_dialogue.typist_sound_clock = 0;
	}
	obj_dialogue.typist_sound_clock++;
}
