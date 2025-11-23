gx = 5;
gy = display_get_gui_height() * 0.65;
var box_width = display_get_gui_width() - gx * 2;
var box_height = display_get_gui_height() - gy - 5;

// Draw Images
if (!is_undefined(current_background_sprite)) {
	draw_sprite(current_background_sprite, 0, 0, 0);
}

struct_foreach(current_shown_sprites, function(key, value) {
	draw_sprite(value.sprite, 0, value.x_pos, value.y_pos);
});

if (!is_undefined(current_background_sprite)) {
	draw_sprite_stretched(spr_box, 0, gx, gy, box_width, box_height);
}

gx += 60;
gy += 25;

if (current_state == DialogueState.Text) {
    //Draw text
    scribble($"[{current_character.name_color}]{current_character.name}").draw(gx, gy);
    
    gy += 40;
    
    scribble(
    	$"[speed,{current_character.text_speed}][{current_character.text_color}]{
    		current_character.prefix}{current_text}{current_character.suffix}"
    )
    	.wrap(box_width - 120)
    	.draw(gx, gy, typist);
} else if (current_state == DialogueState.Option) {
    array_foreach(current_options, function(option, index) {
        scribble($"[#999999]{index + 1}.[/] {option.text}").draw(gx, gy);
        gy += 40;
    });
} else if (current_state == DialogueState.Input) {
    gy += 40;
    scribble($"{current_input_text}[c_gray]_").draw(gx, gy);
}
