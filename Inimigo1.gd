class_name Inimigo1
extends ObjetoDaPool

@onready var timer = $Timer
var speed = 200

func _process(delta):
	global_position.y += speed * delta

func ativar(a : bool, pos : Vector2):
	set_process(a)
	super.ativar(a, pos)
	if not a:
		if pool: pool.voltarAosDisponiveis(self as ObjetoDaPool)
	else:
		esperar()

func esperar():
	timer.start()
	await timer.timeout
	ativar(false, Vector2.ZERO)
	#Por didática, fizemos desse jeito
	#Mas também podemos fazer essa parte com:
	#func _ready():
	#	timer.timeout.connect(ativar.bind(false, Vector2.ZERO))
	#E só chamamos o timer.start no ativar, caso a seja positivo
