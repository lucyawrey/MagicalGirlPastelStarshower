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
		if (InputPressed(INPUT_VERB.DOWN)) {
            play_nav_sound();
			if (current_selection < 0) {
				current_selection = -current_selection;
			}
			if (current_selection < 3) {
				current_selection++;
			} else {
				current_selection = 1;
			}
		} else if (InputPressed(INPUT_VERB.UP)) {
            play_nav_sound();
			if (current_selection < 0) {
				current_selection = -current_selection;
			}
			if (current_selection > 1) {
				current_selection--;
			} else {
				current_selection = 3;
			}
		} else if (InputPressed(INPUT_VERB.LEFT) || InputPressed(INPUT_VERB.RIGHT)) {
            play_nav_sound();
			current_selection = -current_selection;
		}
		//If we've pressed Accept, submit the current selected option to Chatterbox
		if (InputPressed(INPUT_VERB.ACCEPT) && current_selection > 0) {
            play_nav_sound();
			ChatterboxSelect(chatterbox, current_selection - 1);
			array_push(state.save.current_node_option_queue, current_selection - 1);
			current_state = DIALOGUE_STATE.TEXT;
			get_current_content();
			increment_current_node_position();
			touch_save();
			current_selection = -2;
		}
	}
}

advance_icon_rotation = (advance_icon_rotation - 1.5) % 360;
