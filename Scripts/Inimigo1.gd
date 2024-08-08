class_name Inimigo1
extends ObjetoDaPool

@onready var timer : Timer = $Timer
var speed = 50

func _process(delta):
	global_position.y += speed * delta

func ativar(a : bool, pos : Vector2):
	set_process(a)
	super.ativar(a, pos)
	timer.stop()
	if not a:
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

func _on_colisor_area_entered(area):
	if not isActive: return 
	var projetil = area as Projetil
	if projetil != null:
		print("Sai pelo projetil")
		ativar(false, Vector2.ZERO)
	pass # Replace with function body.
