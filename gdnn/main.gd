extends Node2D


func _ready():
	var net = Network.new(2)
	var a = AffineMap.new(2)
	net.add(a)
	#a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 1.0], ])
	a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 0.9], ])
	#net.forward([1.0, 1.0])
	#net.forward_grad([1.0, 1.0], [1.0, 1.0])
	const idata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]
	const tdata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]
	net.forward_grad_batch(idata, tdata)
	net.print()
	pass # Replace with function body.
func _process(delta):
	pass
