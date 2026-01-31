// Set instance variables
typist = scribble_setup(); // Set up Scribble plugin for text rendering
current_state = DIALOGUE_STATE.TEXT;
current_tags = [];
current_text = "";
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

// Setup character db
load_character_files();
// Setup external ink Story
story_setup();

// Method definitions
function continue_on() { 
    if (story_can_continue()) {
		show_advance_icon = false;
        current_state = DIALOGUE_STATE.TEXT;
		if (!obj_game.paused || delay_behavior == "auto") {
			get_current_content();
			increment_current_node_position();
		}
	} else {
		current_state = DIALOGUE_STATE.OPTION;
		current_options = story_get_choices();
	}
}

function get_current_content() {
	if (is_new_node) {
		current_tags = story_get_tags();
        array_foreach(current_tags, function(_tag) {
            if (string_starts_with(_tag, "location ")) {
    			state.save.current_location = string_delete(_tag, 1, 9);
    		}
    		if (string_starts_with(_tag, "day ")) {
    			state.save.day = real(string_delete(_tag, 1, 4));
    		}
        })
		touch_save();
		save_game();
		is_new_node = false;
	}

    // TODO get content tags
	var _content = story_continue();
	var _parsed = parse_text_and_character_id(_content);
	current_text = scribble_markdown_format(_parsed.text);
	current_character = get_character(_parsed.character_id);
	draw_fullscreen = current_character.fullscreen;
}
