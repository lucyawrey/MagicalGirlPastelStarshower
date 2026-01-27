if (visible == false) {
	return;
}

var _options_length = array_length(selected_menu.options);

if (InputPressed(INPUT_VERB.DOWN)) {
	if (_options_length == 0) {
		return;
	}
	selected_index = (selected_index + 1) % _options_length;
}

if (InputPressed(INPUT_VERB.UP)) {
	if (_options_length == 0) {
		return;
	}
	selected_index = selected_index - 1;
	if (selected_index < 0) {
		selected_index = _options_length - 1;
	}
}

if (InputPressed(INPUT_VERB.ACCEPT)) {
	if (array_length(selected_menu.options) == 0) {
		return;
	}
	var _option = selected_menu.options[selected_index];
	if (_option == undefined) {
		return;
	}
	switch (_option.action) {
		case MENU_ACTION.RESET_SAVE:
			reset_current_save();
			return;
		case MENU_ACTION.SWITCH_MENU:
			if (_option.menu != undefined) {
				switch_to_menu(_option.menu);
			}
			return;
		case MENU_ACTION.SAVE_AND_QUIT:
			save_and_quit_game();
			return;
		case MENU_ACTION.RESUME:
			unpause_game();
			return;
	}
}

if (InputPressed(INPUT_VERB.PAUSE)) {
	_go_back();
}
block_menu_actions = false;
