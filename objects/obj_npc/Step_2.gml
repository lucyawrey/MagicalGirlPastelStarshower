if (!instance_exists(obj_dialogue) || obj_dialogue.visible) {
	exit;
}

if (instance_exists(Player) && distance_to_object(Player) < distance_to_player) {
	can_talk = true;
	if (InputPressed(INPUT_VERB.ACCEPT)) {
		show_dialogue(text);
	}
} else {
	can_talk = false;
}
