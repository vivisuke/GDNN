# シーケンシャルなネットワーク
class_name Network
extends Node

var m_nInput = 0
var m_layers = []

func _init(nInput):
	m_nInput = nInput	
func print():
	print("nInput = ", m_nInput)
	#print("m_inputs = ", m_inputs)
	print("m_layers.size() = ", m_layers.size())
	for i in range(m_layers.size()):
		m_layers[i].print()
func add(layer):
	var ni = m_nInput if m_layers.is_empty() else m_layers.back().m_nOutput
	if layer.m_type == Layer.LT_AFFINE:
		layer.set_nInput(ni)
	m_layers.push_back(layer)
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
