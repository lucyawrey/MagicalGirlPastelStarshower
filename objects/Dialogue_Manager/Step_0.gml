if (visible)
{
    if (current_char < current_text_length)
    {
        text_sound_clock += 1 * current_text_speed;
        if (keyboard_check_released(input_key))
        {
            current_char = current_text_length;
            text_to_draw = current_text;
            exit;
        } else {
            current_char += current_text_speed;
            text_to_draw = string_copy(current_text, 0, current_char);
        }
        if (text_sound_clock >= 4) {
            if (string_char_at(current_text, current_char) == " ") {
                text_sound_clock -= 2;
            } else {
                audio_play_sound(click, 1, false);
                text_sound_clock = 0;
            }
        }
    } else if (text_to_draw != current_text) {
        text_to_draw = current_text;
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