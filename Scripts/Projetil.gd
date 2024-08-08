class_name Projetil
extends ObjetoDaPool

@onready var colisao = $CollisionShape2D
@onready var timer : Timer = $Timer

var speed = 300

func _process(delta):
	global_position.y -= speed * delta
	#timer.timeout.connect(ativar.bind(false, Vector2.ZERO))

func ativar(a : bool, pos : Vector2):
	colisao.disabled = !a
	set_process(a)
	super.ativar(a, pos)
	if a:
		esperar()
	elif pool:
		pool.voltarAosDisponiveis(self as ObjetoDaPool)

func esperar():
	timer.start()
	await timer.timeout
	ativar(false, Vector2.ZERO)
	#Por didática, fizemos desse jeito
	#Mas também podemos fazer essa parte com:
	#func _ready():
	#	timer.timeout.connect(ativar.bind(false, Vector2.ZERO))
	#E só chamamos o timer.start no ativar, caso a seja positivo
