class_name Inimigo2
extends Node2D

@onready var timer : Timer = $Timer
@onready var col : CollisionShape2D = $Colisor/CollisionShape2D2
@onready var sprite = $AnimatedSprite2D
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed = 50

func _ready() -> void:
	timer.timeout.connect(queue_free)

func _process(delta):
	global_position.y += speed * delta

func destruir():
	timer.stop()
	set_process(false)
	audio.play()
	col.set_deferred("disabled", true)
	sprite.play("Destruir")
	await sprite.animation_finished
	queue_free()

func _on_colisor_area_entered(area):
	var projetil : Projetil = area as Projetil
	if projetil != null:
		projetil.queue_free()
		destruir()
	pass # Replace with function body.
