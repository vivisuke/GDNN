class_name Layer
extends Node


const LT_LAYER = 0
const LT_AFFINE = 1
const LT_TANH = 2

var m_type = 0
var m_nInput = 0
var m_nOutput = 0
var m_outputs = []		# 出力値
var m_grad = []			# 入力誤差値

func _init(type, nOutput):
	m_type = type
	m_nOutput = nOutput	
	m_outputs.resize(nOutput)
func print():
	print("Layer:")
	print(" nInput = ", m_nInput)
	print(" nOutput = ", m_nOutput)
func init_dweights():
	pass
func forward(inputs):
	pass
func backward(grad):	# 誤差逆伝播
	pass

func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
