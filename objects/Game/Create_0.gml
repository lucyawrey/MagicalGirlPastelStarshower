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
		current_location: "start",
		current_node: "Start",
		current_node_position: 0,
		data: {},
	},
	/* saves/players/player_[name].json */
	player: {
		id: 0,
		name: "",
		runs_completed: 0,
		gender_form: global.PlayerForm.Androgynous,
		gender_pronouns: global.PlayerPronouns.ItIts,
		visited_nodes: {},
		data: {},
	},
};
initial_state = variable_clone(state);

paused = false;
resumed = false;
// Set autosave alarm
alarm[0] = global.autosave_interval;
// Set game pause function alarms
alarm[1] = 0;
alarm[2] = 0;
// Set start game delay alarm
alarm[3] = 2;

// Method definitions
function pause(time_in_seconds = -1) {
	Game.paused = true;
	if (time_in_seconds > 0) {
		Game.alarm[1] = time_in_seconds * 60;
	}
}

function unpause() {
	alarm[1] = 1;
}

// Create Dialogue Manager Object
instance_create_depth(0, 0, 0, Dialogue_Manager);
// Initial game load.
load_game();
