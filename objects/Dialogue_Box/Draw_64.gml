var dx = 0;
var dy = gui_height * 0.7;
var box_width = gui_width;
var box_height = gui_height - dy;

draw_sprite_stretched(spr_box, 0, dx, dy, box_width, box_height);

dx += 16;
dy += 16;

draw_set_font(Dialogue_Font);

var character = messages[current_message].character;
draw_set_color(global.characters[$ character].color);
draw_text(dx, dy, global.characters[$ character].name);
draw_set_color(c_white);

dy += 40;

draw_text_ext(dx, dy, message_to_draw, -1, box_width - dx * 2);