state_ = {
	shared_is_touched: false,
	save_slot_is_touched: false,
	secret_is_touched: false,
	/* saves/shared.json */
	shared: {active_save_slot_id: 0},
	/* game_data/internal.dat */
	secret: {save_file_hashes: {}, data: {}},
	/* saves/slots/slot_[number].json */
	save_slot: {
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
};
#macro state global.state_

// Saves constants
available_save_slots = 12;
available_player_slots = 12;
shared_path = "game_data/shared_save.json";
secret_path = "game_data/internal.dat";
slot_path = "game_data/slots/slot_";
player_path = "game_data/players/player_";
json_ext = ".json";
autosave_interval = 5 * 60;
slot_base_variables = ["id", "name", "runs_completed", "gender_form", "gender_pronouns"];

initial_state_ = variable_clone(state);
#macro initial_state global.initial_state_
