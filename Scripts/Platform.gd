# Created by Ícaro Freire on October 3rd, 2021
# https://ivfreire.github.io/gamedev.html

extends RigidBody2D

export var unstable: bool = false

func _ready():
	pass

func _physics_process(delta):
	
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies:
		if bodies[0].name == 'Player':
			$Collider.disabled = bodies[0].global_position.y > self.global_position.y - 16
			if self.unstable:
				self.collapse()
		else:
			$Collider.disabled = true
	
	pass

func collapse():
	pass
