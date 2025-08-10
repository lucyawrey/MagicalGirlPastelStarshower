function Story(filename = undefined, json_string = undefined, file_buffer = undefined) constructor
{
    var story_json = _get_string_from_file_or_buffer(filename, json_string, file_buffer);
    var content = json_parse(story_json);
    
    ink_version_minimum_compatible = 18;
    ink_version_current = content.inkVersion;
    list_definitions = content.listDefs;
    root = content.root;
    
    can_continue = true;
    current_text = "";
    current_choices = [];
    current_choices_count = [];
    current_tags = [];
    currentErrors = [];
    currentWarnings = [];
    hasWarning = false;
    state = {};
    
    static continue_forward = function()
    {
    }
    
    static choose_choice_index = function(index)
    {
    }
}

function _get_string_from_file_or_buffer(filename = undefined, raw_string = undefined, buffer = undefined) {
    var out_text;
    var temp_buffer;
    if (is_string(filename)) {
        temp_buffer = buffer_load(filename);
    } else if (is_string(raw_string)) {
        out_text = raw_string;
    } else if (buffer_exists(buffer)) {
        temp_buffer = buffer;
    } else {
        throw ("Must provide either a filename of a valid JSON file, a JSON string, or JSON file buffer to create a Story.");
    }
    if (buffer_exists(temp_buffer)) {
        out_text = buffer_read(temp_buffer, buffer_string);
        buffer_delete(temp_buffer);
    }
    
    return out_text;
}