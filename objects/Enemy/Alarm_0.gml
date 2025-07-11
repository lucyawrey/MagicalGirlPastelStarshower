if (instance_exists(Player) && distance_to_object(Player) < distance_to_player) {
    target_x = Player.x;
    target_y = Player.y;
}
else 
{
    target_x = random_range(xstart - 100, xstart + 100);
    target_y = random_range(ystart - 100, ystart + 100);
}

alarm[0] = alarm_time;