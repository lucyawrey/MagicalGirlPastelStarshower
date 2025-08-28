var dx = 5;
var dy = gui_height * 0.65;
var box_width = gui_width - dx * 2;
var box_height = gui_height - dy - 5;

// Draw Images
if (!is_undefined(current_background_sprite)) {
	draw_sprite(current_background_sprite, 0, 0, 0);
}

struct_foreach(current_shown_sprites, function(key, value) {
	draw_sprite(value.sprite, 0, value.x_pos, value.y_pos);
});

if (!is_undefined(current_background_sprite)) {
	draw_sprite_stretched(spr_box, 0, dx, dy, box_width, box_height);
}

dx += 60;
dy += 25;

//Draw text
scribble($"[{current_character.name_color}]{current_character.name}").draw(dx, dy);

dy += 40;

scribble(
	$"[pitch,{current_character.sound_pitch}][speed,{current_character.text_speed}][{current_character.text_color}]{
		current_character.prefix
	}{current_text}{current_character.suffix}"
)
	.wrap(box_width - 120)
	.draw(dx, dy, typist);
