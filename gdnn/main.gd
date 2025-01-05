extends Node2D

var net

func _ready():
	if false:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(1)	# 1出力アフィン写像
		net.add(a)
		a.set_weights([[0.1, 0.2, 0.3],])
		net.forward([1.0, 1.0])
		net.forward_backward([1.0, 1.0], [2.0])		# 1.0 の数を数える
		net.print()
	if true:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(2)
		net.add(a)
		#a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 0.9], ])
		a.set_weights([[0.0, 1.0, -1.0], [0.5, 0.5, 0.5], ])
		const idata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]
		const tdata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]	# 恒等関数
		net.forward_backward_batch(idata, tdata)
		net.print()
	if false:
		net = Network.new(2)		# ２入力ネットワーク
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
	$BG.net = net
	$BG.queue_redraw()
	pass # Replace with function body.
func _process(delta):
	pass
