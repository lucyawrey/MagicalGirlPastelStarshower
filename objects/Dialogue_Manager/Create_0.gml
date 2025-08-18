// Chatterbox Setup
load_all_chatterbox();
chatterbox = ChatterboxCreate();
ChatterboxNodeChangeCallback(on_node_change);
ChatterboxVariableSetCallback(on_chatterbox_variable_set);
ChatterboxAddFunction("background", background);
ChatterboxAddFunction("show", show);
ChatterboxAddFunction("hide", hide);
ChatterboxAddFunction("play", play);
ChatterboxAddFunction("pause", pause);
ChatterboxAddFunction("input", input);
ChatterboxAddFunction("delay", delay);

// Scribble setup
typist = scribble_typist();
typist.in(1, 0);
typist.function_per_char(text_play_sound);
typist_sound_clock = 0;
scribble_font_set_default("Base_Font");

// Object variable definitions
input_key = vk_space;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

current_state = DialogueState.Text;
current_node_metadata = {};
current_text = "";
current_metadata = [];
current_character = get_character();
current_background_sprite = undefined;
current_shown_sprites = {};
current_music = undefined;
loading = false;
is_new_node = false;
delay_behavior = "";

// Method definitions
function continue_on() {
	ChatterboxContinue(chatterbox);
	if (ChatterboxIsStopped(chatterbox)) {
		visible = false;
	} else if (ChatterboxIsWaiting(chatterbox)) {
		current_state = DialogueState.Text;
		if (!Game.paused || delay_behavior == "next") {
			get_current_content();
			increment_current_node_position();
		}
	} else {
		// TODO Option
		current_state = DialogueState.Option;
	}
}

function get_current_content() {
	if (is_new_node) {
		current_node_metadata = ChatterboxGetCurrentMetadata(chatterbox);
		Game.state.save_slot.current_location = current_node_metadata.location;
		touch_slot();
		save_game();
		is_new_node = false;
	}
	var content = get_content();
	current_text = scribble_markdown_format(content.text);
	current_metadata = content.metadata;
	current_character = content.character;
}
