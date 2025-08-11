default_character_name = "Narrator";
characters = {};
characters_cache = {};

function get_character(character_name = "", character_data = "") {
	if (character_name == "") {
		character_name = global.default_character_name;
	}
	if (!struct_exists(global.characters, global.default_character_name)) {
		return;
	}
	var default_character = struct_get(global.characters, global.default_character_name);
	var character = struct_exists(global.characters, character_name)
		? struct_get(global.characters, character_name)
		: undefined;
	var variant = is_struct(character)
	&& struct_exists(character, "variants")
	&& struct_exists(character.variants, character_data)
		? struct_get(character.variants, character_data)
		: undefined;
	var queue = [default_character, character, variant];

	return {
		id: character_name + (is_string(character_data) ? "." + character_data : ""),
		name: struct_get_merged_value(
			[default_character, character_name, character, variant],
			"name"
		),
		name_color: hex_to_color(struct_get_merged_value(queue, "name_color")),
		text_color: hex_to_color(struct_get_merged_value(queue, "text_color")),
		text_speed: struct_get_merged_value(queue, "text_speed"),
		prefix: struct_get_merged_value(queue, "prefix"),
		suffix: struct_get_merged_value(queue, "suffix"),
	};
}
