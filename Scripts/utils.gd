extends Node

func deferr_free_node(node):
	call_deferred("free_node", node)

func free_node(node):
	node.get_parent().remove_child(node);
	node.queue_free();
