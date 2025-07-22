function save_game()
{
    if (Game.state.shared_is_touched) 
    {
        var shared_json = json_stringify(Game.state.shared);
        write_text_to_file_by_filename(global.shared_path, shared_json);
        Game.state.shared_is_touched = false;
    }
    
    if (Game.state.secret_is_touched)
    {
        var secret_json = json_stringify(Game.state.secret);
        // TODO encrypt secrets with static secret key instead of encoding them.
        // TODO it would be a fun to see players decrypt them, so actual security does not matter!
        var secret_base64 = base64_encode(secret_json);
        write_text_to_file_by_filename(global.secret_path, secret_base64);
        Game.state.secret_is_touched = false;
    }
    
    if (Game.state.save_slot_is_touched)
    {
        var save_slot_json = json_stringify(Game.state.save_slot);
        var number_string = string(Game.state.shared.active_save_slot_id);
        var filename = global.slot_path + number_string + global.json_ext;
        write_text_to_file_by_filename(filename, save_slot_json)
        Game.state.shared_is_touched = false;
    }
    
    if (Game.state.player_is_touched)
    {
        var player_json = json_stringify(Game.state.player);
        var number_string = string(Game.state.shared.active_player_id);
        var filename = global.player_path + number_string + global.json_ext;
        write_text_to_file_by_filename(filename, player_json)
        Game.state.shared_is_touched = false;
    }
}

function load_game()
{
    // TODO keep int64s and enums when parsing json
    // TODO handle missing save files
    var shared_json = read_text_from_file_by_filename(global.shared_path);
    Game.state.shared = json_parse(shared_json);
    
    var secret_base64 = read_text_from_file_by_filename(global.secret_path);
    var secret_json =  base64_decode(secret_base64);
    Game.state.secret = json_parse(secret_json);
    
    var slot_number_string = string(Game.state.shared.active_save_slot_id);
    var slot_filename = global.slot_path + slot_number_string + global.json_ext;
    var save_slot_json = read_text_from_file_by_filename(slot_filename);
    Game.state.save_slot = json_parse(save_slot_json);
    
    var player_number_string = string(Game.state.shared.active_player_id);
    var player_filename = global.player_path + player_number_string + global.json_ext;
    var player_json = read_text_from_file_by_filename(player_filename);
    Game.state.player = json_parse(player_json);
}

function switch_slot()
{
    
}

function switch_player()
{
    
}

function write_text_to_file_by_filename(filename, text)
{
    var file = file_text_open_write(filename);
    file_text_write_string(file, text);
    file_text_close(file);
}

function read_text_from_file_by_filename(filename)
{
    var file = file_text_open_read(filename);
    var text = file_text_read_string(file);
    file_text_close(file);
    return text;
}

function touch_shared()
{
    Game.state.shared_is_touched = true;
}

function touch_secret()
{
    Game.state.secret_is_touched = true;
}

function touch_slot()
{
    Game.state.save_slot_is_touched = true;
}

function touch_player() 
{
    Game.state.player_is_touched = true;
}