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
	ChatterboxAddFunction("input", input);
	ChatterboxAddFunction("delay", delay);
    ChatterboxAddFunction("auto", auto);
	ChatterboxAddFunction("block", block);

	return _chatterbox;
}
