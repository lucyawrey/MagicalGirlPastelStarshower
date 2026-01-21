function scribble_setup() {
	var _typist = scribble_typist();
	_typist.in(1, 0);
	_typist.function_per_char(text_play_sound);
	_typist.function_on_complete(on_typist_complete);
	scribble_font_set_default(DEFAULT_FONT);
	return _typist;
}

function on_typist_complete() {
	if (obj_game.indefinitely_paused() && obj_dialogue.delay_behavior == "auto") {
		obj_game.unpause();
	}
}

function text_play_sound(_element, _position, _typist) {
	var _current_char = string_char_at(obj_dialogue.current_text, _position);
	if (_typist.get_skip() || _current_char == " ") {
		return;
	}
	var _rand_pitch = random_range(-0.2, 0.2);
	if (state.typist_sound_clock >= obj_dialogue.current_character.sound_spacing) {
		audio_play_sound(
			obj_dialogue.current_character.sound,
			1,
			false,
			0.5,
			undefined,
			obj_dialogue.current_character.sound_pitch + _rand_pitch
		);
		state.typist_sound_clock = 0;
	}
	{
		state.typist_sound_clock++;
	}
}
