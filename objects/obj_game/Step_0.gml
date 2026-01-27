if (InputPressed(INPUT_VERB.PAUSE)) {
	if (paused == false) {
		pause_game();
	}
}

if (paused == true && InputPressed(INPUT_VERB.RESET)) {
	reset_save_state();
	obj_dialogue.current_state = DIALOGUE_STATE.TEXT;
	obj_game.load();
	unpause_game();
}
