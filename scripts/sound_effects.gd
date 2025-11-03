extends Node2D

# Audio players for different sounds
var audio_players := []
var note_frequencies := {
	1: 261.63,  # C4
	2: 293.66,  # D4
	3: 329.63,  # E4
	4: 349.23   # F4
}

func _ready():
	# Create audio stream players
	for i in range(8):
		var player = AudioStreamPlayer.new()
		add_child(player)
		audio_players.append(player)

func play_guitar_note(note_number: int):
	# Find available player
	var player = get_available_player()
	if player:
		# Create a simple sine wave tone
		var generator = AudioStreamGenerator.new()
		generator.mix_rate = 44100
		generator.buffer_length = 0.5
		player.stream = generator
		player.play()

		# Generate tone using playback
		if player.get_stream_playback():
			var playback = player.get_stream_playback()
			var frequency = note_frequencies.get(note_number, 440.0)
			generate_tone(playback, frequency, 0.3)

func play_jump():
	var player = get_available_player()
	if player:
		var generator = AudioStreamGenerator.new()
		generator.mix_rate = 44100
		generator.buffer_length = 0.2
		player.stream = generator
		player.play()

func generate_tone(playback, frequency: float, duration: float):
	var hz = frequency
	var sample_rate = 44100.0
	var increment = hz / sample_rate

	var to_fill = int(sample_rate * duration)
	var phase = 0.0

	for i in range(to_fill):
		var sample = sin(phase * TAU) * 0.3
		playback.push_frame(Vector2(sample, sample))
		phase = fmod(phase + increment, 1.0)

func get_available_player():
	for player in audio_players:
		if not player.playing:
			return player
	return audio_players[0] if audio_players.size() > 0 else null
