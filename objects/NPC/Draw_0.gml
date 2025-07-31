draw_self();

if (can_talk && instance_exists(Dialogue_Manager) && !Dialogue_Manager.visible)
{
    draw_sprite(spr_talk, 0, x, y);
}