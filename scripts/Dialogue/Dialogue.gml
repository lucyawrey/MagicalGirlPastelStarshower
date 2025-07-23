function create_Dialogue_Manager(messages)
{
    if (instance_exists(Dialogue_Manager)) return;
    
    var instance = instance_create_depth(0, 0, 0, Dialogue_Manager);
    instance.messages = messages;
    instance.current_message = 0;
}