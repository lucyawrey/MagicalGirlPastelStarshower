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
	var _list = struct_get(PRONOUN_MAP, _pronouns);
	array_foreach(_list, function(_item, _i) {
		struct_set(out, "gender_pronoun_" + string(_i), _item);
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

function get_offset_for_rotation(_sprite, _angle, _scale = 2) {
	var _w = sprite_get_width(_sprite) * _scale;
	var _h = sprite_get_height(_sprite) * _scale;

	return {
		x: sqrt(power(_w, 2) + power(_h, 2)) / 2 * dcos(-_angle + darctan(_h / _w)),
		y: sqrt(power(_w, 2) + power(_h, 2)) / 2 * dsin(-_angle + darctan(_h / _w)),
	};
}

function play_nav_sound(_pitch = 0.3) {
	audio_play_sound(snd_click, 1, false, 0.4, undefined, _pitch);
}

function get_meta_name(_metadata, _node) {
	if (
		is_array(_metadata)
		&& array_length(_metadata) > 0
		&& is_string(_metadata[0])
		&& is_string(_node)
	) {
		return $"{_node}.{_metadata[0]}";
	}
	return "none";
}
