if (!instance_exists(Dialogue_Manager) || Dialogue_Manager.visible) exit;

if (instance_exists(Player) && distance_to_object(Player) < distance_to_player)
{
    can_talk = true;
    if (keyboard_check_released(input_key))
    {
        show_dialogue(text);
    }
}
else
{
    can_talk = false;
}