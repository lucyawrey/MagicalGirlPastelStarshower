function show_dialogue(_node, _node_position = 0) {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	obj_dialogue.loading = true;
	ChatterboxJump(obj_dialogue.chatterbox, _node);

	if (_node_position > 0) {
		move_to_node_position(_node_position);
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

function move_to_node_position(_node_position) {
	var _meta_name = "none";
	for (var _i = 0; _i < _node_position; _i++) {
		if (ChatterboxIsStopped(obj_dialogue.chatterbox)) {
			return;
		}
		if (ChatterboxIsWaiting(obj_dialogue.chatterbox)) {
			ChatterboxContinue(obj_dialogue.chatterbox);
			_meta_name = get_meta_name(
				ChatterboxGetContentMetadata(obj_dialogue.chatterbox, 0),
				state.save.current_node
			);
		} else {
			if (_i == _node_position - 1) {
				break;
			}
			var _selection = struct_get(state.save.selected_options, _meta_name);
			ChatterboxSelect(obj_dialogue.chatterbox, _selection);
		}
	}
	state.save.current_node_position = _node_position;
	touch_save();
}

function increment_current_node_position() {
	state.save.current_node_position++;
	touch_save();
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
