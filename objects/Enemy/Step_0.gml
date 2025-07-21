var _horizontal_vector = clamp(target_x - x, -1, 1);
var _vertical_vector = clamp(target_y - y, -1, 1);

move_and_collide(_horizontal_vector * move_speed, _vertical_vector * move_speed, [walls_tilemap, Enemy]);