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

// Gender constants
PlayerForm = {Androgynous: "Androgynous", Feminine: "Feminine", Masculine: "Masculine"};
PlayerPronouns = {ItIts: "ItIts", TheyThem: "TheyThem", SheHer: "SheHer", HeHim: "HeHim"};
PronounMap = {
	ItIts: ["it", "it", "it's", "itself"],
	TheyThem: ["they", "them", "theirs", "themself"],
	SheHer: ["she", "her", "hers", "herself"],
	HeHim: ["he", "him", "his", "himself"],
};

// Enums
enum DialogueState {
	Text,
	Option,
	Input,
}
