extends Node2D
signal value_entered(value: int)
@onready var input_field: LineEdit = $LineEdit
@onready var popup: AcceptDialog = $AcceptDialog


func _ready():
	# Connecte le signal Confirm du popup
	popup.confirmed.connect(_on_popup_confirmed)

func _on_Button_pressed():
	var text = input_field.text

	if text.is_valid_int():
		var value = text.to_int()
		# Message dans le popup
		popup.dialog_text = "Vous avez entré : " + str(value)
		popup.popup()
		
		emit_signal(value)
	else:
		popup.dialog_text = "❌ Veuillez entrer un entier valide."
		popup.popup()

func _on_popup_confirmed():
	print("Popup fermé")
