extends Node2D

var net
const idata = [[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], [-1.0, 1.0],]
const tdata = [[1.0], [-1.0], [-1.0], [-1.0],]	# AND

func _ready():
	if false:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(1)	# １出力アフィン写像
		net.add(a)
		a.set_weights([[0.1, 0.2, 0.3],])
		net.forward([1.0, 1.0])
		net.forward_backward([1.0, 1.0], [2.0])		# 1.0 の数を数える
		net.print()
	if false:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(2)	# ２出力アフィン写像
		net.add(a)
		#a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 0.9], ])
		a.set_weights([[0.0, 1.0, -1.0], [0.5, 0.5, 0.5], ])
		const idata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]
		const tdata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]	# 恒等関数
		net.forward_backward_batch(idata, tdata)
		net.print()
	if true:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(1)	# １出力アフィン写像
		net.add(a)
		a.set_weights([[-0.2, 1.0, 1.0], ])
		net.add(AfTanh.new(1))		# 活性化関数：tanh()
		net.forward_backward_batch(idata, tdata)
		net.print()
		#net.update_weights(0.1)
		#net.forward_backward_batch(idata, tdata)
		#net.print()
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
	update_view()
	pass # Replace with function body.
func update_view():
	$BG.queue_redraw()
	var ly = net.m_layers[0]
	var txt = ly.weights_text()
	$WeightsLabel.text = "[b, weights] = " + txt
	txt = ly.dweights_text()
	$DWeightsLabel.text = "∂/∂[b, weights] = " + txt
	$GraphRect.vv_weight = [[ly.m_bias[0], ly.m_weights[0][0], ly.m_weights[0][1], ]]
	$GraphRect.queue_redraw()
func _on_texture_button_pressed():
	net.update_weights(0.1)
	net.forward_grad_batch(idata, tdata)
	net.print()
	update_view()
	pass # Replace with function body.
func _process(delta):
	pass
