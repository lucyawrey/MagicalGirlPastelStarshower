if (state.shared.developer_mode && InputPressed(INPUT_VERB.PAUSE)) {
	reset_save_state();
	game_soft_restart();
}
