extends Node2D

func _ready():
	$dialogue.typewrite("Wherever you're from, it isn't America!");

func set_to(str):
	$dialogue.text = str
