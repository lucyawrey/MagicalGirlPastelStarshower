var horizontal_vector = clamp(target_x - x, -1, 1);
var vertical_vector = clamp(target_y - y, -1, 1);

move_and_collide(
	horizontal_vector * move_speed,
	vertical_vector * move_speed,
	[walls_tilemap, Enemy]
);
