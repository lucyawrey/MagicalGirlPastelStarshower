input_key = vk_space;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

current_text = "";
current_text_length = 0;
current_metadata = [];
current_character = get_character(global.default_character_id);
current_text_speed = current_character.text_speed;
current_char = 0;
text_to_draw = "";
text_sound_clock = 0;

// Need to keep updated with values in draw event.
line_width = 1140;
character_width = 25.5;

// Chatterbox Setup
load_all_chatterbox_files();
chatterbox = ChatterboxCreate();
ChatterboxNodeChangeCallback(on_node_change);

function on_node_change(_old_node, new_node, _action) {
    Game.state.save_slot.current_node_position = 0;
    Game.state.save_slot.current_node = new_node;
    touch_slot();
    save_game();
}

function next() {
    ChatterboxContinue(chatterbox);
    Game.state.save_slot.current_node_position++;
    touch_slot();
    get_current_content();
}

function get_current_content() {
    var content = get_content();
    current_char = 0;
    current_text = add_text_line_breaks(content.text, line_width, character_width);
    current_text_length = string_length(current_text);
    current_metadata = content.metadata;
    current_character = content.character;
    current_text_speed = content.character.text_speed;
}