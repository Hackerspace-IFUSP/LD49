# Created by Ícaro Freire on October 3rd, 2021
# https://ivfreire.github.io/gamedev.html

extends RigidBody2D

func _ready():
	pass

func _physics_process(delta):
	
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies:
		if bodies[0].name == 'Player':
			$Collider.disabled = bodies[0].global_position.y - 32  < self.global_position.y
	
	pass
