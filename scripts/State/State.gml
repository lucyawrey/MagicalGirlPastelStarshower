state_ = {
	save_is_touched: false,
	shared_is_touched: false,
	secret_is_touched: false,
	/* game_data/save_[number].json */
	save: {
		id: 0,
		name: "",
		runs_completed: 0,
		current_room: "rm_scene",
		current_location: "start",
		current_node: "Start",
		in_dialogue_mode: true,
		current_node_position: 0,
		current_node_option_queue: [],
		visited_nodes: {},
		gender_form: global.player_form.androgynous,
		gender_pronouns: global.player_pronouns.it_its,
		data: {},
	},
	/* game_data/save_shared.json */
	shared: {active_save_id: 0, developer_mode: false},
	/* game_data/internal.dat */
	secret: {save_file_hashes: {}, data: {}},
};
#macro state global.state_

// Saves constants
save_slot_count = 12;
save_path = "game_data/save_";
shared_path = "game_data/save_shared.json";
secret_path = "game_data/internal.dat";
json_ext = ".json";
autosave_interval = 5 * 60;
slot_base_variables = ["id", "name", "runs_completed", "gender_form", "gender_pronouns"];

initial_state_ = variable_clone(state);
#macro initial_state global.initial_state_
