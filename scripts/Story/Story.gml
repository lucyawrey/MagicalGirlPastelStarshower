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
    
    content = json_parse(story_json);
    
    static get_content = function()
    {
        return content;
    }
}
