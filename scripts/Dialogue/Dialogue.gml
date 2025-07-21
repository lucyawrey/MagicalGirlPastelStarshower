function create_dialogue_box(_messages){
    if (instance_exists(Dialogue_Box)) return;
    
    var _instance = instance_create_depth(0, 0, 0, Dialogue_Box)
    _instance.messages = _messages;
    _instance.current_message = 0;
}
