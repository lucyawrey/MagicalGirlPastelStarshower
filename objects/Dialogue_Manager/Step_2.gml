if (visible)
{
    var message = messages[current_message].message;
    
    if (current_char < string_length(message))
    {
        current_char += char_speed * (1 + real(keyboard_check(input_key)));
        message_to_draw = string_copy(message, 0, current_char);
    }
    else if (keyboard_check_pressed(input_key))
    {
        current_message++;
        current_char = 0;
        if (current_message >= array_length(messages)) {
            visible = false;
        }
    }
    
    if (ChatterboxIsStopped(chatterbox))
    {
        visible = false;
    }
    else
    {
        //Draw all content
        var _i = 0;
        repeat(ChatterboxGetContentCount(chatterbox))
        {
            var _string = ChatterboxGetContent(chatterbox, _i);
            draw_text(_x, _y, _string);
            _y += string_height(_string);
            ++_i;
        }
        
        _y += 30; //Bit of spacing...
    
        if (ChatterboxIsWaiting(chatterbox))
        {
            //If we're in a "waiting" state then prompt the user for basic input
            draw_text(_x, _y, "(Press Space)");
        }
    }
}