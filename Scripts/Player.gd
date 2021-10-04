# A code by: KeichiTS & Ícaro Freire - 2021 
extends KinematicBody2D

var GRAVITY = 2000
const MAXSPEED = 200
const JUMPFORCE = 800

var can_move: bool = true

var motion = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * MAXSPEED
	motion.y += GRAVITY * delta		# Aplica gravidade
	
	if is_on_floor(): $walking.play("walking")
	else: $walking.play("jumping")
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			motion.y = -JUMPFORCE
			$coyote.start()

	motion = move_and_slide(motion, Vector2.UP)			# Função que faz o bixo se mover. 
	
	$walking.playing = motion.length() > 0
	if motion.length() > 0: $walking.flip_h = motion.x < 0
	if $walking.playing == false: $walking.frame = 0


###################################################
#     ~ It ain't much, but it's honest work ~     #
###################################################
##        #####################################   #
##          #############################         #
####            ######################            #
#####            #####           #                #
#######                                         ###
#########  #                                   ####
###########                              ## #######
#########      ###               ###       ########
#########     # ###             #####       #######
########      #####             ####         ######
########       ##                ##          ######
#######               ##                    #######
#######  ##           ####            ##      #####
####### #####        ########       #######    ####
########               #####                    ###
#########                                       ###
##########                                       ##
#########                                         #
###################################################
#               ~ KeichiTS - 2021 ~               #
###################################################
