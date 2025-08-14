function get_character(character_name = "", character_data = "") {
	if (character_name == "") {
		character_name = global.default_character_name;
	}

	var character_id =
		character_name + (character_data == "" ? "" : "." + character_data);
	if (struct_exists(global.characters_cache, character_id)) {
		return struct_get(global.characters_cache, character_id);
	}

	if (!struct_exists(global.characters, global.default_character_name)) {
		return;
	}
	var default_character = struct_get(global.characters, global.default_character_name);
	var base_character = struct_exists(global.characters, character_name)
		? struct_get(global.characters, character_name)
		: undefined;
	var variant = is_struct(base_character)
	&& struct_exists(base_character, "variants")
	&& struct_exists(base_character.variants, character_data)
		? struct_get(base_character.variants, character_data)
		: undefined;
	var queue = [default_character, base_character, variant];

	var character = {
		id: character_id,
		name: struct_get_merged_value(
			[default_character, character_name, base_character, variant],
			"name"
		),
		name_color: struct_get_merged_value(queue, "name_color"),
		text_color: struct_get_merged_value(queue, "text_color"),
		text_speed: struct_get_merged_value(queue, "text_speed"),
		prefix: struct_get_merged_value(queue, "prefix"),
		suffix: struct_get_merged_value(queue, "suffix"),
	};

	struct_set(global.characters_cache, character_id, character);

	return character;
}
