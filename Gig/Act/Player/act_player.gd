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
	next = get_next(node, connector)
	if next == null:
		return
	connector = next.partner
	play(connector.bit, is_scoring)
	tock.emit()
 
func get_next(_node: ActNode, _connector = null) -> ActConnector:
	if not _node:
		return 
	var options = _node.active_connectors.filter(func (c): return c != _connector)
	return options[0] if options.size() == 1 else null

func get_preview(depth: int, preview: Array = []) -> Array[ActConnector]:
	if depth == 0:
		return preview
	var _node: ActNode = node if preview == [] else preview[-1].bit
	var _connector: ActConnector = connector if not preview else preview[-1]
	match get_next(_node, _connector):
		null: 
			return preview
		var _next: 
			return get_preview(depth - 1, preview + [_next.partner])
