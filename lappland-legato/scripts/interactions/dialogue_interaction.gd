class_name DialogueInteraction extends Interaction

@export var lines: Array[String]
var lines_length: int:
	get: return len(lines)
var lines_counter: int:
	get: return min(lines_counter, lines_length)

func trigger() -> void:
	if lines_counter >= lines_length:
		Interface.trigger_dialogue.emit(" ")
		has_interacted.emit()
	else:
		Interface.trigger_dialogue.emit(lines[lines_counter])
		lines_counter += 1
