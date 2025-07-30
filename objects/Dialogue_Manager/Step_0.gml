if (visible)
{
    if (current_char < string_length(current_text))
    {
        current_char += current_text_speed * (1 + real(keyboard_check(input_key)));
        text_to_draw = string_copy(current_text, 0, current_char);
    }

    
    if (ChatterboxIsStopped(chatterbox))
    {
        visible = false;
    }
    else if (ChatterboxIsWaiting(chatterbox))
    {
        //If we're in a "waiting" state then let the user press <space> to advance dialogue
        if (keyboard_check_released(input_key))
        {
            ChatterboxContinue(chatterbox);
            next();
        }
    }
    else
    {
        //If we're not waiting then we have some options!
        //Check for any keyboard input
        var option = undefined;
        if (keyboard_check_released(ord("1"))) option = 0;
        if (keyboard_check_released(ord("2"))) option = 1;
        if (keyboard_check_released(ord("3"))) option = 2;
        if (keyboard_check_released(ord("4"))) option = 3;
        
        //If we've pressed a button, select that option
        if (option != undefined) ChatterboxSelect(chatterbox, option);
    }
}