if (visible && !obj_game.paused) {
	if (obj_game.resumed_this_tick && !you_cannot_advance) {
		continue_on();
	}
	you_cannot_advance = false;

	if (current_state == DIALOGUE_STATE.TEXT) {
		if (typist.get_state() < 1) {
			if (InputPressed(INPUT_VERB.ACCEPT) || InputCheck(INPUT_VERB.RIGHT)) {
				typist.skip();
				audio_stop_sound(current_character.sound);
				exit;
			}
		}
		//If we're in a Text state then let the user press space to advance dialogue, or right to fast forward
		if (InputPressed(INPUT_VERB.ACCEPT) || InputCheck(INPUT_VERB.RIGHT)) {
			continue_on();
		}
	} else if (current_state == DIALOGUE_STATE.OPTION) {
		// TODO select option with directional input
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
		//If we've pressed a button, select that option
		if (_option != undefined) {
			ChatterboxSelect(chatterbox, _option);
			array_push(state.save.current_node_option_queue, _option);
			current_state = DIALOGUE_STATE.TEXT;
			get_current_content();
			increment_current_node_position();
			touch_save();
		}
	}
}

advance_icon_rotation = (advance_icon_rotation - 1.5) % 360;
