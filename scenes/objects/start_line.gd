extends Area2D
class_name StartLine

const ARROW_SCENE = preload("res://scenes/objects/arrow.tscn")

@export var malus: int = 5

var finish: FinishArea
var arrow: Arrow
var is_in_progress: bool = false

func _ready() -> void:
	#qui prendo in la finish area che dovrà essere inserita lì in fase di creazione del livello
	finish = get_node("FinishArea")
	finish.arrived.connect(_stop_timer)
	#l'ho scritto senza usare la sntassi del $ per evidenziare
	#che non ha in automatico il finish ma lo dobbiamo aggiungere noi
	#FIXME: Meglio un export per passargli questo nodo. Potenzialmente godot permette pure di mettere i warning se manca, cosi
	#come accade con l'area2D senza Collision 

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var p = body as Player
		arrow = ARROW_SCENE.instantiate()
		p.get_node("Cat").add_child(arrow)
		if not arrow.is_node_ready():
			await arrow.ready
		arrow.enable(finish)
		finish.enable()
		$Cooldown.stop()
		$TimeToFinish.start()
		hide_start_line()

func _stop_timer() -> void:
	$TimeToFinish.stop()
	$Cooldown.start()
	arrow.queue_free.call_deferred()
	

func _on_time_to_finish_timeout() -> void:
	finish.disable()
	PointsManager.score -= malus
	$Cooldown.start()
	arrow.queue_free.call_deferred()
	disable_all()


func _on_cooldown_timeout() -> void:
	enable_all()

func enable_all() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.show()
	show()

func disable_all() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
	
func hide_start_line() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
