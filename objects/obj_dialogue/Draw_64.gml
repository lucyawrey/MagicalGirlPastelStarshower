gpu_set_tex_filter(true);

gx = 34 * global.gui_scale;
gy = global.gui_height * 0.68;
spacer = 20 * global.gui_scale;
var _line_width = global.gui_width - gx * 2;

if (current_state == DIALOGUE_STATE.TEXT) {
	//Draw text
	scribble($"[{current_character.name_color}]{current_character.name}").draw(gx, gy);

	gy += spacer;

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

gpu_set_tex_filter(false);
