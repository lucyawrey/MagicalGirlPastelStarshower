function show_dialogue(messages)
{
    if (!instance_exists(Dialogue_Manager)) return;
    Dialogue_Manager.messages = messages;
    Dialogue_Manager.current_message = 0;
    Dialogue_Manager.visible = true;
}

function hide_dialogue() {
    if (instance_exists(Dialogue_Manager))
    {
        Dialogue_Manager.visible = false;    
    }
}