var _horizontal_vector = real(keyboard_check(ord("D"))) - real(keyboard_check(ord("A")));
var _vertical_vector = real(keyboard_check(ord("S"))) - real(keyboard_check(ord("W")));

move_and_collide(_horizontal_vector * move_speed, _vertical_vector * move_speed, walls_tilemap, undefined, undefined, undefined, move_speed, move_speed);

if (_horizontal_vector != 0 or _vertical_vector != 0) {    
    if (_vertical_vector > 0) sprite_index = spr_player_walk_down;
    else if (_vertical_vector < 0) sprite_index = spr_player_walk_up;
    else if (_horizontal_vector > 0) sprite_index = spr_player_walk_right;
    else if (_horizontal_vector < 0) sprite_index = spr_player_walk_left;
}
else {
    if (sprite_index == spr_player_walk_down) sprite_index = spr_player_idle_down;
    if (sprite_index == spr_player_walk_up) sprite_index = spr_player_idle_up;
    if (sprite_index == spr_player_walk_right) sprite_index = spr_player_idle_right;
    if (sprite_index == spr_player_walk_left) sprite_index = spr_player_idle_left;
}