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
        if (is_string(item) || is_bool(item) || is_real(item)) {
            return item;
        }
		if (struct_exists(item, name)) {
			return struct_get(item, name);
		}
	}
}
