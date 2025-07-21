function save_game() {
    // TODO get file saving working
    // TODO break json saving to seperate function
    if (Game.state.shared_is_touched) 
    {
        var shared_json = json_stringify(Game.state.shared);
        var filename = "saves/shared.json";
        var file = file_text_open_write(filename);
        file_text_write_string(file, shared_json);
        Game.state.shared_is_touched = false;
    }
    
    // TODO obfuscate secrets
    if (Game.state.secret_is_touched) 
    {
        var secret_json = json_stringify(Game.state.secret);
        var filename = "game_data/internal_configuration";
        var file = file_text_open_write(filename);
        file_text_write_string(file, secret_json);
        Game.state.secret_is_touched = false;
    }
}

function load_game() {

}

function switch_slot() {
    
}

function switch_player() {
    
}