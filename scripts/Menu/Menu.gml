function pause_game() {
	obj_game.pause();
	if (instance_exists(obj_pause_menu)) {
		obj_pause_menu.open();
	}
	log("PAUSED");
}

function unpause_game() {
	obj_game.unpause();
	if (instance_exists(obj_pause_menu)) {
		obj_pause_menu.close();
	}
	log("UNPAUSED");
}
