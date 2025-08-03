state = {
    first_run: false,
    game_is_started: false,
    shared_is_touched: false,
    save_slot_is_touched: false,
    player_is_touched: false,
    secret_is_touched: false,
    /* saves/shared.json */
    shared: {
        active_save_slot_id: 0,
        active_player_id: 0,
        next_player_id: 1,
    },
    /* game_data/internal.dat */
    secret: {
        player_names: [],
        file_hashes: {},
        flags: {},
    },
    /* saves/slots/slot_[number].json */
    save_slot: {
        id: 0,
        player_id: 0,
        runs_completed: 0,
        current_room: "Scene",
        current_location: "location_dream",
        current_story_node: "Start",
        current_line_position: 0,
        // TODO consider separating concept of story_nodes and scenes
        completed_story_nodes: [],
        flags: {},
    },
    /* saves/players/player_[name].json */
    player: {
        id: 0,
        name: "",
        runs_completed: 0,
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

//load_game();

touch_shared();
touch_secret();
touch_slot();
touch_player();
save_game();

show_dialogue(state.save_slot.current_story_node);