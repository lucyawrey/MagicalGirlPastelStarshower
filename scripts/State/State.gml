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
		player_count: 1,
		developer_mode: false,
	},
	/* game_data/internal.dat */
	secret: {player_names: [], file_hashes: {}, data: {}},
	/* saves/slots/slot_[number].json */
	save_slot: {
		id: 0,
		player_id: -1,
		runs_completed: 0,
		current_room: "rm_scene",
		current_location: "start",
		current_node: "Start",
		in_dialogue_mode: true,
		current_node_position: 0,
		current_node_option_queue: [],
		data: {},
	},
	/* saves/players/player_[name].json */
	player: {
		id: 0,
		name: "",
		runs_completed: 0,
		gender_form: global.player_form.androgynous,
		gender_pronouns: global.player_pronouns.it_its,
		visited_nodes: {},
		data: {},
	},
};

initial_state = variable_clone(state);
