
draw_modal_background();

function draw_modal_background() {
	draw_set_color(c_black);
	draw_set_alpha(0.7);
	draw_rectangle(0, 0, VIEW_WIDTH, VIEW_HEIGHT, false);
}