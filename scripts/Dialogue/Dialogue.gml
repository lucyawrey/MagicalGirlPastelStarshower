function show_dialogue(_node, _node_position = 0, _option_queue = []) {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	obj_dialogue.loading = true;
	ChatterboxJump(obj_dialogue.chatterbox, _node);

	if (_node_position > 0) {
		move_to_node_position(_node_position, _option_queue);
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

function move_to_node_position(_node_position, _option_queue) {
	var _option_queue_index = 0;
	repeat (_node_position) {
		if (ChatterboxIsStopped(obj_dialogue.chatterbox)) {
			return;
		}
		if (ChatterboxIsWaiting(obj_dialogue.chatterbox)) {
			ChatterboxContinue(obj_dialogue.chatterbox);
		} else {
			var _option = _option_queue[_option_queue_index];
			ChatterboxSelect(obj_dialogue.chatterbox, _option);
			_option_queue_index++;
		}
	}
	state.save.current_node_position = _node_position;
	touch_save();
}

function increment_current_node_position() {
	state.save.current_node_position++;
	touch_save();
}

function on_node_change(_old_node, _new_node, _action) {
	if (state.save.current_node != _new_node) {
		state.save.current_node_position = 0;
		state.save.current_node_option_queue = [];
		state.save.current_node = _new_node;
	}
	touch_save();
	obj_dialogue.is_new_node = true;
}

function get_content() {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	var _all_content = ChatterboxGetContent(obj_dialogue.chatterbox, 0);
	var _speech_content = ChatterboxGetContentSpeech(obj_dialogue.chatterbox, 0);

	var _character_id = parse_character_id(_all_content, _speech_content);
	var _character = get_character(_character_id);
	var _metadata = ChatterboxGetContentMetadata(obj_dialogue.chatterbox, 0);

	return {character: _character, metadata: _metadata, text: _speech_content};
}

/**
 * Parses the current speaker ID, including any number of modifiers, and formats it into dot notation.
 * For example, "Stella[Awkward][Slow]" would become "Stella.Awkward.Slow"
 * @param _all_content - String. The full line of content, including speaker and their text
 * @param _speech_content - String. The text of what is being spoken
 * @returns The character_id of the speaker, including modifiers, in dot notation. Empty string otherwise
 */
function parse_character_id(_all_content, _speech_content) {
	_all_content = string_trim(_all_content);
	_speech_content = string_trim(_speech_content);

	var _speech_length = string_length(_speech_content);
	var _speaker_is_present = string_length(_all_content) != _speech_length;

	var _default_character_id = "";
	if (!_speaker_is_present) {
		return _default_character_id;
	}

	var _speaker_content = string_delete(
		_all_content,
		-1 * _speech_length,
		_speech_length
	);
	_speaker_content = string_trim(_speaker_content);
	_speaker_content = string_replace(_speaker_content, ":", "");
	_speaker_content = string_replace_all(_speaker_content, "[", ".");
	_speaker_content = string_replace_all(_speaker_content, "]", "");

	var _speaker_is_modifier_only = string_char_at(_speaker_content, 1) == ".";
	if (_speaker_is_modifier_only) {
		_speaker_content = string_delete(_speaker_content, 1, 1);
	}

	return _speaker_content;
}
