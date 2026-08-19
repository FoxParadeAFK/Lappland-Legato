class_name DialogueLabel extends Label

func _ready() -> void:
	Interface.trigger_dialogue.connect(read_line)
	
func read_line(_line: String) -> void:
	text = _line
