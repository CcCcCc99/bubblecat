extends TextureRect


func set_activated_skill(skill: Sprite2D):
	skill.position = size/2
	add_child(skill)
	
func remove_activated_skill():
	for child in get_children():
		child.queue_free()
