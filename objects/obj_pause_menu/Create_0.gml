menu = {
	main: {
		name: "Paused",
		options: [
			{text: "Resume", action: MENU_ACTION.RESUME,},
			{text: "Log", action: MENU_ACTION.SWITCH_MENU, menu: "text_log"},
			{text: "Reset Current Save", action: MENU_ACTION.RESET_SAVE, dev_only: true,},
			{text: "Load Save", action: MENU_ACTION.SWITCH_MENU,  menu: "load_save",},
			{text: "Settings", action: MENU_ACTION.SWITCH_MENU,  menu: "game_settings"},
			{text: "Quit", action: MENU_ACTION.SAVE_AND_QUIT,},
		]
	}, 
};

enum MENU_ACTION {
	RESUME,
	SWITCH_MENU,
	RESET_SAVE,
	SAVE_AND_QUIT
}

selected_menu_key = "main";
selected_index = 0;
selected_menu = _get_current_menu(menu, selected_menu_key)

stack = [];
block_menu_actions = false;

function open() {
	switch_to_menu("main")
	stack = [];
	visible = true;
	block_menu_actions = true;
}

function close() {
	visible = false;
}

function _go_back() {
	if (block_menu_actions == true) return;
	if (array_length(stack) == 0) {
		unpause_game();
		return;
	}
	
	var _last_state = array_pop(stack);
	switch_to_menu(_last_state.menu_key, true);
	selected_index = _last_state.index;
}

function _get_current_menu(_menu, _selected_menu_key) {
	var _current_menu = _menu[$_selected_menu_key];
	if (_current_menu != undefined) return _current_menu;
	
	return {name: "Unknown", options: []};
}

function switch_to_menu(_menu_key, _skip_stack = false) {
	if (_menu_key == undefined) return;

	if (!_skip_stack)	array_push(stack, {menu_key: selected_menu_key, index: selected_index});
	selected_menu_key = _menu_key;
	selected_index = 0;
	selected_menu = _get_current_menu(menu, _menu_key)
}
function reset_current_save() {
	reset_save_state();
	obj_game.load();
	unpause_game();
}
function save_and_quit_game() {
	save_game();
    game_end();
}
