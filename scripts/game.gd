extends Node2D
class_name GameGlobals;

var player_hp = 50;
var spawn_point : Vector2
var active_enemies : Array[Enemy] = []
var wave_running : bool = false;

func _ready():
	$Wave1.start()

func _on_target_body_entered(body):
	player_hp -= 1;
	active_enemies.erase(body)
	body.queue_free()

func _process(_delta):
	$HUD/HPCounter.text = str(player_hp)
	if wave_running and len(active_enemies) <= 0:
		$Wave1.end()
		wave_running = false
	


func _on_spawn_position_ready():
	$EnemySpawning.spawn_point = $SpawnPosition.global_position


func _on_enemy_spawning_enemy_spawned(enemy):
	active_enemies.append(enemy)
	if not wave_running:
		wave_running = true;
