default_character_name = "Narrator";
default_character_data = "Default";
default_character = {
	name: "",
	name_color: "#FFFFFF",
	text_color: "#FFFFFF",
	text_speed: 1,
	prefix: "",
	suffix: "",
};

function get_character(character_name = undefined, character_data = undefined) {
	if (character_id == "" || character_id == undefined) {
		character_id = global.default_character_id;
	}
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
			: global.default_character.name,
		name_color: struct_exists(character, "name_color")
			? character.name_color
			: global.default_character.name_color,
		text_color: struct_exists(character, "text_color")
			? character.text_color
			: global.default_character.text_color,
		text_speed: struct_exists(character, "text_speed")
			? character.text_speed
			: global.default_character.text_speed,
		prefix: struct_exists(character, "prefix")
			? character.prefix
			: global.default_character.prefix,
		suffix: struct_exists(character, "suffix")
			? character.suffix
			: global.default_character.suffix,
	};
}
