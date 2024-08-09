class_name Inimigo1
extends ObjetoDaPool

@onready var timer : Timer = $Timer
@onready var col : CollisionShape2D = $Colisor/CollisionShape2D2
@onready var sprite = $AnimatedSprite2D
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed = 50

func _ready():
	super._ready()

func _process(delta):
	global_position.y += speed * delta

func ativar(a : bool, pos : Vector2):
	set_process(a)
	col.disabled = !a
	super.ativar(a, pos)
	timer.stop() #ALERT MEGA IMPORTANTE. Caso não exista, podemos ter muitos problemas
	if not a:
		sprite.play("default")
		if pool: 
			pool.voltarAosDisponiveis(self as ObjetoDaPool)
	else:
		esperar()

func esperar():
	timer.stop()
	timer.start()
	await timer.timeout
	ativar(false, Vector2(200, 200))
	
	#Por didática, fizemos desse jeito
	#Mas também podemos fazer essa parte com:
	#func _ready():
	#	timer.timeout.connect(ativar.bind(false, Vector2.ZERO))
	#E só chamamos o timer.start no ativar, caso a seja positivo

func destruir():
	set_process(false)
	audio.play()
	col.set_deferred("disabled", true)
	sprite.play("Destruir")
	await sprite.animation_finished
	ativar(false, Vector2(200,200))

func _on_colisor_area_entered(area):
	if not isActive: return  #ALERT: Mega importante também. 
	var projetil = area as Projetil
	if projetil != null:
		projetil.ativar(false, Vector2(200,200))
		destruir()
	pass # Replace with function body.
