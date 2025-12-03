// Configure game settings
gpu_set_tex_filter(false);

// Set instance variables
paused = false;
resumedThisTick = false;

// Set autosave alarm
alarm[0] = global.autosave_interval;

// Set game pause function alarms
alarm[1] = 0;
alarm[2] = 0;

// Method definitions
function pause(time_in_seconds = -1) {
	paused = true;
	if (time_in_seconds > 0) {
		alarm[1] = time_in_seconds * 60;
	}
}

function unpause() {
	alarm[1] = 1;
}

// Create Dialogue Manager Object
instance_create_depth(0, 0, 0, obj_dialogue);

// Initial game load.
load_game();

// Set game loading alarm
alarm[3] = 30;

if (debug_mode) {
	debug_create();
}
