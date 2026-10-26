class_name ActState extends Object

signal new_bit(node: ActNode)
signal new_link(node: ActLink)

class NodeFields:
	var connectors: Array = []
	
	func _init(_connectors: Array) -> void:
		connectors = _connectors

class ConnectorFields:
	var node: ActNode
	var link: ActLink
	
	func _init(_node: ActNode) -> void:
		node = _node

class LinkFields:
	var left: ActConnector
	var right: ActConnector 
	var active: bool = false
	
	func _init(_left: ActConnector, _right: ActConnector) -> void:
		left = _left
		right = _right

var nodes: Dictionary[ActNode, NodeFields] = {}
var connectors: Dictionary[ActConnector, ConnectorFields] = {}
var links: Dictionary[ActLink, LinkFields] = {}

func add_bit(bit_data: Models.BitData) -> void:
	# Create element state objects
	var node = ActNode.new(bit_data, self)
	var _connectors: Array =  bit_data.connectors.map(ActConnector.new.bind(self))
	
	# Connect to graph
	nodes[node] = NodeFields.new(_connectors)
	for connector in _connectors:
		connectors[connector] = ConnectorFields.new(node)
	
	# Notifiy listeners
	new_bit.emit(node)

func link_connectors(left: ActConnector, right: ActConnector) -> void:
	# Remove existing links
	unlink(left.link)
	unlink(right.link)
	
	# Create new link
	var link = ActLink.new(self)
	links[link] = LinkFields.new(left, right)
	
	# Connect connectors to link
	connectors[left].link = link
	connectors[right].link = link
	
	left.updated.emit()
	right.updated.emit()
	
	new_link.emit(link)

func unlink(link: ActLink) -> void:
	# Check if connected
	if link == null:
		return
	# Disconnect pair and notify
	connectors[link.left].link = null
	connectors[link.right].link = null	
	link.left.updated.emit()
	link.right.updated.emit()
	
	# Disconnecr
	links.erase(link)
	link.unlinked.emit()

func toggle_link(link: ActLink) -> void:
	link.active = not link.active
	link.changed.emit()
