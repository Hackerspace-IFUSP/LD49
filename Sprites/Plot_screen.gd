extends Node

func _ready():
	$anim.play("event")
	yield($anim,"animation_finished")
	get_tree().change_scene("res://Maps/Test.tscn")
