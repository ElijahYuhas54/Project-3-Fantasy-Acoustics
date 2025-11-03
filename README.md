# Ballad of the Sacred Strings

A medieval fantasy adventure where music is magic, and silence is a curse.

## Story
In a world plunged into silence by a tyrant who has stolen all sound, **Lyric**, a brave bard in flowing purple robes, must embark on a quest to recover the Sacred Guitar—an ancient instrument said to hold the power to restore harmony to the realm. Armed with magical guitar melodies, Lyric faces the **Silence Shadows**, dark silhouette creatures that drain all sound from the world.

## How to Play

### Installation
1. Download and install [Godot Engine 4.3](https://godotengine.org/download) or later
2. Open Godot Engine
3. Click "Import" and navigate to the `BalladOfTheSacredStrings` folder
4. Select the `project.godot` file
5. Click "Import & Edit"
6. Press F5 or click the "Play" button to start the game

### Controls

**Movement:**
- `A` or `Left Arrow` - Move left
- `D` or `Right Arrow` - Move right
- `W` or `Space` - Jump

**Guitar Playing:**
- `1` - Play first note (C4 - Red)
- `2` - Play second note (D4 - Green)
- `3` - Play third note (E4 - Blue)
- `4` - Play fourth note (F4 - Yellow)
- `E` - Play Restoration Melody (costs 20 Sound Power)

### Gameplay Mechanics

**Melody System:**
Play sequences of notes to gain Sound Power:
- `1-2-3-4` - Perfect Melody (+10 power)
- `4-3-2-1` - Harmonic Reversal (+15 power)
- `1-3-2-4` - Nice Rhythm (+8 power)

**Sound Waves:**
Each note you play shoots a colored sound wave that can:
- Damage silence enemies
- Cancel silence projectiles
- Contribute to area restoration

**Restoration Spell:**
When you have at least 20 Sound Power, press `E` to unleash a powerful restoration spell that:
- Shoots 8 sound waves in all directions
- Restores nearby silenced areas
- Damages all enemies in range

**Objectives:**
- Defeat the Silence Enemies (dark shadow creatures)
- Restore the Silenced Areas (gray zones with X symbols)
- Build up Sound Power through perfect melodies
- Explore the mystical landscape

## Features

✨ **Rhythm-Based Combat** - Play musical sequences to defeat enemies

🎵 **Procedural Sound Generation** - Each note generates real audio frequencies

🌌 **Atmospheric Parallax Backgrounds** - Multi-layered medieval fantasy scenery

⚔️ **Enemy AI** - Shadowy silhouette creatures that detect and attack the player

🎨 **Particle Effects** - Sound waves, restoration magic, and atmospheric particles

🎮 **Smooth Platforming** - Physics-based movement with perfectly spaced platforms

📊 **Complete HUD System** - Health bar, energy bar, and real-time feedback

👤 **Detailed Characters** - Hand-crafted human protagonist and shadow enemies

🎸 **Visual Guitar System** - Beautifully rendered guitar sprite with particle effects

## Game Structure

```
BalladOfTheSacredStrings/
├── project.godot          # Main project configuration
├── icon.svg              # Game icon
├── scenes/
│   ├── main.tscn         # Main game level
│   ├── player.tscn       # Player character
│   ├── sound_wave.tscn   # Sound wave projectile
│   ├── silence_enemy.tscn # Enemy character
│   ├── silence_projectile.tscn # Enemy projectile
│   └── silenced_area.tscn # Restoration objective
└── scripts/
    ├── player.gd         # Player logic and controls
    ├── sound_effects.gd  # Audio generation
    ├── sound_wave.gd     # Projectile behavior
    ├── silence_enemy.gd  # Enemy AI
    ├── silence_projectile.gd # Enemy attack
    ├── silenced_area.gd  # Restoration zones
    └── parallax_bg.gd    # Background scrolling
```

## Technical Details

- **Engine:** Godot 4.3+
- **Language:** GDScript
- **Resolution:** 1920x1080 (windowed fullscreen)
- **Audio:** Procedural sine wave generation
- **Physics:** 2D physics with gravity (980.0)

## Credits

Developed for the Ballad of the Sacred Strings game jam project.

**Inspired by:**
- Florence (emotional storytelling)
- Sayonara Wild Hearts (rhythm-based gameplay)
- One Hand Clapping (sound-based puzzles)
- Crypt of the Necrodancer (rhythm combat)

---

*🎵 "Where music fades, hope must sing louder." 🎵*
