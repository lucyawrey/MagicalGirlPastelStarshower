function Story(json_filename = undefined, json_string = undefined, json_buffer = undefined) constructor
{
    var story_json;
    var buffer;
    if (is_string(json_filename)) {
        buffer = buffer_load(json_filename);
    } else if (is_string(json_string)) {
        story_json = json_string;
    } else if (buffer_exists(json_buffer)) {
        buffer = json_buffer;
    } else {
        throw ("Must provide either a filename of a valid JSON file, a JSON string, or JSON file buffer to create a Story.");
    }
    if (buffer_exists(buffer)) {
        story_json = buffer_read(buffer, buffer_string);
        buffer_delete(buffer);
    }
    var content = json_parse(story_json);
    if (content.inkVersion < 1 || content.inkVersion > 21) {
        throw ("Unsupported Ink version.")
    }
    
    list_defs = content.list_defs;
    root = content.root;
    
    state = {};
    can_continue = true;
    current_choices = [];
    current_choices_count = [];
    
    static continue_forward = function()
    {
    }
    
    static choose_choice_index = function(index)
    {
    }
}
