extends CharacterBody2D
class_name Enemy

@export var speed : int = 300;
@export var damage : int = 1;
@export var hp : int = 15;
var acceleration = 7
var navigation_agent : NavigationAgent2D;
var navigation_target : Node2D


func _physics_process(delta):
	var direction = Vector2.ZERO
	
	direction = navigation_agent.get_next_path_position() - global_position;
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	navigation_agent.target_position = navigation_target.global_position
	
	move_and_slide()
