class_name Viewer extends Control

const BIT_UI: PackedScene = preload("res://Gig/Act/UI/Elements/bit_ui.tscn")

var ui_connectors: Dictionary[ActConnector, ConnectorUI] = {}
var ui_bits: Dictionary[ActNode, BitUI] = {}
var ui_links: Dictionary[ActLink, LinkUI] = {}

var selected: SelectionCycler

class SelectionCycler:
	var index: int = 0
	var source: Node
	var cycle: Array
	var selected: Node:
		get: return cycle[index - 1] if cycle else null
	
	func _init(cycle_getter: Callable, _source: Node) -> void:
		source = _source
		cycle = cycle_getter.call(_source)
	
	func _cycle(forward: bool) -> Node:
		if not cycle:
			return
		index += 1 if forward else -1
		index %= cycle.size()
		return selected

	func next() -> Node:
		return _cycle(true)

	func previous() -> Node:
		return _cycle(false)
			

@export var act: ActState
@export var player: ActPlayer

var playing_node: ActNode:
	get: return player.connector.bit if player.connector else null
var blocked_links: Array[ActLink]:
	get: return player.options.map().bit if player.connector else null

func _ready() -> void:
	act.new_bit.connect(_on_new_bit)
	act.new_link.connect(_on_new_link)
	
	for _i in 10:
		_on_button_press()

func _on_button_press():
	act.add_bit(Models.BitData.get_random())

func _on_new_bit(act_bit: ActNode) -> void:
	var bit_ui: BitUI = BIT_UI.instantiate()
	bit_ui.global_position = get_viewport_rect().size / 2
	bit_ui.state = act_bit
	ui_bits[act_bit] = bit_ui
	bit_ui.mouse_entered.connect(_select_link.bind(bit_ui))
	bit_ui.mouse_exited.connect(func (): selected = null)
	
	%Nodes.add_child(bit_ui)

	for connector_ui in bit_ui.ui_connectors:
		ui_connectors[connector_ui.state] = connector_ui
		connector_ui.mouse_entered.connect(_select_connector.bind(connector_ui))
		connector_ui.mouse_exited.connect(func (): selected = null)

func _on_new_link(act_link: ActLink) -> void:
	ui_links[act_link] = LinkUI.new(
		act_link,
		ui_bits[act_link.left.bit],
		ui_bits[act_link.right.bit]
	)
	
	%Connections.add_child(ui_links[act_link])
	
func _select_connector(connector_ui: ConnectorUI) -> void:
	selected = SelectionCycler.new(
		get_compatible_connectors,
		connector_ui
	)

func _select_link(bit_ui: BitUI) -> void:
	selected = SelectionCycler.new(
		get_compatible_links,
		bit_ui
	)

func _process(_delta: float) -> void:
	handle_input()
	queue_redraw()

func handle_input():
	if selected == null:
		return
	if Input.is_action_just_pressed("act_viewer_select"):
		handle_state_update(selected.source)
	elif Input.is_action_just_pressed("act_viewer_cycle_fwd"):
		selected.next()
	elif Input.is_action_just_pressed("act_view_cycle_back"):
		selected.previous()
	elif Input.is_action_just_pressed("act_view_play") and selected.source is ConnectorUI:
		player.play_from_connector((selected.source as ConnectorUI).state)
		
func handle_state_update(node: Node):
	if not  selected.selected:
		return
	if node is ConnectorUI:
		act.link_connectors(node.state, selected.selected.state)
	if node is BitUI:
		act.toggle_link(selected.selected.state)

func _draw() -> void:
	if selected == null:
		return
	draw_selector_box(selected.source, Color.YELLOW, 3)
	draw_selector_box(selected.selected, Color.YELLOW, 3)

func draw_selector_box(node: Node, color: Color, width: int) -> void:
	if node is BitUI or node is ConnectorUI:
		draw_rect(node.get_global_rect(), color, false, width) 
	if node is LinkUI:
		draw_polyline(node.width_polygon(node.width + 4), color, width)

func get_compatible_connectors(connector: ConnectorUI) -> Array[ConnectorUI]:
	return connector.state.get_compatible().map(func (c): return ui_connectors.get(c))

func get_compatible_links(bit_ui: BitUI) -> Array[LinkUI]:
	return bit_ui.state.get_bridges().map(func (c: ActConnector): return ui_links.get(c.link))
