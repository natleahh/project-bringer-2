class_name ActPlayer extends Node

signal tock

@export var state: ActState
@export var play_display: Texture2D:
	get: return null if node == null else node.data.texture

var node: ActNode
var connector: ActConnector
var next: ActConnector

func play(_node: ActNode, is_scoring: bool) -> void:
	if is_scoring:
		return
	node = _node
	#timer.start()

func play_next(is_scoring: bool) -> void:
	if is_scoring:
		return
	next = get_next()
	if next == null:
		return
	connector = next.partner
	play(connector.bit, is_scoring)
	tock.emit()
 
func get_next() -> ActConnector:
	if not node:
		return 
	var options = node.active_connectors.filter(func (c): return c != connector)
	return options[0] if options.size() == 1 else null
