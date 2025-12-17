// Images
var _gutter = 18;
gx = _gutter * 3;
gy = global.view_height * 0.7;
var _box_width = global.view_width - gx * 2;
var _box_height = global.view_height - gy - _gutter;
var _bg_box_height = global.view_height - _box_height - _gutter * 3;
var _bg_width = _box_width - 12;
var _bg_height = _bg_box_height - 12;

if (!is_undefined(current_background_sprite)) {
	var _bg_box_border = is_undefined(current_character.background)
		? get_character(global.base_character_name).background
		: current_character.background;
	draw_sprite_stretched(_bg_box_border, 0, gx, _gutter, _box_width, _bg_box_height);
}

if (!is_undefined(current_background_sprite)) {
	draw_sprite_stretched(
		current_background_sprite,
		0,
		gx + 6,
		_gutter + 6,
		_bg_width,
		_bg_height
	);
}

if (!is_undefined(current_character.background)) {
	draw_sprite_stretched(
		current_character.background,
		0,
		gx,
		gy,
		_box_width,
		_box_height
	);
	if (current_character.name != "") {
		var _name_width = scribble($"{current_character.name}").get_width();
		var _name_box_width = _name_width + 50;
		if (
			struct_exists(current_character_blocking, current_character.id)
			&& struct_get(current_character_blocking, current_character.id) == "right"
		) {
			gx += global.view_width - _name_box_width - 138;
		} else {
			gx += 28;
		}
		draw_sprite_stretched(
			current_character.background,
			0,
			gx,
			gy - 36,
			_name_box_width,
			64
		);
	}
}

// Text
spacer = 40;
gx = 108;
gy = global.view_height * 0.7 + 34;
var _line_width = global.view_width - gx * 2;

if (current_state == DIALOGUE_STATE.TEXT) {
	//Draw text
	var _name_width = scribble($"{current_character.name}").get_width() / 2;
	var _name_x = gx;
	if (
		struct_exists(current_character_blocking, current_character.id)
		&& struct_get(current_character_blocking, current_character.id) == "right"
	) {
		_name_x = global.view_width - _name_width - 162;
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
