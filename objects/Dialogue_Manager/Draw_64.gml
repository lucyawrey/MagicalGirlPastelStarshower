gx = 34 * global.gui_scale;
gy = global.gui_height * 0.68;
spacer = 20 * global.gui_scale;
var line_width = global.gui_width - gx;

if (current_state == DialogueState.Text) {
    //Draw text
    scribble($"[{current_character.name_color}]{current_character.name}").draw(gx, gy);
    
    gy += spacer;
    
    scribble(
    	$"[speed,{current_character.text_speed}][{current_character.text_color}]{
    		current_character.prefix}{current_text}{current_character.suffix}"
    )
    	.wrap(line_width)
    	.draw(gx, gy, typist);
} else if (current_state == DialogueState.Option) {
    array_foreach(current_options, function(option, index) {
        scribble($"[#999999]{index + 1}.[/] {option.text}").draw(gx, gy);
        gy += spacer;
    });
} else if (current_state == DialogueState.Input) {
    gy += spacer;
    scribble($"{current_input_text}[c_gray]_").draw(gx, gy);
}
