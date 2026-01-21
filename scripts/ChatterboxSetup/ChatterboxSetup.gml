function chatterbox_setup() {
	load_all_chatterbox();
	var _chatterbox = ChatterboxCreate();

	ChatterboxNodeChangeCallback(on_node_change);
	ChatterboxVariableSetCallback(on_chatterbox_variable_set);

	ChatterboxAddFunction("background", background);
	ChatterboxAddFunction("show", show);
	ChatterboxAddFunction("hide", hide);
	ChatterboxAddFunction("play", play);
	ChatterboxAddFunction("pause", pause);
	ChatterboxAddFunction("delay", delay);
	ChatterboxAddFunction("auto", auto);
	ChatterboxAddFunction("block", block);
	ChatterboxAddFunction("end_game", end_game);
	ChatterboxAddFunction("event", event);

	return _chatterbox;
}

function on_node_change(_old_node, _new_node, _action) {
	if (state.save.current_node != _new_node) {
		state.save.current_node_position = 0;
		state.save.current_node = _new_node;
	}
	touch_save();
	obj_dialogue.is_new_node = true;
}
