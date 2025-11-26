gx = 20;
gy = global.game_height * 0.7;
var _box_width = global.game_width - gx * 2;
var _box_height = global.game_height - gy;

if (!is_undefined(current_background_sprite)) {
	draw_sprite(current_background_sprite, 0, 0, 0);
}

struct_foreach(current_shown_sprites, function(_key, _value) {
	draw_sprite_ext(
		_value.sprite,
		0,
		_value.x_pos,
		_value.y_pos,
		_value.x_scale,
		1,
		0,
		c_white,
		1
	);
});

if (!is_undefined(current_background_sprite)) {
	draw_sprite_stretched(spr_box, 0, gx, gy, _box_width, _box_height);
    if (current_character.name != "") {
        draw_sprite_stretched(spr_box, 0, gx + 10, gy - 15, 80, 30);
    }
}
