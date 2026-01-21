#macro IN_GAME_START_DATE date_create_datetime(2097, 10, 4, 0, 0, 0)

#macro MONTHS ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

enum TIME_BLOCK {
    MORNING = 0,
    AFTERNOON = 1,
    EVENING = 2,
    NIGHT = 3,
}

function get_date(){
    var _current_date = date_inc_day(IN_GAME_START_DATE, state.save.current_game_day - 1)
    return _current_date;
}

function get_date_string() {
    var _d = get_date();
    return $"{MONTHS[date_get_month(_d) - 1]} {date_get_day(_d)}, {date_get_year(_d)}";
}
