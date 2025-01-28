class_name CustomButton
extends TextureButton

@export var autofocus: bool = false
@export var disable_mouse: bool = true

var normal_text
var pressed_text
var focused_text
var neighbor_t
var neighbor_b

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if disable_mouse: 
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		mouse_filter = MOUSE_FILTER_IGNORE
	if autofocus: grab_focus()
	
	normal_text = texture_normal
	pressed_text = texture_pressed
	focused_text = texture_focused
	neighbor_t = focus_neighbor_top
	neighbor_b = focus_neighbor_bottom
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)


func _process(delta: float) -> void:
	texture_normal = null if has_focus() else normal_text


func _on_button_down():
	texture_focused = null
	focus_neighbor_top = NodePath()
	focus_neighbor_bottom = NodePath()


func _on_button_up():
	texture_focused = focused_text
	focus_neighbor_top = neighbor_t
	focus_neighbor_bottom = neighbor_b
