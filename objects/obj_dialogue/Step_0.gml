if (visible && !obj_game.paused) {
	if (obj_game.resumedThisTick) {
		continue_on();
	}

	if (current_state == DIALOGUE_STATE.TEXT) {
		if (typist.get_state() < 1) {
			if (keyboard_check_pressed(continue_key)) {
				typist.skip();
				audio_stop_sound(current_character.sound);
				exit;
			}
		}
		//If we're in a Text state then let the user press space to advance dialogue
		if (keyboard_check_pressed(continue_key)) {
			continue_on();
		}
	} else if (current_state == DIALOGUE_STATE.OPTION) {
		//Check for keyboard input
		var _option = undefined;
		if (keyboard_check_pressed(ord("1"))) {
			_option = 0;
		}
		if (keyboard_check_pressed(ord("2"))) {
			_option = 1;
		}
		if (keyboard_check_pressed(ord("3"))) {
			_option = 2;
		}
		if (keyboard_check_pressed(ord("4"))) {
			_option = 3;
		}
		//If we've pressed a button, select that option
		if (_option != undefined) {
			ChatterboxSelect(chatterbox, _option);
			array_push(state.save_slot.current_node_option_queue, _option);
			current_state = DIALOGUE_STATE.TEXT;
			get_current_content();
			increment_current_node_position();
			touch_slot();
		}
	} else if (current_state == DIALOGUE_STATE.INPUT) {
		if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_delete)) {
			current_input_text = string_delete(
				current_input_text,
				string_length(current_input_text),
				1
			);
		} else {
			if (is_string(keyboard_lastchar) && keyboard_lastchar != "") {
				current_input_text += keyboard_lastchar;
				keyboard_lastchar = "";
			}
		}
	}
}

advance_icon_rotation = (advance_icon_rotation - 1.5) % 360;
