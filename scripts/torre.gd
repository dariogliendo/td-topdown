extends CharacterBody2D
var mef = {
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

signal enemigo_en_rango()

var g_utils = game_utils.new()

func construyendo_enter():
	g_utils.property_recursive($Modelo, [{"name": "modulate", "value": "#2effff"}])
	
func construyendo_process():
	self.position = get_global_mouse_position()
	g_utils.property_recursive(self, [{"name": "position", "value": Vector2(0,0)}], true)

func construyendo_event_handler(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			ejecutar("construir")
			
func atacar():
	ejecutar("atacar")

func listo_enter():
	for sprite in $Modelo.get_children():
		sprite.play("default")
	enemigo_en_rango.connect(atacar)
	
func listo_end():
	enemigo_en_rango.disconnect(atacar)

func construyendo_end():
	g_utils.property_recursive($Modelo, [{"name": "modulate", "value": "#ffffff"}], true)
		
func atacando_process():
	pass
	
var construyendo = {"enter": construyendo_enter, "process": construyendo_process, "end": construyendo_end, "event_handler": construyendo_event_handler}
var listo = {"enter": listo_enter, "process": null, "end": listo_end, "event_handler": null}
var atacando = {"enter": null, "process": atacando_process, "end": null, "event_handler": null}

var estados = {
	"construyendo": construyendo,
	"listo": listo,
	"atacando": atacando
}

var estado : String = "construyendo"

func ejecutar(accion):
	var estado_actual = estado;
	if not mef[estado].has(accion):
		return
	var estado_siguiente = mef[estado][accion]
	var fin_actual = estados[estado_actual]["end"]
	var comienzo_nuevo = estados[estado_siguiente]["enter"]
	if fin_actual != null:
		await fin_actual.call()
	if comienzo_nuevo != null:
		await comienzo_nuevo.call()
	estado = estado_siguiente

func _ready():
	construyendo_enter()
	
func _input(event):
	var estado_actual = estados[estado]
	if estado_actual["event_handler"] != null:
		estado_actual["event_handler"].call(event)

func _process(delta):
	var estado_actual = estado
	var process_fn = estados[estado_actual]["process"]
	if process_fn != null:
		process_fn.call()


func _on_rango_body_entered(body):
	if body is Enemy:
		enemigo_en_rango.emit()
