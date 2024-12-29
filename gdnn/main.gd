extends Node2D


func _ready():
	var net = Network.new(2)
	net.add(AffineMap.new(2))
	net.forward([1.0, 1.0])
	net.print()
	pass # Replace with function body.
func _process(delta):
	pass
