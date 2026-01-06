// Configure game settings
gpu_set_tex_filter(false);

// Set instance variables
paused = false;
resumedThisTick = false;

// Set autosave alarm
alarm[0] = AUTOSAVE_INTERVAL;

// Set game pause alarm
alarm[1] = 0;
// set game resumed this tick alarm
alarm[2] = 0;

// Method definitions
function pause(time = -1, mode = "second") {
	var _factor = mode == "step" ? 1 : 60;
	paused = true;
	if (time > 0) {
		alarm[1] = time * _factor;
	}
}

function unpause() {
	alarm[1] = 2;
}

// Create Dialogue Manager Object
instance_create_depth(0, 0, 0, obj_dialogue);

// Create particle system
void_dust = part_system_create(ps_void_dust);
part_system_depth(void_dust, 1);

// Initial game load.
load_game();

// Set game loading alarm
alarm[3] = 30;

if (debug_mode) {
	state.shared.developer_mode = true;
	touch_shared();
	save_game();
	debug_run_all_tests();
}
