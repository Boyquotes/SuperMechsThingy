extends TabBar



@onready var name_label: Label = %NameLabel
@onready var sprite: TextureRect = %Sprite
@onready var type_options: OptionButton = %TypeOptions
@onready var element_options: OptionButton = %ElementOptions
@onready var stats_display: GridContainer = %StatsDisplay



var item: ItemDef



func _ready() -> void:

	type_options.clear()

	for type in ItemDef.Type.keys():
		type_options.add_item(type.capitalize())

	for element in ItemDef.Element.keys():
		element_options.add_item(element.capitalize())



func set_item(value: ItemDef) -> void:

	if value == null:
		clear()
		return

	item = value

	sprite.texture = Assets.get_texture_for_item(item)

	name_label.text = item.display_name
	stats_display.set_stats(item.stats)

	type_options.select(item.type)
	element_options.select(item.element)


func clear() -> void:

	item = null

	name_label.text = ""
	stats_display.clear()

	type_options.select(-1)
	element_options.select(-1)


func _on_type_selected(index: int) -> void:
	item.type = index as ItemDef.Type


func _on_element_selected(index: int) -> void:
	item.element = index as ItemDef.Element


func _on_export_button_pressed() -> void:
	print(JSON.stringify(item.to_json(), "\t"))