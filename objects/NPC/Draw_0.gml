draw_self();

if (can_talk && !instance_exists(Dialogue_Box))
{
    draw_sprite(spr_talk, 0, x, y - 16);
}