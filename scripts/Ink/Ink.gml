#macro INK_STORY_DATAFILE_PATH "story.json"
#macro INK_STORY_MOD_PATH "mods/base_game_story.json"
#macro INK_STORY_FULL_PATH $"{game_save_id}/mods/base_game_story.json"

function story_setup() {
    copy_datafile_to_save(INK_STORY_DATAFILE_PATH, INK_STORY_MOD_PATH)
    ink_load(INK_STORY_FULL_PATH)
    
    ink_bind_external("background", background);
	ink_bind_external("show", show);
	ink_bind_external("hide", hide);
	ink_bind_external("play", play);
	ink_bind_external("pause", pause);
	ink_bind_external("delay", delay);
	ink_bind_external("auto", auto);
	ink_bind_external("block", block);
	ink_bind_external("event", event);
    // End game with ink -> END
    ink_bind_external("end_game", end_game);
}

function story_can_continue() {
    return bool(ink_can_continue());
}

function story_get_tags() {
    var _tags = [];
    var _tag_count = ink_tag_count();
    for (var _i = 0; _i < _tag_count; _i++) {
        var _tag = ink_get_tag(_i);
        array_push(_tags, _tag);
    }
    return _tags;
}

function story_continue() {
    return ink_continue();
}

function story_get_choices() {
    var _choices = [];
    var _coice_count = ink_choice_count();
    for (var _i = 0; _i < _coice_count; _i++) {
        var _choice = ink_choice(_i);
        array_push(_choices, _choice);
    }
    return _choices;
}

function story_choose(_choice_number) {
    ink_choose_choice(_choice_number);
}
