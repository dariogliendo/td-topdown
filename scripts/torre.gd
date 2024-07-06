extends CharacterBody2D
var estados = {
	"construyendo": {
		"construir": "listo"
	},
	"listo": {
		"atacar": "atacando",
	},
	"atacando": {
		"no_atacar": "listo"
	}
}

func iniciar():
	for sprite in $Modelo.get_children():
		sprite.modulate = "#2effff"
func construir():
	pass
func atacar():
	pass

var func_estados = {
	"construyendo": iniciar,
	"atacando": {
		"no_atacar": "a"
	},
	"listo": {
		"atacar": atacar
	}
}

func _ready():
	$Torre.play("default")
	$Arquero.play("default")
	iniciar()

func _process(delta):
	pass
