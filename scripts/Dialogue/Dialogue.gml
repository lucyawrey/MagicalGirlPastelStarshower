function create_dialogue_box(messages)
{
    if (instance_exists(Dialogue_Box)) return;
    
    var instance = instance_create_depth(0, 0, 0, Dialogue_Box);
    instance.messages = messages;
    instance.current_message = 0;
}