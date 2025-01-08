class_name AfTanh
extends Layer


func _init():
	super(LT_TANH, 0)
	#m_nInputs = nOutputs
	#m_grad.resize(m_nInputs)
func set_nInputs(nInputs):
	m_nInputs = nInputs
	m_nOutputs = nInputs
	m_outputs.resize(m_nOutputs)
	m_grad.resize(m_nInputs)
func forward(inputs):
	for o in range(m_nOutputs):
		m_outputs[o] = tanh(inputs[o])
func backward(grad):
	for o in range(m_nOutputs):
		m_grad[o] = (1.0 - m_outputs[o] * m_outputs[o]) * grad[o]
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
