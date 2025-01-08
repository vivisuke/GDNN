extends Node2D

var net
const idata = [[1.0, 1.0], [1.0, -1.0], [-1.0, 1.0], [-1.0, -1.0], ]
#const tdata = [[1.0], [-1.0], [-1.0], [-1.0],]	# AND
#const tdata = [[1.0], [1.0], [1.0], [-1.0],]	# OR
const tdata = [[-1.0], [1.0], [1.0], [-1.0],]	# XOR
#const tdata = [[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], [-1.0, 1.0],]	# 恒等関数

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
		net.forward_backward_batch(idata, tdata)
	if false:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(1)	# １出力アフィン写像
		net.add(a)
		net.add(AfTanh.new())		# 活性化関数：tanh()
		net.forward_backward_batch(idata, tdata)
	if true:
		net = Network.new(2)		# ２入力ネットワーク
		net.add(AffineMap.new(2))	# ２出力アフィン写像
		net.add(AfTanh.new())		# 活性化関数：tanh()
		net.add(AffineMap.new(1))	# １出力アフィン写像
		net.add(AfTanh.new())		# 活性化関数：tanh()
		net.forward_backward_batch(idata, tdata)
	if false:
		net = Network.new(2)		# ２入力ネットワーク
		var a = AffineMap.new(2)
		net.add(a)
		#a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 1.0], ])
		a.set_weights([[0.0, 1.0, 0.0], [0.0, 0.0, 0.9], ])
		#net.forward([1.0, 1.0])
		const idata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]
		const tdata = [[1.0, 1.0],[1.0, -1.0],[-1.0, -1.0],[-1.0, 1.0],]
		net.forward_backward(idata, tdata)
		net.print()
	$BG.net = net
	update_view()
	pass # Replace with function body.
func update_view():
	$BG.queue_redraw()
	$LossLabel.text = "Loss = %.5f"%net.m_loss
	var ly = net.m_layers[0]
	var txt = ly.weights_text()
	$WeightsLabel.text = "[b, weights] = " + txt
	txt = ly.dweights_text()
	$DWeightsLabel.text = "∂/∂[b, weights] = " + txt
	#$GraphRect.vv_weight = [[ly.m_bias[0], ly.m_weights[0][0], ly.m_weights[0][1], ]]
	$GraphRect.vv_weight = ly.get_weights()		# 重みベクター（含バイアス）取得
	$GraphRect.queue_redraw()
func _on_texture_button_pressed():
	net.update_weights(0.1)
	net.forward_backward_batch(idata, tdata)
	#net.print()
	update_view()
	pass # Replace with function body.
func _process(delta):
	if $HBC/TrainButton.is_pressed():
		#print("Pressed.")
		_on_texture_button_pressed()
		pass
	pass
