

draw_modal_background();
draw_menu(selected_menu);

function draw_modal_background() {
	draw_set_color(c_black);
	draw_set_alpha(0.7);
	draw_rectangle(0, 0, VIEW_WIDTH, VIEW_HEIGHT, false);
}


function draw_menu(_menu) {
	draw_menu_title(_menu.name);
	draw_menu_options(_menu.options);
}

function draw_menu_title(_name) {
	draw_text_center("[scale, 2]" + _name, 50);
}

function draw_text_center(_text, _height = 0) {
	var _scribble = scribble(_text);
	var _width = _scribble.get_width();
	var _center_offset = (VIEW_WIDTH - _width) / 2;
	
	_scribble.draw(_center_offset, _height);
}


function draw_menu_options(_options) {
	array_foreach(_options, draw_menu_option);
}


function draw_menu_option(_option, _index) {
	var _option_is_selected = _index == selected_index;
	var _text = _option.text;
	if (!_option_is_selected) _text = "[alpha, 0.5]" + _text;
	
	var _offset = 150 + _index * 36;
	draw_text_center(_text, _offset);
}



