// Move to initial room from save.
var current_room = asset_get_index(state.save_slot.current_room);
room_goto(current_room);
// Open dialogue screen to current saved location.
show_dialogue(state.save_slot.current_node, state.save_slot.current_node_position, state.save_slot.current_node_option_queue);
