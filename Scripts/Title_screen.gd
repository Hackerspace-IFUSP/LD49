extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("event")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Plot_screen.tscn")
