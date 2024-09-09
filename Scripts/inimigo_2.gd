class_name Inimigo1
extends Node2D

@onready var timer : Timer = $Timer
@onready var sprite = $AnimatedSprite2D
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var dano: Dano = $Dano
@onready var colisor: Area2D = $Colisor

@export var amplitudeMovimento : float
@export var frequenciaMovimento : float

@export var vida : int = 2

var posX : float

var speed = 50

func _ready() -> void:
	timer.timeout.connect(queue_free)

func _enter_tree() -> void:
	posX = global_position.x

func _process(delta):
	global_position.x = posX + (sin(timer.time_left * frequenciaMovimento) * amplitudeMovimento) 
	global_position.y += speed * delta

func destruir():
	colisor.queue_free()
	dano.queue_free()
	timer.stop()
	set_process(false)
	audio.play()
	sprite.play("Destruir")
	await sprite.animation_finished
	queue_free()

func _on_colisor_area_entered(area):
	var projetil : Projetil = area as Projetil
	if projetil != null:
		vida -= 1
		projetil.queue_free()
		if vida <= 0:
			destruir()
		flashHit()

func flashHit():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color.WHITE
