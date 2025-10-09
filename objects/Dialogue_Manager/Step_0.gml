if (visible && !Game.paused) {
	if (Game.resumed) {
		continue_on();
	}

	if (current_state == DialogueState.Text) {
        if (typist.get_state() < 1) {
    		if (keyboard_check_released(continue_key)) {
    			typist.skip();
    			audio_play_sound(click, 1, false, 0.5, undefined, 1);
    			exit;
    		}
    	}
		//If we're in a Text state then let the user press space to advance dialogue
		if (keyboard_check_released(continue_key)) {
			continue_on();
		}
	} else if (current_state == DialogueState.Option) {
		//Check for keyboard input
		var option = undefined;
		if (keyboard_check_released(ord("1"))) {
			option = 0;
		}
		if (keyboard_check_released(ord("2"))) {
			option = 1;
		}
		if (keyboard_check_released(ord("3"))) {
			option = 2;
		}
		if (keyboard_check_released(ord("4"))) {
			option = 3;
		}
		//If we've pressed a button, select that option
		if (option != undefined) {
			ChatterboxSelect(chatterbox, option);
            array_push(Game.state.save_slot.current_node_option_queue, option);
            current_state = DialogueState.Text;
            get_current_content();
            increment_current_node_position();
            touch_slot();
		}
	} else if (current_state == DialogueState.Input) {
        if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_delete)) {
            current_input_text = string_delete(current_input_text, string_length(current_input_text), 1);
        } else {
            if (is_string(keyboard_lastchar) && keyboard_lastchar != "") {
                current_input_text += keyboard_lastchar;
                keyboard_lastchar = "";
            }
        }
    }
}
