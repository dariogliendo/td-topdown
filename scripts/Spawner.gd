extends Node

const SLIME = preload("res://enemy_scenes/slime.tscn")

var active_enemies : Array[Enemy]
var current_wave : Node;
var spawn_point : Vector2;
var spawn_target : Node2D
var spawn_counter : int = 0;

signal enemy_spawned(enemy : Enemy)

func _on_wave_1_wave_started(wave):
	$SpawnTimer.start()
	current_wave = wave
	$SpawnTimer.wait_time = current_wave.frequency


func _on_spawn_timer_timeout():
	if spawn_counter < current_wave.amount:
		var to_spawn = current_wave.enemy.instantiate();
		to_spawn.position = spawn_point
		to_spawn.navigation_target = spawn_target
		add_child(to_spawn)
		spawn_counter += 1
		enemy_spawned.emit(to_spawn)
	else:
		$SpawnTimer.stop()
		spawn_counter = 0;

func _on_target_child_entered_tree(node):
	spawn_target = node
