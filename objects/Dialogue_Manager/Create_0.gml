input_key = vk_space;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

current_text = "";
current_text_length = 0;
current_metadata = [];
current_character = get_character(global.default_character_id);
current_text_speed = current_character.text_speed;
current_char = 0;
current_line_position = 0;
text_to_draw = "";

load_all_chatterbox_files();
chatterbox = ChatterboxCreate();

function next() {
    var content = get_content();
    current_line_position++;
    current_char = 0;
    current_text = content.text;
    current_text_length = string_length(current_text);
    current_metadata = content.metadata;
    current_character = content.character;
    current_text_speed = content.character.text_speed;
}