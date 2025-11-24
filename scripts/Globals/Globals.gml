// Saves constants
available_save_slots = 12;
available_player_slots = 12;
shared_path = "saves/shared.json";
secret_path = "game_data/internal.dat";
slot_path = "saves/slots/slot_";
player_path = "saves/players/player_";
json_ext = ".json";
autosave_interval = 10 * 60;
slot_base_variables = ["id", "runs_completed"];
player_base_variables = [
	"id",
	"name",
	"runs_completed",
	"gender_form",
	"gender_pronouns"
];

// Characters constant
default_character_name = "Narrator";

// Characters state
characters = {};
characters_cache = {};

// Screen values
game_width = 640;
game_height = 360;
gui_width = display_get_gui_width(); // Default 1280
gui_height = display_get_gui_height(); // Default 720
gui_scale = gui_height / game_height;

// Gender constants
player_form = {androgynous: "androgynous", feminine: "feminine", masculine: "masculine"};
player_pronouns = {
	it_its: "it_its",
	they_them: "they_them",
	she_her: "she_her",
	he_him: "he_him",
};
pronoun_map = {
	it_its: ["it", "it", "it's", "itself"],
	they_them: ["they", "them", "theirs", "themself"],
	she_her: ["she", "her", "hers", "herself"],
	he_him: ["he", "him", "his", "himself"],
};

// Enums
enum DIALOGUE_STATE {
	TEXT,
	OPTION,
	INPUT,
}
