var _gutter = 9;
gx = _gutter * 3;
gy = global.game_height * 0.7;
var _box_width = global.game_width - gx * 2;
var _box_height = global.game_height - gy - _gutter;
var _bg_height = global.game_height - _box_height - _gutter * 3;

if (!is_undefined(current_background_sprite)) {
    draw_sprite_stretched(spr_box, 0, gx, _gutter, _box_width, _bg_height);
	draw_sprite(current_background_sprite, 0, gx + 4, _gutter + 4);
}

if (!is_undefined(current_character.background)) {
	draw_sprite_stretched(current_character.background, 0, gx, gy, _box_width, _box_height);
	if (current_character.name != "") {
		var _name_width = scribble($"{current_character.name}").get_width() / 2;
		var _name_box_width = _name_width + 25
		if (
			struct_exists(current_character_blocking, current_character.id)
			&& struct_get(current_character_blocking, current_character.id) == "right"
		) {
			gx += global.game_width - _name_box_width - 70;
		} else {
			gx += 15;
		}
		draw_sprite_stretched(spr_box, 0, gx, gy - 18, _name_box_width, 32);
	}
}
