/// @description Performs the event for all components in the entity
/// argument0 - event
/// argument1 - event type

var event = argument0
var type = argument1

var cnt = ds_list_size(primary_components)
for (var i = 0; i < cnt; i++) {
	var component = primary_components[| i]
	event_perform_object(component, event, type)
}