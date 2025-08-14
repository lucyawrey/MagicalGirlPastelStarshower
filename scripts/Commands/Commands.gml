function background(background_name){
    if (background_name == "none") {
        Dialogue_Manager.current_background_sprite = undefined;
    } else {
        var spr = asset_get_index(background_name);
        Dialogue_Manager.current_background_sprite = spr;
    }
}
