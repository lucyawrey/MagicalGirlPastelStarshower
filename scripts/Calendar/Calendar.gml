#macro IN_GAME_START_DATE date_create_datetime(2097, 10, 4, 0, 0, 0)

enum TIME_BLOCK {
    MORNING = 0,
    AFTERNOON = 1,
    EVENING = 2,
    NIGHT = 3,
}

function get_date(){
    var _current_date = date_inc_day(IN_GAME_START_DATE, state.save.current_day - 1)
    return _current_date;
}