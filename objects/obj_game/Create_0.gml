// Configure game settings
gpu_set_tex_filter(false);

// Set instance variables
paused = false;
resumed_this_tick = false;

// Autosave alarm
alarm[0] = AUTOSAVE_INTERVAL;
// Unpause alarm
alarm[1] = 0;
// Resumed alarm
alarm[2] = 0;
// Load game alarm
alarm[3] = 30;

// Method definitions
function reset_autosave_timer() {
	alarm[0] = AUTOSAVE_INTERVAL;
}

function pause(time = -1, mode = "second") {
	var _factor = mode == "step" ? 1 : 60;
	paused = true;
	if (time > 0) {
		unpause(time * _factor);
	}
}

function unpause(_step_delay = 1) {
	alarm[1] = _step_delay;
}

function indefinitely_paused() {
	return paused && alarm[1] < 1;
}

function set_resumed_clock() {
	alarm[2] = 2;
}

function load(_step_delay = 1) {
	alarm[3] = _step_delay;
}

// Create Dialogue Manager Object
instance_create_depth(0, 0, 0, obj_dialogue);
instance_create_depth(0, 0, 1, obj_pause_menu);

// Create particle system
void_dust = part_system_create(ps_void_dust);
part_system_depth(void_dust, 1);

// Initial save file load.
load_game();

if (debug_mode) {
	state.shared.developer_mode = true;
	touch_shared();
	save_game();
	debug_run_all_tests();
}
