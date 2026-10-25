class_name Editor extends Control

const BIT_UI: PackedScene = preload("res://Gig/Act/UI/Elements/bit_ui.tscn")

var ui_links

var connection_selection: SelectionCycler
var link_selection: SelectionCycler 

class SelectionCycler:
	var index: int = 0
	var source: Node
	var cycle: Array[Node]
	var selected: Node:
		get: return cycle[index - 1]
	
	func _init(cycle_getter: Callable, _source: CanvasItem) -> void:
		source = _source
		cycle = cycle_getter.call(_source)
	
	func next() -> CanvasItem:
		index += 1
		index %= cycle.size()
		return selected

var act: ActState = ActState.new()


func _on_new_bit(bit_data: Models.BitData) -> void:
	var bit_ui: BitUI = BIT_UI.instantiate()
	bit_ui.state = ActNode.new(bit_data, act)

func new_bit(bit: BitUI) -> void:
	bit.request_link_scroll.connect(cycle_links)
	bit.request_selection_start.connect(set_selected_bit.bind(bit))
	bit.request_selection_end.connect(set_selected_bit.bind(null))

func set_selected_bit(bit: BitUI) -> void:
	if bit == null:
		link_selection = null
	link_selection = CycleContext.new(get_compatible_links, bit)

func cycle_links() -> void:
	if link_selection == null:
		return
	link_selection.current.selected = false
	link_selection.next()
	link_selection.current.selected = true

func select_link() -> void:
	if link_selection == null:
		return
	# call to graph link_selection.current.

func get_compatible_links(bit: ActNode) -> Array[LinkUI]:
	var act_links = bit.connectors.filter(func (c): return c.link != null).map(func (c): return c.link)
	return ui_links.filter(func (l): return l.state in act_links)
