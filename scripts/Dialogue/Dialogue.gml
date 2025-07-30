function show_dialogue(node)
{
    if (!instance_exists(Dialogue_Manager)) return;
    
    ChatterboxJump(Dialogue_Manager.chatterbox, node);
    Dialogue_Manager.next();
    Dialogue_Manager.visible = true;
}

function hide_dialogue() {
    if (instance_exists(Dialogue_Manager))
    {
        Dialogue_Manager.visible = false;
    }
}

function get_content() {
    if (!instance_exists(Dialogue_Manager)) return;
    
    var character_name = ChatterboxGetContentSpeaker(Dialogue_Manager.chatterbox, 0);
    var character_data = ChatterboxGetContentSpeakerData(Dialogue_Manager.chatterbox, 0);
    var character_id = "";
    if (character_name != "")
    {
        character_id += string_replace_all(string_lower(character_name), " ", "_");
    }
    if (character_data != "")
    {
        character_id += "_" + string_replace_all(string_lower(character_data), " ", "_")
    }
    var character = get_character(character_id);
    var metadata = ChatterboxGetContentMetadata(Dialogue_Manager.chatterbox, 0);
    var text = ChatterboxGetContentSpeech(Dialogue_Manager.chatterbox, 0);
    
    return {
        character, metadata, text,
    }
}