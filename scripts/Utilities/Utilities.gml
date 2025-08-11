function struct_merge(destination, source) {
	if (!is_struct(destination) || !is_struct(source)) {
		return;
	}
	destination_ = destination;
	struct_foreach(source, function(name, value) {
		struct_set(destination_, name, value);
	});
}

function struct_get_merged_value(structs, name) {
	for (var i = array_length(structs) - 1; i >= 0; i--) {
		var item = structs[i];
		if (is_undefined(item)) {
			continue;
		}
		if (is_string(item) || is_bool(item) || is_real(item)) {
			return item;
		}
		if (struct_exists(item, name)) {
			return struct_get(item, name);
		}
		if (struct_exists(item, name + ":")) {
			return struct_get(item, name + ":");
		}
	}
}

function hex_to_color(hex_code) {
	var hex_val = real("0x" + string_delete(hex_code, 1, 1));
	var red = (hex_val >> 16) & 0xFF;
	var green = (hex_val >> 8) & 0xFF;
	var blue = hex_val & 0xFF;
	return (blue << 16) | (green << 8) | red;
}
