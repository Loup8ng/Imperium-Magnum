extends TileMapLayer

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var width = 33
var height = 33
var last_chunk = Vector2i(-9999, -9999)

@onready var player = get_parent().get_child(1)

func _ready():
	randomize()
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()

	moisture.frequency = 0.05
	temperature.frequency = 0.05
	altitude.frequency = 0.03

	# On génère le premier chunk tout de suite
	var start_chunk = Vector2i(local_to_map(player.position).x / width, local_to_map(player.position).y / height)
	generate_chunk(start_chunk)
	last_chunk = start_chunk

func _process(_delta):
	var player_tile = local_to_map(player.position)
	var current_chunk = Vector2i(player_tile.x / width, player_tile.y / height)

	# Générer seulement si le joueur entre dans un NOUVEAU chunk
	if current_chunk != last_chunk:
		last_chunk = current_chunk
		print("📦 Nouveau chunk :", current_chunk)
		generate_chunk(current_chunk)

func generate_chunk(chunk_pos: Vector2i):
	print("→ Génération du chunk :", chunk_pos)
	var start_x = chunk_pos.x * width
	var start_y = chunk_pos.y * height

	for x in range(width):
		for y in range(height):
			var world_x = start_x + x
			var world_y = start_y + y

			var alt = altitude.get_noise_2d(world_x, world_y)

			var tile_coords = Vector2i(0, 0)
			if alt < -0.2:
				tile_coords = Vector2i(0, 0) # eau
			elif alt < 0.2:
				tile_coords = Vector2i(1, 0) # sable
			elif alt < 0.5:
				tile_coords = Vector2i(2, 0) # herbe
			else:
				tile_coords = Vector2i(3, 0) # montagne

			set_cell(Vector2i(world_x, world_y), 0, tile_coords)
