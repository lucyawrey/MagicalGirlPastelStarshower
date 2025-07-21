state = {
    game_is_loaded: false,
    shared_is_touched: false,
    save_slot_is_touched: false,
    player_is_touched: false,
    secret_is_touched: false,
    /* /saves/shared.json */
    shared: {
        active_save_slot_number: 0,
        active_player_name: "",
    },
    /* /saves/slots/slot_[number].json */
    save_slot: {
        player_name: "",
        current_room: "",
        current_scene: "",
        scene_position: 0,
    },
    /* /saves/players/player_[name].json */
    player: {
        name: "",
        gender: {
            is_fluid: false,
            form: PlayerForm.Androgynous,
            pronouns: PlayerPronouns.ItIts,
        }
    },
    /* /game_data/internal_configuration */
    secret: {
        player_names: [],
        file_hashes: {}
    },
}
