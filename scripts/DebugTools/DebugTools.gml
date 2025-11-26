function debug_loop() {
	if (keyboard_check_pressed(vk_escape)) {
		global.state.save_slot = global.initial_state.save_slot;
		obj_game.alarm[3] = 1;
	}
}
