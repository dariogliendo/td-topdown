extends Enemy

func _ready():
	speed = 70;
	damage = 1;
	hp = 1;
	navigation_agent = $NavigationAgent2D
	$AnimatedSprite2D.play("default")
