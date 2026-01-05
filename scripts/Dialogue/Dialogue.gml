function show_dialogue(_node, _node_position = 0, _option_queue = []) {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	obj_dialogue.loading = true;
	ChatterboxJump(obj_dialogue.chatterbox, _node);

	if (_node_position > 0) {
		skip_to_position(_node_position, _option_queue);
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

function skip_to_position(_node_position, _option_queue) {
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
	state.save_slot.current_node_position = _node_position;
	touch_slot();
}

function increment_current_node_position() {
	state.save_slot.current_node_position++;
	touch_slot();
}

function on_node_change(_old_node, _new_node, _action) {
	state.save_slot.current_node_position = 0;
	state.save_slot.current_node_option_queue = [];
	state.save_slot.current_node = _new_node;
	touch_slot();
	obj_dialogue.is_new_node = true;
}

function get_content() {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	var _character_name = ChatterboxGetContentSpeaker(obj_dialogue.chatterbox, 0);
	var _character_data = ChatterboxGetContentSpeakerData(obj_dialogue.chatterbox, 0);
	var _character = get_character(_character_name, _character_data);
	var _metadata = ChatterboxGetContentMetadata(obj_dialogue.chatterbox, 0);
	var _text = ChatterboxGetContentSpeech(obj_dialogue.chatterbox, 0);

	return {character: _character, metadata: _metadata, text: _text};
}
