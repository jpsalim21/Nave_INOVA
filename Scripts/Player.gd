extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var posicao_projetil = $PosicaoProjetil
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var vida : int = 3

var projetil : PackedScene = preload("res://PackedScenes/projetil.tscn")

const SPEED = 150.0

func _physics_process(delta):
	var direction = Input.get_vector("Esquerda","Direita","Cima","Baixo")
	direction = direction.normalized()
	direction.y *= 0.6
	velocity = direction * SPEED
	animar(velocity.x)
	move_and_slide()

func _unhandled_input(event):
	if event.is_action_pressed("Atirar"):
		var objProjetil : Node2D = projetil.instantiate()
		objProjetil.global_position = posicao_projetil.global_position
		get_tree().root.add_child(objProjetil)
		audio.play()

func animar(vX : float):
	if vX:
		if vX > 0:
			sprite.play("Direita")
		else:
			sprite.play("Esquerda")
	else:
		sprite.play("default")


func _on_area_2d_area_entered(area):
	var ehDano = area as Dano
	if ehDano:
		vida -= 1
		if vida <= 0:
			get_tree().reload_current_scene()
			return
		flashSprite()

func flashSprite():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color.WHITE
