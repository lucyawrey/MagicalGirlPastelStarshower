function save_game() {
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
}

function load_game() {

}

function switch_slot() {
    
}

function switch_player() {
    
}

function write_text_to_file_by_filename(filename, text) {
    var file = file_text_open_write(filename);
    file_text_write_string(file, text);
    file_text_close(file);
}