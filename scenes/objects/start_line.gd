extends Area2D
class_name StartLine

@export var malus: int = 5
@export var arrow_scene: PackedScene

var finish: FinishArea
var arrow: Arrow

func _ready() -> void:
	#qui prendo in la finish area che dovrà essere inserita lì in fase di creazione del livello
	finish = get_node("FinishArea") 
	#l'ho scritto senza usare la sntassi del $ per evidenziare
	#che non ha in automatico il finish ma lo dobbiamo aggiungere noi

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var p = body as Player
		arrow = arrow_scene.instantiate()
		p.get_node("Cat").add_child(arrow)
		arrow.enable(finish)
		finish.enable()
		finish.arrived.connect(_stop_timer)
		$TimeToFinish.start()

func _stop_timer() -> void:
	$TimeToFinish.stop()
	$Cooldown.start()
	arrow.disable()
	disable()

func _on_time_to_finish_timeout() -> void:
	finish.disable()
	PointsManager.score -= malus
	$Cooldown.start()
	arrow.disable()
	disable()

func _on_cooldown_timeout() -> void:
	enable()

func enable() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	show()

func disable() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	call_deferred("queue_free")
