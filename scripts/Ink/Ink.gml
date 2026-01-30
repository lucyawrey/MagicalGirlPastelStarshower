#macro INK_STORY_DATAFILE_PATH $"story.json"
#macro INK_STORY_MOD_PATH $"mods/base_game_story.json"
#macro INK_STORY_FULL_PATH $"{game_save_id}/mods/base_game_story.json"

function ink_setup(){
    copy_datafile_to_save(INK_STORY_DATAFILE_PATH, INK_STORY_MOD_PATH)
    ink_load(INK_STORY_FULL_PATH)
}

function copy_datafile_to_save(_source_filename, _dest_filename) {
    var _file_buffer = buffer_load(_source_filename);
	buffer_save(_file_buffer, _dest_filename);
    buffer_delete(_file_buffer);
}
