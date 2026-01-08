var _horizontal_vector = real(keyboard_check(vk_right)) - real(keyboard_check(vk_left));
var _vertical_vector = real(keyboard_check(vk_down)) - real(keyboard_check(vk_up));

move_and_collide(
	_horizontal_vector * move_speed,
	_vertical_vector * move_speed,
	walls_tilemap,
	undefined,
	undefined,
	undefined,
	move_speed,
	move_speed
);

/* Animation Logic */
if (_horizontal_vector != 0 || _vertical_vector != 0) {
	animation_clock++;
	if (animation_clock >= animation_speed) {
		if (_vertical_vector > 0) {
			if (image_index == 0) {
				image_index = 2;
			} else {
				image_index = 0;
			}
		} else if (_vertical_vector < 0) {
			if (image_index == 9) {
				image_index = 11;
			} else {
				image_index = 9;
			}
		} else if (_horizontal_vector > 0) {
			if (image_index == 6) {
				image_index = 8;
			} else {
				image_index = 6;
			}
		} else if (_horizontal_vector < 0) {
			if (image_index == 3) {
				image_index = 5;
			} else {
				image_index = 3;
			}
		}
		animation_clock = 0;
	}
} else {
	if (image_index < 3) {
		image_index = 1;
	}
	if (image_index >= 3 && image_index < 5) {
		image_index = 4;
	}
	if (image_index >= 5 && image_index < 9) {
		image_index = 7;
	}
	if (image_index >= 9) {
		image_index = 10;
	}
	animation_clock = animation_speed;
}
