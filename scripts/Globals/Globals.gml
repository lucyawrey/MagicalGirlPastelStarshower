// Saves constants
available_save_slots = 12;
available_player_slots = 12;
shared_path = "game_data/shared_save.json";
secret_path = "game_data/internal.dat";
slot_path = "game_data/slots/slot_";
player_path = "game_data/players/player_";
json_ext = ".json";
autosave_interval = 5 * 60;
slot_base_variables = ["id", "runs_completed"];
player_base_variables = [
	"id",
	"name",
	"runs_completed",
	"gender_form",
	"gender_pronouns"
];

// Characters constant
base_character_name = "Base";
default_character_name = "Narrator";

// Characters state
characters = {};
characters_cache = {};

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
