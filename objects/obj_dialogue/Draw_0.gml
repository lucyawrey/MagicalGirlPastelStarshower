// Images
var _MARGIN_Y = 18;
var _MARGIN_X = 3 * _MARGIN_Y;
var _BORDER_THICKNESS = 6;

var _NAME_MARGIN = 28;
var _NAME_PADDING = 25;

var _BACKGROUND_VIEW_PERCENT = 0.7;

gx = _MARGIN_Y * 3;
gy = global.view_height * 0.7;

draw_background(_MARGIN_X, _MARGIN_Y, _BACKGROUND_VIEW_PERCENT);
draw_textbox(_MARGIN_X, _MARGIN_Y, 1 - _BACKGROUND_VIEW_PERCENT);
draw_characters();
draw_text_advance_icon();

function draw_background(_margin_x, _margin_y, _view_height_percent) {
	var _x = _margin_x;
	var _y = _margin_y;
	var _w = global.view_width - _margin_x * 2;
	var _h = (global.view_height * _view_height_percent) - (2 * _margin_y);

	draw_background_border(_x, _y, _w, _h);
	draw_background_image(_x, _y, _w, _h, 6);
}

function draw_background_border(_x, _y, _w, _h) {
	if (is_undefined(current_background_sprite)) {
		return;
	}
	var _bg_box_border = is_undefined(current_character.background)
		? get_character(global.base_character_name).background
		: current_character.background;

	draw_sprite_stretched(_bg_box_border, 0, _x, _y, _w, _h);
}

function draw_background_image(
	_bg_box_x,
	_bg_box_y,
	_bg_box_w,
	_bg_box_h,
	_bg_box_thickness
) {
	var _x, _y, _w, _h = 0;
	if (draw_fullscreen) {
		_x = 0;
		_y = 0;
		_w = global.view_width;
		_h = global.view_height;
	} else {
		_x = _bg_box_x + _bg_box_thickness;
		_y = _bg_box_y + _bg_box_thickness;
		_w = _bg_box_w - _bg_box_thickness * 2;
		_h = _bg_box_h - _bg_box_thickness * 2;
	}

	if (is_undefined(current_background_sprite)) {
		if (!draw_fullscreen) {
			return;
		}
		draw_set_colour(c_black);
		draw_rectangle(_x, _y, _w, _h, false);
		return;
	}

	draw_sprite_stretched(current_background_sprite, 0, _x, _y, _w, _h);
}

function draw_textbox(_margin_x, _margin_y, _view_height_percent) {
	var _x = _margin_x;
	var _w = global.view_width - _margin_x * 2;
	var _h = (global.view_height * _view_height_percent) - _margin_y;
	var _y = global.view_height - _h - _margin_y;

	draw_textbox_background(_x, _y, _w, _h);
	draw_speaker_name(_x, _y, _w, 28, 28);
	draw_dialogue(_x, _y, _w);
	draw_options(_x, _y, _w);
}

function draw_textbox_background(_x, _y, _w, _h) {
	if (is_undefined(current_character.background)) {
		return;
	}
	draw_sprite_stretched(current_character.background, 0, _x, _y, _w, _h);
}

function draw_speaker_name(
	_textbox_x,
	_textbox_y,
	_textbox_w,
	_speaker_padding,
	_speaker_margin
) {
	if (is_undefined(current_character.background)) {
		return;
	}
	if (current_character.name == "") {
		return;
	}
	if (current_state != DIALOGUE_STATE.TEXT) {
		return;
	}

	var _name_scribble = scribble(
		$"[{current_character.name_color}]{current_character.name}"
	);
	var _speaker_w = _name_scribble.get_width();
	var _speaker_h = _name_scribble.get_height();

	var _speaker_box_x = _textbox_x + _speaker_margin;
	var _speaker_box_y = _textbox_y - 36;
	var _speaker_box_w = _speaker_w + (2 * _speaker_padding);
	var _speaker_box_h = 64;

	if (is_blocked_right()) {
		_speaker_box_x = _textbox_x + _textbox_w - _speaker_margin - _speaker_box_w;
	}

	var _speaker_x = _speaker_box_x + _speaker_padding;
	var _speaker_y = _speaker_box_y + ((_speaker_box_h - _speaker_h) / 2);

	draw_sprite_stretched(
		current_character.background,
		0,
		_speaker_box_x,
		_speaker_box_y,
		_speaker_box_w,
		_speaker_box_h
	);

	_name_scribble.draw(_speaker_x, _speaker_y);
}

function draw_dialogue(_textbox_x, _textbox_y, _textbox_w) {
	if (current_state != DIALOGUE_STATE.TEXT) {
		return;
	}

	var _padding_x = 48;
	var _padding_y = 34;
	var _x = _textbox_x + _padding_x;
	var _y = _textbox_y + _padding_y;
	var _w = _textbox_w - (2 * _padding_x);

	scribble(
		$"[speed,{current_character.text_speed}][{current_character.text_color}]{
			current_character.prefix
		}{current_text}{current_character.suffix}"
	)
		.wrap(_w)
		.draw(_x, _y, typist);
}

function draw_options(_textbox_x, _textbox_y, _textbox_w) {
	if (current_state != DIALOGUE_STATE.OPTION) {
		return;
	}
	var _padding_x = 48;
	var _padding_y = 34;
	var _x = _textbox_x + _padding_x;
	var _y = _textbox_y + _padding_y;

	array_foreach(current_options, function(_option, _i) {
		var _option_scribble = scribble($"[#999999]{_i + 1}.[/] {_option.text}");
		_option_scribble.draw(_x, _y);
		_y += 40;
	});
}

function draw_characters() {
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
}

// Text advance icon
function draw_text_advance_icon() {
	if (typist.get_state() != 1 || obj_game.paused || current_text == "") {
		return;
	}

	var _offset = get_offset_for_rotation(spr_star, advance_icon_rotation, 0.5);
	draw_sprite_ext(
		spr_star,
		0,
		global.view_width - 100 - _offset.x,
		global.view_height - 60 - _offset.y,
		0.5,
		0.5,
		advance_icon_rotation,
		c_white,
		1
	);
}

function is_blocked_right() {
	if (
		struct_exists(current_character_blocking, current_character.id)
		&& struct_get(current_character_blocking, current_character.id) == "right"
	) {
		return true;
	}
	return false;
}
