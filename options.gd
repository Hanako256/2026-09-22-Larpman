extends Node2D
var num = 0
var textnode
var prior_text

func _ready():
	textnode = $text

func set_to(sbr: String):
	$text.typewrite(sbr)

func set_prior(sbr):
	prior_text = sbr

func set_color():
	$text.parse_bbcode("[color=green]" + prior_text + "[/color]")
	$text.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

func revert_color():
	$text.parse_bbcode("[color=white]" + prior_text + "[/color]")
	$text.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
