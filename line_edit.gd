extends LineEdit

signal taille_map(value : int)
func _on_button_pressed() -> void:
	var texte = text
	print(texte)
	texte = texte.to_int()
	print(texte)
	emit_signal("taille_map",texte)

	# ✅ Masquer le LineEdit
	visible = false

	# ✅ Masquer le bouton (en allant le chercher via le parent)
	get_parent().get_node("Button").visible = false
