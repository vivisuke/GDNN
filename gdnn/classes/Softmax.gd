class_name Softmax
extends Layer

func _init():
	super(LT_TANH, 0)
func set_nInputs(nInputs):
	m_nInputs = nInputs
	m_nOutputs = nInputs
	m_outputs.resize(m_nOutputs)
	m_grad.resize(m_nInputs)
func forward(inputs):
	var mxval = inputs.max()
	var sumexp = 0.0
	for i in range(m_nInputs):
		sumexp += exp(inputs[i] - mxval)
	for o in range(m_nOutputs):
		m_outputs[o] = exp(inputs[o]) / sumexp
func backward(tchr_val):				# 注意：Softmax の場合は教師値をそのまま渡す
	for o in range(m_nOutputs):
		m_grad[o] = m_outputs[o] - tchr_val[o]

func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
