state = {
	first_run: false,
	game_is_started: false,
	shared_is_touched: false,
	save_slot_is_touched: false,
	player_is_touched: false,
	secret_is_touched: false,
	/* saves/shared.json */
	shared: {active_save_slot_id: 0, active_player_id: 0, player_count: 1},
	/* game_data/internal.dat */
	secret: {player_names: [], file_hashes: {}, data: {}},
	/* saves/slots/slot_[number].json */
	save_slot: {
		id: 0,
		player_id: -1,
		runs_completed: 0,
		current_room: "Scene",
		current_location: "dream",
		current_node: "Start",
		current_node_position: 0,
		completed_nodes: [],
		data: {},
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
		completed_nodes: [],
		data: {},
	},
};
initial_state = variable_clone(state);
alarm[0] = global.autosave_interval;

// Create Dialogue Manager
instance_create_depth(0, 0, 0, Dialogue_Manager);
// Initial game load.
load_game();
// Open dialogue screen to current saved location.
show_dialogue(state.save_slot.current_node, state.save_slot.current_node_position);
