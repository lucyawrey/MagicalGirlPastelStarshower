characters = {
	narrator: {},
	stella_dream: {text_color: c_yellow},
	stella_narrator: {
		name: "Stella",
		name_color: c_yellow,
		text_color: c_silver,
		text_speed: 0.8,
		prefix: "(",
		suffix: ")",
	},
	stella: {name: "Stella", name_color: c_yellow},
	azalea: {name: "Azalea", name_color: c_purple},
	ever: {name: "Ever", name_color: c_green},
	lucy: {name: "Lucy", name_color: c_blue},
};

character_defaults = {
	name: "",
	name_color: c_white,
	text_color: c_white,
	text_speed: 1,
	prefix: "",
	suffix: "",
};

function get_character(character_id = undefined) {
	if (character_id == "" || character_id == undefined) {
		character_id = global.default_character_id;
	}
	if (!struct_exists(global.characters, character_id)) {
		throw "Invalid character ID: " + character_id;
	}

	var character = global.characters[$ character_id];

	return {
		name: struct_exists(character, "name")
			? character.name
			: global.character_defaults.name,
		name_color: struct_exists(character, "name_color")
			? character.name_color
			: global.character_defaults.name_color,
		text_color: struct_exists(character, "text_color")
			? character.text_color
			: global.character_defaults.text_color,
		text_speed: struct_exists(character, "text_speed")
			? character.text_speed
			: global.character_defaults.text_speed,
		prefix: struct_exists(character, "prefix")
			? character.prefix
			: global.character_defaults.prefix,
		suffix: struct_exists(character, "suffix")
			? character.suffix
			: global.character_defaults.suffix,
	};
}
