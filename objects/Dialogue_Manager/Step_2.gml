if (visible)
{
    if (current_message < 0) exit;
    
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
}