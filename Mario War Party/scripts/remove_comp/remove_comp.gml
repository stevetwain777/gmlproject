/// @description Removes a component to the entity
/// argument0 - component object

var component = argument0

component = components[? component]
if (is_undefined(component)) {
	return false
}

var index = ds_list_find_index(primary_components, component)
if (index < 0) {
	show_error_message("Attempted removing " + object_get_name(component) + " but not found as primary component")
	return false
}

event_perform_object(component, ev_destroy, 0)

ds_list_delete(primary_components, index)

do {
	ds_map_delete(components, component)
	component = object_get_parent(component)
} until (component < 0)

return true
