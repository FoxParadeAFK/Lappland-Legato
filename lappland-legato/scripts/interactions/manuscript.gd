class_name Manuscript extends Resource

signal completed_manuscript

@export var manuscript: Array[Interaction]:
	get: return manuscript
	set(_manuscript):
		manuscript = _manuscript
		for _interaction in manuscript:
			_interaction.has_interacted.connect(increment_manuscript)
var manuscript_length: int:
	get: return len(manuscript)
var manuscript_counter: int:
	get: return min(manuscript_counter, manuscript_length)
	
func increment_manuscript() -> void:
	manuscript_counter += 1
	read_manuscript()
	
func read_manuscript() -> void:
	if manuscript_counter >= manuscript_length:
		completed_manuscript.emit()
	else:
		manuscript[manuscript_counter].trigger()
