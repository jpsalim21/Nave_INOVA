extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var projetil_pool = $"../ProjetilPool"
@onready var posicao_projetil = $PosicaoProjetil
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var vida : int = 3

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
		projetil_pool.instanciar(posicao_projetil.global_position)
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
			print("Morreu")
	pass # Replace with function body.
