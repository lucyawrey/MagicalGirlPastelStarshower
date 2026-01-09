if (InputPressed(INPUT_VERB.PAUSE)) {
	if (paused == true) {
		unpause_game();
	} else {
		pause_game();
	}
}

if (paused == true && InputPressed(INPUT_VERB.RESET)) {
	reset_save_state();
	obj_game.load();
	unpause_game();
}
