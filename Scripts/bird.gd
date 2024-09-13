extends CharacterBody2D

class_name Bird

@export var gravity = 980.7
@export var jump_force = -330
@export var rotation_speed = 2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pipe_spawner: PipeSpawner = $"../PipeSpawner"

var max_speed = 400
var is_started = false
var should_process_input = true

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			pipe_spawner.start_spawning_pipes()
			animation_player.play("flap_wings")
			is_started = true
		jump()
		
		
	if !is_started:
		return
	
	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_bird()



func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-20)

func rotate_bird():
	#Rotate downwards when falling
	if velocity.y > 0 and deg_to_rad(rotation)< 90:
		rotation += rotation_speed * deg_to_rad(1)
	#Rotate upwatrrds when rising
	elif velocity.y < 0 && deg_to_rad(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)
		
		

func kill():
	should_process_input = false
	animation_player.stop()
	velocity = Vector2.ZERO



func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	should_process_input = false
