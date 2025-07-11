function create_dialogue(_messages){
    if (instance_exists(Dialogue)) return;
    
    var _inst = instance_create_depth(0, 0, 0, Dialogue)
    _inst.messages = _messages;
    _inst.current_message = 0;
}

char_colors = {
    Cross: c_yellow,
    Singh: c_aqua,
    cRosS: c_red,
}

welcome_dialogue = [
  {
    name: "Cross",
    msg: "Hey. Welcome to hell.",
  },
  {
    name: "Singh",
    msg: "Well that's not good.",
  }
];

demon_dialogue = [
  {
    name: "cRosS",
    msg: "yOu ShOulD nOt HavE cOme HeRE"
  },
  {
    name: "Singh",
    msg: "I didn't have a choice!"
  }
];