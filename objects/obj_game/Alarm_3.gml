// Start game after loading time.
var _current_room = asset_get_index(state.save_slot.current_room);
room_goto(_current_room);
if (state.save_slot.in_dialogue_mode) {
	// Open dialogue screen to current saved location.
	show_dialogue(
		state.save_slot.current_node,
		state.save_slot.current_node_position,
		state.save_slot.current_node_option_queue
	);
}
