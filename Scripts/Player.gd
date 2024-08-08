extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var projetil_pool = $"../ProjetilPool"

const SPEED = 200.0

func _physics_process(delta):
	var direction = Input.get_vector("Esquerda","Direita","Cima","Baixo")
	direction = direction.normalized()
	direction.y *= 0.6
	velocity = direction * SPEED
	
	move_and_slide()

func _unhandled_input(event):
	if event.is_action_pressed("Atirar"):
		projetil_pool.instanciar(global_position)
		pass
