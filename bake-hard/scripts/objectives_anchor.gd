class_name ObjectivesAnchor
extends Control

# Objectives will
# - Appear when they are relevant
# - Strikethrough, then dissapear when they are completed
# - Display in a column, filling when new objectives appear/dissapear
# - React to signals elsewhere in the level

# Objectives shall be handled generically in this class,
# and will be handled via signals at a higher level otherwise.

signal objective_added
signal objective_removed

# Keep a reference to the container for objectives
@onready var display_list : VBoxContainer = $VBoxContainer/Objectives/VBoxContainer

## Adds a new RichTextLabel object to the objective anchor's display 'list'
## Calls for
##     obj_name : String, name of the objective. Assigned to the Label's name for later access
##     contents : String, the actual displayed text the objective will use.
## Example- add_objective("Fish", "Capture at least ten fish")
func add_objective(obj_name: String, contents: String) -> void:
	var new_label: RichTextLabel = RichTextLabel.new()
	new_label.name = obj_name
	new_label.text = contents
	new_label.custom_minimum_size.x = 400
	new_label.fit_content = true
	display_list.add_child(new_label)
	objective_added.emit()

## Removes an exisiting RichTextLabel from the objective anchor's display 'list'
## Calls for
##     obj_name : String, name of the objective. Searches for the node by this path under the display 'list'
## Example- remove_objective("Fish")
func remove_objective(obj_name: String) -> void:
	# Do stuff, but for now delete this
	display_list.get_node(obj_name).queue_free()
	objective_removed.emit()
