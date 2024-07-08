class_name game_utils extends Node

func property_recursive(node, props, only_children = false):
	if not only_children:
		for prop in props:
			node.set(prop.name, prop.value)
	var children = node.get_children();
	if (len(children) > 0):
		for child in children:
			property_recursive(child, props, false)
