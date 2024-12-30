extends Node2D


func _ready():
	var net = Network.new(2)
	var a = AffineMap.new(2)
	net.add(a)
	a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 1.0], ])
	#net.forward([1.0, 1.0])
	net.forward_grad([1.0, 1.0], [1.0, 1.0])
	net.print()
	pass # Replace with function body.
func _process(delta):
	pass
