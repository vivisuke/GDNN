# シーケンシャルなネットワーク
class_name Network
extends Node

var m_loss				# 平均自乗誤差
var m_nInputs = 0
var m_grad = []
var m_layers = []

func _init(nInputs):
	m_nInputs = nInputs	
func init_weights():
	for i in range(m_layers.size()):
		if m_layers[i].m_type == Layer.LT_AFFINE:
			m_layers[i].init_weights()
func print():
	print("nInputs = ", m_nInputs)
	#print("m_inputs = ", m_inputs)
	print("m_layers.size() = ", m_layers.size())
	for i in range(m_layers.size()):
		m_layers[i].print()
	print("m_grad = ", m_grad)
func add(layer):
	var ni = m_nInputs if m_layers.is_empty() else m_layers.back().m_nOutputs
	if layer.m_type == Layer.LT_AFFINE || layer.m_type == Layer.LT_TANH:
		layer.set_nInputs(ni)
	m_layers.push_back(layer)
func forward(inputs):
	var ptr = inputs
	for i in range(m_layers.size()):
		m_layers[i].forward(ptr)
		ptr = m_layers[i].m_outputs
func backward(grad):
	var ptr = grad
	for i in range(m_layers.size()-1, -1, -1):
		m_layers[i].backward(ptr)
		ptr = m_layers[i].m_grad
#func forward_grad(inputs, tcr_var):		# １つのデータで、loss, ∂L/∂y 計算
#	m_loss = 0.0
#	var back = m_layers.back()
#	m_grad.resize(back.m_nOutputs)
#	#m_grad.fill(0.0)
#	forward(inputs)
#	for o in range(m_grad.size()):
#		var d = back.m_outputs[o] - tcr_var[o]
#		m_grad[o] = d
#		m_loss += d * d / 2.0
#	#m_loss /= m_grad.size()
#	print("loss = ", m_loss)
func init_dweights():
	for i in range(m_layers.size()):
		m_layers[i].init_dweights()
func forward_backward(inputs, tcr_var):		# １つのデータで、loss, ∂L/∂W 計算
	forward(inputs)
	m_loss = 0.0
	var back = m_layers.back()
	m_grad.resize(back.m_nOutputs)
	for o in range(m_grad.size()):
		var d = back.m_outputs[o] - tcr_var[o]
		m_grad[o] = d
		m_loss += d * d / 2.0
	#m_loss /= m_grad.size()
	print("loss = ", m_loss)
	init_dweights()			# dbias, dweights を 0.0 二初期化
	backward(m_grad)
	pass
func forward_backward_batch(inputs, tcr_var):	# 複数データで、loss, ∂L/∂W 計算
	m_loss = 0.0
	var back = m_layers.back()
	m_grad.resize(back.m_nOutputs)
	init_dweights()			# dbias, dweights を 0.0 二初期化
	for ix in range(inputs.size()):
		forward(inputs[ix])
		for o in range(m_grad.size()):
			var d = back.m_outputs[o] - tcr_var[ix][o]
			m_grad[o] = d
			m_loss += d * d / 2.0
		backward(m_grad)
	#m_loss /= m_grad.size() * inputs.size()
	print("loss = ", m_loss)
#func forward_grad_batch(inputs, tcr_var):		# 複数データで、loss, ∂L/∂y 計算
#	m_loss = 0.0
#	var back = m_layers.back()
#	m_grad.resize(back.m_nOutputs)
#	m_grad.fill(0.0)
#	for ix in range(inputs.size()):
#		forward(inputs[ix])
#		print("back.m_outputs = ", back.m_outputs)
#		for o in range(m_grad.size()):
#			var d = back.m_outputs[o] - tcr_var[ix][o]
#			m_grad[o] += d
#			m_loss += d * d / 2.0
#	for o in range(m_grad.size()):
#		m_grad[o] /= inputs.size()
#	#m_loss /= m_grad.size() * inputs.size()
#	print("loss = ", m_loss)
#	print("m_grad = ", m_grad)
#	print("")
func update_weights(alpha):
	for i in range(m_layers.size()):
		m_layers[i].update_weights(alpha)
	pass
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
