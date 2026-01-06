#macro PLAYER_FORM { androgynous: "androgynous", feminine: "feminine", masculine: "masculine" }
#macro PLAYER_PRONOUNS { it_its: "it_its", they_them: "they_them", she_her: "she_her", he_him: "he_him" }
#macro PRONOUN_MAP { it_its: ["it", "it", "it's", "itself"], they_them: ["they", "them", "theirs", "themself"], she_her: ["she", "her", "hers", "herself"], he_him: ["he", "him", "his", "himself"] } 
enum DIALOGUE_STATE {
	TEXT,
	OPTION,
	INPUT,
}
