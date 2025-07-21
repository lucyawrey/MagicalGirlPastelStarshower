var _x = 0;
var _y = gui_height * 0.7;
var _box_width = gui_width;
var _box_height = gui_height - _y;

draw_sprite_stretched(spr_box, 0, _x, _y, _box_width, _box_height);

_x += 16;
_y += 16;

draw_set_font(Dialogue_Font);

var _character = messages[current_message].character;
draw_set_color(global.characters[$ _character].color);
draw_text(_x, _y, global.characters[$ _character].name);
draw_set_color(c_white);

_y += 40;

draw_text_ext(_x, _y, message_to_draw, -1, _box_width - _x * 2);