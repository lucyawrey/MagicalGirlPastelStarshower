if (instance_exists(Dialogue_Box)) exit;

if (instance_exists(Player) && distance_to_object(Player) < distance_to_player) {
    can_talk = true;
    if (keyboard_check_pressed(input_key)) {
        create_dialogue_box(text);
    }
}
else {
    can_talk = false;
}