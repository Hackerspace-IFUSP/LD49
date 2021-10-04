extends Node2D

var init_pos = Vector2(-350,-100)
var can_change = true 
var distance
var bringing = false
var can_play_anim = true 
var timer = 20

func _ready():
	$HUD/Control/Bar/Timer/Timer.text = str(int($respawn_timer.time_left))
	$HUD/Control/Bar/Orbs/Orbs.text = "0x"

func _physics_process(delta):
	if bringing == true:
		returning_to_initial_position()
		
	##timer update
	$HUD/Control/Bar/Timer/Timer.text = str(int($respawn_timer.time_left))
	if $respawn_timer.time_left <=4:
		$HUD/Control/Bar/Timer/Timer.set("custom_colors/font_color","e61717")
	
	else:
		$HUD/Control/Bar/Timer/Timer.set("custom_colors/font_color","15e6a0")
	
func returning_to_initial_position():
	var player = get_node("Player")

	if can_play_anim == true:
		player.play_anim_1()
		can_play_anim = false
		
	if (player.global_position.x < -350 or player.global_position.x > -340) and (player.global_position.y < -110 or player.global_position.y > -90):
		if can_change == true:
			distance = player.global_position
			can_change = false
		player.GRAVITY = 0
		player.can_move = false
		player.motion = Vector2(0,0)
		player.set_collision_layer_bit(0, false)
		if player.global_position.x > init_pos.x + 10:
			player.global_position.x -= .01*(distance.x - init_pos.x)
		elif player.global_position.x < init_pos.x - 10:
			player.global_position.x += .01*( init_pos.x - distance.x )
		elif player.global_position.x == init_pos.x:
			player.global_position.x == init_pos.x
		
		if player.global_position.y > init_pos.y + 10 :
			player.global_position.y -= .01 * (distance.y - init_pos.y)
		elif player.global_position.y < init_pos.y - 10 :
			player.global_position.y += .01 * (init_pos.y - distance.y)
		elif player.global_position.y == init_pos.y:
			player.global_position.y == init_pos.y
		
	else: 
		player.play_anim_2()
		player.global_position = init_pos
		bringing = false
		player.GRAVITY = 2000
		player.set_collision_layer_bit(0, true)
		player.can_move = true 
		$respawn_timer.start()
		can_play_anim = true

func _on_respawn_timer_timeout():
	bringing = true 
	can_change = true
	$respawn_timer.wait_time = timer 


func _on_slow_mo_zone_body_entered(body):
	if body.name == "Player":
		body.MAXSPEED *= .5
		body.GRAVITY *= .05
		body.JUMPFORCE *= .5


func _on_slow_mo_zone_body_exited(body):
	if body.name == "Player":
		body.MAXSPEED *= 2
		body.GRAVITY *= 20
		body.JUMPFORCE *= 2


func _on_dark_room_zone_body_entered(body):
	if body.name == "Player":
		$dark_room_zone/anim_light_modulate.play("event")

func _on_dark_room_zone_body_exited(body):
	if body.name == "Player":
		$dark_room_zone/anim_light_modulate.play("event2")


#for hud
func update_hud(orbs):
	$HUD/Control/Bar/Orbs/Orbs.text = str(int(orbs))+"x"
