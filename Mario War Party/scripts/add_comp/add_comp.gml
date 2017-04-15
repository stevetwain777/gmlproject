/// @description Adds a component to the entity (if it doesn't have it already)
/// argument0 - component object
/// return    - false, if component already existed.
///             true,  if component was added. 

#macro COMP_MIN_ARGS 1

var component = arguments[0]

if (!is_undefined(components[? component])) {
	return false
}

// Add the top-level component to our primary_component list
ds_list_add(primary_components, component)

var parent = component
do {
	components[? parent] = component
	parent = object_get_parent(parent)
} until(parent < 0)

if (argument_count > 1) {
	comp_args = arguments
	comp_args_count = argument_count
}

event_perform_object(component, ev_create, 0)

if (argument_count > 1) {
	comp_args = undefined
	comp_args_count = undefined
}

return true