spacer = 20 * global.gui_scale;
gx = 54 * global.gui_scale;
gy = global.gui_height * 0.7 + 34;
var _line_width = global.gui_width - gx * 2;

if (current_state == DIALOGUE_STATE.TEXT) {
	//Draw text
	var _name_width = scribble($"{current_character.name}").get_width() / 2;
	var _name_x = gx;
	if (
		struct_exists(current_character_blocking, current_character.id)
		&& struct_get(current_character_blocking, current_character.id) == "right"
	) {
		_name_x = global.gui_width - _name_width - 162;
	}

	if (current_character.name != "") {
		scribble($"[{current_character.name_color}]{current_character.name}").draw(
			_name_x,
			gy - 1.5 * spacer
		);
	}
	scribble(
		$"[speed,{current_character.text_speed}][{current_character.text_color}]{
			current_character.prefix
		}{current_text}{current_character.suffix}"
	)
		.wrap(_line_width)
		.draw(gx, gy, typist);
} else if (current_state == DIALOGUE_STATE.OPTION) {
	array_foreach(current_options, function(_option, _i) {
		scribble($"[#999999]{_i + 1}.[/] {_option.text}").draw(gx, gy);
		gy += spacer;
	});
} else if (current_state == DIALOGUE_STATE.INPUT) {
	gy += spacer;
	scribble($"{current_input_text}[c_gray]_").draw(gx, gy);
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
