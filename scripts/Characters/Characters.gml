default_character_name = "Narrator";
characters = {};
characters_cache = {};

function get_character(
	character_name = global.default_character_name,
	character_data = undefined
) {
	if (
		!struct_exists(global.characters, character_name)
		|| !struct_exists(global.characters, global.default_character_name)
	) {
		return;
	}
	var default_character = struct_get(global.characters, global.default_character_name);
	var character = struct_get(global.characters, character_name);
	var variant = struct_exists(character, character_data)
		? struct_get(character, character_data)
		: undefined;

	return {
		name: struct_get_merged_value(
			[default_character, character_name, character, variant],
			"name"
		),
		name_color: struct_get_merged_value(
			[default_character, character, variant],
			"name_color"
		),
		text_color: struct_get_merged_value(
			[default_character, character, variant],
			"text_color"
		),
		text_speed: struct_get_merged_value(
			[default_character, character, variant],
			"text_speed"
		),
		prefix: struct_get_merged_value(
			[default_character, character, variant],
			"prefix"
		),
		suffix: struct_get_merged_value(
			[default_character, character, variant],
			"suffix"
		),
	};
}
