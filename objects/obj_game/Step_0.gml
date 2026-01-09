if (InputPressed(INPUT_VERB.PAUSE)) {
  if (paused == true) unpause_game();
  else pause_game();
}

if (paused == true && InputPressed(INPUT_VERB.RESET)) {
	reset_save_state();
	game_soft_restart();
}
