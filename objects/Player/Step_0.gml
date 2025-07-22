var horizontal_vector = real(keyboard_check(right_key)) - real(keyboard_check(left_key));
var vertical_vector = real(keyboard_check(down_key)) - real(keyboard_check(up_key));

move_and_collide(horizontal_vector * move_speed, vertical_vector * move_speed, walls_tilemap, undefined, undefined, undefined, move_speed, move_speed);

if (horizontal_vector != 0 or vertical_vector != 0) {    
    if (vertical_vector > 0) sprite_index = spr_player_walk_down;
    else if (vertical_vector < 0) sprite_index = spr_player_walk_up;
    else if (horizontal_vector > 0) sprite_index = spr_player_walk_right;
    else if (horizontal_vector < 0) sprite_index = spr_player_walk_left;
}
else {
    if (sprite_index == spr_player_walk_down) sprite_index = spr_player_idle_down;
    if (sprite_index == spr_player_walk_up) sprite_index = spr_player_idle_up;
    if (sprite_index == spr_player_walk_right) sprite_index = spr_player_idle_right;
    if (sprite_index == spr_player_walk_left) sprite_index = spr_player_idle_left;
}