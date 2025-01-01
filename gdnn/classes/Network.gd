# シーケンシャルなネットワーク
class_name Network
extends Node

var m_nInput = 0
var m_grad = []
var m_layers = []

func _init(nInput):
	m_nInput = nInput	
func print():
	print("nInput = ", m_nInput)
	#print("m_inputs = ", m_inputs)
	print("m_layers.size() = ", m_layers.size())
	for i in range(m_layers.size()):
		m_layers[i].print()
	print("m_grad = ", m_grad)
func add(layer):
	var ni = m_nInput if m_layers.is_empty() else m_layers.back().m_nOutput
	if layer.m_type == Layer.LT_AFFINE:
		layer.set_nInput(ni)
	m_layers.push_back(layer)
func forward(inputs):
	var ptr = inputs
	for i in range(m_layers.size()):
		m_layers[i].forward(ptr)
		ptr = m_layers[i].m_outputs
func forward_grad(inputs, tcr_var):		# １つのデータで、loss, ∂L/∂y 計算
	var loss = 0.0
	var back = m_layers.back()
	m_grad.resize(back.m_nOutput)
	#m_grad.fill(0.0)
	forward(inputs)
	for o in range(m_grad.size()):
		var d = back.m_outputs[o] - tcr_var[o]
		m_grad[o] = d
		loss += d * d / 2.0
	loss /= m_grad.size()
	print("loss = ", loss)
func forward_backward(inputs, tcr_var):		# １つのデータで、loss, ∂L/∂W 計算
	pass
func forward_grad_batch(inputs, tcr_var):		# 複数データで、loss, ∂L/∂y 計算
	var loss = 0.0
	var back = m_layers.back()
	m_grad.resize(back.m_nOutput)
	m_grad.fill(0.0)
	for ix in range(inputs.size()):
		forward(inputs[ix])
		print("back.m_outputs = ", back.m_outputs)
		for o in range(m_grad.size()):
			var d = back.m_outputs[o] - tcr_var[ix][o]
			m_grad[o] += d
			loss += d * d / 2.0
	for o in range(m_grad.size()):
		m_grad[o] /= inputs.size()
	loss /= m_grad.size() * inputs.size()
	print("loss = ", loss)
	print("m_grad = ", m_grad)
	print("")
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
