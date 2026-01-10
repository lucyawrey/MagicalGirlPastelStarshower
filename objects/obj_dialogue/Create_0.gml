// Set instance variables
typist = scribble_setup(); // Set up Scribble plugin for text rendering
chatterbox = chatterbox_setup(); // Set up Chatterbox plugin for dialogue scripting
current_state = DIALOGUE_STATE.TEXT;
current_node_metadata = {};
current_text = "";
current_metadata = [];
current_options = [];
current_selection = -2;
current_character = get_character();
current_background_sprite = undefined;
current_shown_sprites = {};
current_character_blocking = {};
current_music = undefined;
loading = false;
is_new_node = false;
delay_behavior = "";
advance_icon_rotation = 0;
draw_fullscreen = false;
// TODO please solve this properly
you_cannot_advance = false;

// Method definitions
function continue_on() {
	if (ChatterboxIsStopped(chatterbox)) {
		visible = false;
	} else if (ChatterboxIsWaiting(chatterbox)) {
		show_advance_icon = false;
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
		state.save.current_location = current_node_metadata.location;
		touch_save();
		save_game();
		is_new_node = false;
	}
	var _content = get_content();
	current_text = scribble_markdown_format(_content.text);
	current_metadata = _content.metadata;
	current_character = _content.character;
}
