var dx = 5;
var dy = gui_height * 0.65;
var box_width = gui_width - dx * 2;
var box_height = gui_height - dy - 5;

draw_sprite_stretched(spr_box, 0, dx, dy, box_width, box_height);

dx += 60;
dy += 25;

draw_set_font(Dialogue_Font);

draw_set_color(current_character.name_color);
draw_text(dx, dy, current_character.name);
draw_set_color(current_character.text_color);

dy += 40;

draw_text_ext(dx, dy, text_to_draw, -1, line_width);