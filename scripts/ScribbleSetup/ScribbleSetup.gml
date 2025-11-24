// Global state
typist_sound_clock = 0; // Global clock state for typist sound effects

function scribble_setup() {
	var _typist = scribble_typist();
	_typist.in(1, 0);
	_typist.function_per_char(text_play_sound);
	scribble_font_set_default("fnt_dialogue");
	return _typist;
}

function text_play_sound(_element, _position, _typist) {
	var _current_char = string_char_at(obj_dialogue.current_text, _position);
	if (_typist.get_skip() || _current_char == " ") {
		return;
	}
	if (global.typist_sound_clock >= obj_dialogue.current_character.sound_spacing) {
		audio_play_sound(
			obj_dialogue.current_character.sound,
			1,
			false,
			0.5,
			undefined,
			obj_dialogue.current_character.sound_pitch
		);
		global.typist_sound_clock = 0;
	}
	global.typist_sound_clock++;
}
