function struct_merge(_destination, _source) {
	if (!is_struct(_destination) || !is_struct(_source)) {
		return;
	}
	destination_ = _destination;
	struct_foreach(_source, function(_name, _value) {
		struct_set(destination_, _name, _value);
	});
}

function struct_get_merged_value(_structs, _name) {
	for (var _i = array_length(_structs) - 1; _i >= 0; _i--) {
		var _item = _structs[_i];
		if (is_undefined(_item)) {
			continue;
		}
		if (is_string(_item) || is_bool(_item) || is_real(_item)) {
			return _item;
		}
		if (struct_exists(_item, _name)) {
			return struct_get(_item, _name);
		}
		if (struct_exists(_item, _name + ":")) {
			return struct_get(_item, _name + ":");
		}
	}
}

function get_pronoun_list(_pronouns) {
	out = {};
	var _list = struct_get(global.pronoun_map, _pronouns);
	array_foreach(_list, function(_item, _i) {
		struct_set(out, "player_gender_pronoun_" + string(_i), _item);
	});
	return out;
}

function add_prefix(_base_str, _prefix_str) {
	if (string_starts_with(_base_str, _prefix_str)) {
		return _base_str;
	} else {
		return _prefix_str + _base_str;
	}
}
