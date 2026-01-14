state_ = {
	/* game_data/save_[number].json */
	save: {
		id: 0,
		name: "",
		runs_completed: 0,
		current_location: "start",
		current_node: "Start",
		current_node_position: 0,
		visited_nodes: {},
		gender_form: PLAYER_FORM.androgynous,
		gender_pronouns: PLAYER_PRONOUNS.it_its,
		selected_options: {none: 0},
		data: {},
	},
	/* game_data/save_shared.json */
	shared: {active_save_id: 0, developer_mode: false},
	/* game_data/internal.dat */
	secret: {save_file_hashes: {}, data: {}},
	/* Touched trackers */
	save_is_touched: false,
	shared_is_touched: false,
	secret_is_touched: false,
	/* Non-saved global state */
	typist_sound_clock: 0,
	characters: {},
	characters_cache: {},
};
#macro state global.state_
#macro SAVE_BASE_VARIABLES ["id", "name", "runs_completed", "gender_form", "gender_pronouns"]

initial_state_ = variable_clone(state);
#macro INITIAL_STATE global.initial_state_
