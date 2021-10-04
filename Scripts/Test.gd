extends Node2D

var init_pos = Vector2(-350,-100)
var can_change = true 
var distance
var bringing = false


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if bringing == true:
		returning_to_initial_position()
	
func returning_to_initial_position():
	var player = get_node("Player")
	if (player.global_position.x < -350 or player.global_position.x > -340) and (player.global_position.y < -100 or player.global_position.y > -90):
		if can_change == true:
			distance = player.global_position
			can_change = false
		player.GRAVITY = 0
		player.can_move = false
		player.set_collision_mask_bit(0, false)
		if player.global_position.x > init_pos.x:
			player.global_position.x -= .01*(distance.x - init_pos.x)
		elif player.global_position.x < init_pos.x:
			player.global_position.x += .01*( init_pos.x - distance.x )
		elif player.global_position.x == init_pos.x:
			player.global_position.x == init_pos.x
		
		if player.global_position.y > init_pos.y:
			player.global_position.y -= .01 * (distance.y - init_pos.y)
		elif player.global_position.y < init_pos.y:
			player.global_position.y += .01 * (init_pos.y - distance.y)
		elif player.global_position.y == init_pos.y:
			player.global_position.y == init_pos.y
		
		print(player.global_position)
	else: 
		bringing = false
		player.GRAVITY = 2000
		player.set_collision_mask_bit(0, true)
		player.can_move = true 
		$respawn_timer.start()

func _on_respawn_timer_timeout():
	bringing = true 
	can_change = true
