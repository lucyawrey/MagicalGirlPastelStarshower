function save_game()
{
    if (Game.state.shared_is_touched) 
    {
        var shared_json = json_stringify(Game.state.shared);
        write_text_to_file_by_filename("saves/shared.json", shared_json)
        Game.state.shared_is_touched = false;
    }
    
    if (Game.state.secret_is_touched)
    {
        var secret_json = json_stringify(Game.state.secret);
        // TODO encrypt secrets with static secret key instead of encoding them.
        // TODO it would be a fun to see players decrypt them, so actual security does not matter!
        var secret_base64 = base64_encode(secret_json);
        write_text_to_file_by_filename("game_data/internal.dat", secret_base64)
        Game.state.secret_is_touched = false;
    }
    
    if (Game.state.save_slot_is_touched)
    {
        var save_slot_json = json_stringify(Game.state.save_slot);
        var number_string = string(Game.state.shared.active_save_slot_id);
        var filename = "saves/slots/slot_" + number_string + ".json";
        write_text_to_file_by_filename(filename, save_slot_json)
        Game.state.shared_is_touched = false;
    }
    
    if (Game.state.player_is_touched)
    {
        var player_json = json_stringify(Game.state.player);
        var number_string = string(Game.state.shared.active_player_id);
        var filename = "saves/players/player_" + number_string + ".json";
        write_text_to_file_by_filename(filename, player_json)
        Game.state.shared_is_touched = false;
    }
}

function load_game()
{

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