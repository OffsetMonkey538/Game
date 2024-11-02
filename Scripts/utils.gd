extends Node

func deferr_free_node(node: Node):
	node.queue_free()
	node.get_parent().remove_child.call_deferred(node)
