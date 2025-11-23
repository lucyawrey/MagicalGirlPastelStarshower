draw_self();

if (can_talk && instance_exists(obj_dialogue) && !obj_dialogue.visible) {
	draw_sprite(spr_talk, 0, x, y);
}
