state = {
    first_run: false,
    game_is_started: false,
    shared_is_touched: false,
    save_slot_is_touched: false,
    player_is_touched: false,
    secret_is_touched: false,
    /* saves/shared.json */
    shared: {
        active_save_slot_id: int64(0),
        active_player_id: int64(0),
        next_player_id: int64(1),
    },
    /* game_data/internal.dat */
    secret: {
        player_names: [],
        file_hashes: {},
        flags: {},
    },
    /* saves/slots/slot_[number].json */
    save_slot: {
        id: int64(0),
        player_id: int64(0),
        runs_completed: int64(0),
        current_room: "",
        current_location: "",
        current_story_node: "",
        current_line_position: int64(0),
        // TODO consider separating concept of story_nodes and scenes
        completed_story_nodes: [],
        flags: {},
    },
    /* saves/players/player_[name].json */
    player: {
        id: int64(0),
        name: "",
        runs_completed: int64(0),
        gender: {
            is_fluid: false,
            form: PlayerForm.Androgynous,
            pronouns: PlayerPronouns.ItIts,
        },
        completed_story_nodes: [],
        flags: {},
    },
}

instance_create_depth(0, 0, 0, Dialogue_Manager)

load_game();

touch_shared();
touch_secret();
touch_slot();
touch_player();
save_game();