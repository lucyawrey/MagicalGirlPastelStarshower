input_key = vk_space;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

messages = [];
current_message = 0;
current_char = 0;
message_to_draw = "";
char_speed = 0.5;

// https://www.jujuadams.com/Chatterbox/#/3.0/getting-started?id=gml-implementation
ChatterboxLoadFromFile("opening.yarn")
chatterbox = ChatterboxCreate();
ChatterboxJump(chatterbox, "OpeningDream");