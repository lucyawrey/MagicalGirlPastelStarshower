function background(background_name) {
    if (background_name == "none") {
        Dialogue_Manager.current_background_sprite = undefined;
    } else {
        var spr = asset_get_index(background_name);
        if (spr == -1) {
            Dialogue_Manager.current_background_sprite = undefined;
        } else {
            Dialogue_Manager.current_background_sprite = spr;   
        }
    }
}

function show(sprite_name, position) {
// TODO implement sprite drawing
}

function play(audio_type, audio_name) {
// TODO implement audio playing
}

function input(variable_name) {
// TODO implement user text input
}
