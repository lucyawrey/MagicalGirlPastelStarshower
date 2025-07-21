state = {
    game_is_started: false,
    shared_is_touched: false,
    save_slot_is_touched: false,
    player_is_touched: false,
    secret_is_touched: false,
    /* /saves/shared.json */
    shared: {
        active_save_slot_number: int64(0),
        active_player_name: "",
        first_play: true,
    },
    /* /saves/slots/slot_[number].json */
    save_slot: {
        runs_completed: int64(0),
        player_name: "",
        current_room: "",
        current_location: "",
        current_story_node: "",
        node_line_position: int64(0),
        // TODO consider separating concept of story_nodes and scenes
        completed_story_nodes: [],
        flags: {},
    },
    /* /saves/players/player_[name].json */
    player: {
        runs_completed: int64(0),
        name: "",
        gender: {
            is_fluid: false,
            form: PlayerForm.Androgynous,
            pronouns: PlayerPronouns.ItIts,
        },
        completed_story_nodes: [],
        flags: {},
    },
    /* /game_data/internal_configuration */
    secret: {
        player_names: [],
        file_hashes: {},
        flags: {},
    },
}

Game.state.shared_is_touched = true;
Game.state.secret_is_touched = true;
save_game();