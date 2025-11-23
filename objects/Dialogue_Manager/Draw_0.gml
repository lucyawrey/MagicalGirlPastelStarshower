gx = 4;
gy = global.game_height * 0.65;
var box_width = global.game_width - gx * 2;
var box_height = global.game_height - gy - gx;

if (!is_undefined(current_background_sprite)) {
	draw_sprite(current_background_sprite, 0, 0, 0);
}

struct_foreach(current_shown_sprites, function(key, value) {
	draw_sprite(value.sprite, 0, value.x_pos, value.y_pos);
});

if (!is_undefined(current_background_sprite)) {
	draw_sprite_stretched(spr_box, 0, gx, gy, box_width, box_height);
}
