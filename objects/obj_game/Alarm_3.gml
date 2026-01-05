// Start game after loading time.
var _current_room = asset_get_index(state.save.current_room);
room_goto(_current_room);
if (state.save.in_dialogue_mode) {
	// Open dialogue screen to current saved location.
	show_dialogue(
		state.save.current_node,
		state.save.current_node_position,
		state.save.current_node_option_queue
	);
}
