available_save_slots = 5;

state = {
    game_is_loaded: false,
    /* /saves/shared.json */
    shared: {
        active_save_slot_number: 0,
        active_player_name: "",
    },
    /* /saves/slots/slot_[number].json */
    save_slot: {
        player_name: "",
    },
    /* /saves/players/player_[name].json */
    player: {
        name: "",
        gender: {
            fluid: false,
            // Enum - Androgynous, Feminine, Masculine
            form: "Androgynous",
            // Enum - ItIts, TheyThem, SheHer, HeHim, Custom
            pronouns: "ItIts",
        }
    },
    /* /game_data/internal_configuration */
    secret: {
        player_names: [],
        file_hashes: {}
    },
}
