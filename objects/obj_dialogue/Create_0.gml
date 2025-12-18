// Set instance variables
typist = scribble_setup(); // Set up Scribble plugin for text rendering
chatterbox = chatterbox_setup(); // Set up Chatterbox plugin for dialogue scripting
continue_key = vk_space;
current_state = DIALOGUE_STATE.TEXT;
current_node_metadata = {};
current_text = "";
current_metadata = [];
current_options = [];
current_character = get_character();
current_background_sprite = undefined;
current_shown_sprites = {};
current_character_blocking = {};
current_music = undefined;
current_input_text = "";
current_input_variable = "";
loading = false;
is_new_node = false;
delay_behavior = "";
gx = 0;
gy = 0;

// Method definitions
function continue_on() {
	if (ChatterboxIsStopped(chatterbox)) {
		visible = false;
	} else if (ChatterboxIsWaiting(chatterbox)) {
		ChatterboxContinue(chatterbox);
		if (current_state == DIALOGUE_STATE.OPTION) {
			current_state = DIALOGUE_STATE.TEXT;
		}
		if (!obj_game.paused || delay_behavior == "auto") {
			get_current_content();
			increment_current_node_position();
		}
	} else {
		current_state = DIALOGUE_STATE.OPTION;
		current_options = ChatterboxGetOptionArray(chatterbox);
	}
}

function get_current_content() {
	if (is_new_node) {
		current_node_metadata = ChatterboxGetCurrentMetadata(chatterbox);
		global.state.save_slot.current_location = current_node_metadata.location;
		touch_slot();
		save_game();
		is_new_node = false;
	}
	var _content = get_content();
	current_text = scribble_markdown_format(_content.text);
	current_metadata = _content.metadata;
	current_character = _content.character;
}
