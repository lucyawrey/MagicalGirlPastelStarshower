// Start game after loading time.
var _current_room = asset_get_index(global.state.save_slot.current_room);
room_goto(_current_room);
if (global.state.save_slot.in_dialogue_mode) {
	// Open dialogue screen to current saved location.
	show_dialogue(
		global.state.save_slot.current_node,
		global.state.save_slot.current_node_position,
		global.state.save_slot.current_node_option_queue
	);
}
