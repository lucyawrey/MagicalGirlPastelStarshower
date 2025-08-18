if (visible && !Game.paused) {
	if (Game.resumed) {
		continue_on();
	}
	if (typist.get_state() < 1) {
		if (keyboard_check_released(input_key)) {
			typist.skip();
			audio_play_sound(click, 1, false, 0.5, undefined, 1);
			exit;
		}
	}

	if (ChatterboxIsStopped(chatterbox)) {
		visible = false;
	} else if (ChatterboxIsWaiting(chatterbox)) {
		//If we're in a "waiting" state then let the user press <space> to advance dialogue
		if (keyboard_check_released(input_key)) {
			continue_on();
		}
	} else {
		//If we're not waiting then we have some options!
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
		}
	}
}
