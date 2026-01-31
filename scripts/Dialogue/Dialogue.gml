function start_dialogue() {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	obj_dialogue.loading = true;
    
    obj_dialogue.continue_on();
    obj_dialogue.continue_on();
    
	obj_dialogue.visible = true;
	obj_dialogue.loading = false;
}

function increment_current_node_position() {
	state.save.current_node_position++;
	touch_save();
}

/**
 * Parses the current text and speaker ID (including any number of modifiers, and formats it into dot notation).
 * For example, "Stella[Awkward][Slow]" would become "Stella.Awkward.Slow")
 * @param _content - String. The full line of content, including speaker and their text.
 * @returns An object that includes the character_id of the speaker and the text part of the content.
 */
function parse_text_and_character_id(_content) {
    // TODO smarter content+speaker split
    var _split = string_split(_content, ":", true, 1);
    var _length = array_length(_split);
    if (_length < 1) {
	   return {text: "", character_id: ""}; 
    }
    if (_length == 1) {
        return {text: _split[0], character_id: ""}; 
    }
    
    var _speaker = string_trim(_split[0]);
    var _text = string_trim(_split[1]);
    
	_speaker = string_replace(_speaker, ":", "");
	_speaker = string_replace_all(_speaker, "[", ".");
	_speaker = string_replace_all(_speaker, "]", "");

	var _speaker_is_modifier_only = string_char_at(_speaker, 1) == ".";
	if (_speaker_is_modifier_only) {
		_speaker = string_delete(_speaker, 1, 1);
	}

	return {text: _text, character_id: _speaker};
}


