# Ballad of the Sacred Strings

A medieval fantasy adventure where music is magic, and silence is a curse.

## Story

In a world plunged into silence by a tyrant who has stolen all sound, a brave bard must embark on a quest to restore harmony to the realm. Armed with a magical guitar, you face the **Silence Shadows**—dark silhouette creatures that drain all sound from the world.

Your mission: defeat the shadow enemies, restore the silenced lands, and step through the mystical portal to complete your quest.

## Game Description

**Ballad of the Sacred Strings** is a 2D rhythm-action fantasy platformer where music becomes your weapon. As a heroic bard, you wield a magical guitar that fires musical notes at enemies. Master the art of sequence matching to unleash devastating beam attacks, explore a beautifully layered fantasy world, and bring harmony back to the land.

## Core Gameplay Concepts

### Musical Combat System
- **Note Attacks**: Fire individual musical notes (1/2/3/4 keys) that appear as floating song notes
- **Sequence Matching**: Match a randomly generated 4-note sequence to unlock your ultimate ability
- **Song Beam Attack**: After matching the sequence, press SPACE to unleash a continuous 2-second beam of 20 random notes
- **Visual Guitar**: Your guitar appears beside you during attacks and orbits around you during beam attacks

### Enemy Encounters
- **Silence Shadows**: Dark silhouette enemies that patrol the world and attack on sight
- **Damage System**: Notes collide with enemies to deal damage
- **Enemy AI**: Shadows detect and pursue the player within range
- **Shadow Projectiles**: Enemies fire dark projectiles that damage the player

### Progression System
- **Health & Energy**: Monitor your health bar and energy gauge in the HUD
- **Portal Victory**: After defeating all shadow enemies, a mystical portal appears at position (1680, 740)
- **Win Condition**: Enter the portal to see the victory screen and restart the adventure

### World Restoration
- **Silenced Areas**: Gray zones with X symbols scattered throughout the world
- **Restoration Magic**: After completing powerful attacks, nearby silenced areas are restored
- **Visual Feedback**: Restored areas regain their color and vitality

## Controls

### Movement
- `A` or `Left Arrow` - Move left
- `S` or `Right Arrow` - Move right
- `W` or `Up Arrow` - Jump
- `Space Bar` - Jump
- Camera follows player with smooth tracking

### Guitar Playing
- `1` - Play Note 1
- `2` - Play Note 2
- `3` - Play Note 3
- `4` - Play Note 4
- `E` - Unleash Song Beam (only after matching the sequence)

### Gameplay Flow
1. Watch the HUD for the required 4-note sequence
2. Play the notes in the correct order (1/2/3/4)
3. When sequence is matched, press E to fire the beam attack
4. Your guitar orbits around you while firing 20 notes in 2 seconds
5. Defeat all shadow enemies to spawn the portal
6. Enter the portal to complete the level

## Features

### Visual & Audio
- 🎸 **Dynamic Guitar Visual**: Detailed pixelated guitar with proper body, neck, frets, strings, and tuning pegs
- 🎵 **Musical Note Sprites**: Four unique song note graphics (song_1.png through song_4.png) used as projectiles
- 🎨 **Particle Effects**: Guitar attack particles, note trails, and restoration magic
- 🌌 **Parallax Backgrounds**: Multi-layered scrolling backgrounds with atmospheric depth
- ✨ **Ambient Particles**: Floating particles add life to the mystical atmosphere

### Combat & Mechanics
- ⚔️ **Rhythm-Based Combat**: Match sequences to unlock powerful attacks
- 🎯 **Projectile System**: Musical notes fly across the screen with physics-based movement
- 🔄 **Orbital Guitar Animation**: Guitar spins and orbits during ultimate attack
- 💥 **Damage Feedback**: Visual indicators when enemies take damage
- 🎭 **Character Animations**: Idle, walk, and jump animations for the Hero sprite

### Game Systems
- 📊 **Complete HUD**: Health bar, energy meter, sequence display, and feedback messages
- 🚪 **Portal System**: Mystical portal spawns after victory condition is met
- 🏆 **Win Screen**: Freeze-frame victory screen with "Play Again" button
- 🎮 **Smooth Platforming**: Physics-based movement with responsive controls
- 👁️ **Z-Index Rendering**: Proper layering ensures player renders in front of portals

### Enemy AI
- 👤 **Shadow Enemies**: Silhouette creatures with patrol and attack behaviors
- 🎯 **Detection System**: Enemies detect player within range and give chase
- 💀 **Enemy Projectiles**: Shadows can fire silence projectiles at the player
- 🔄 **Hurt Animations**: Visual feedback when enemies take damage

## Installation & Running

### Requirements
- **Godot Engine 4.5** or later
- **Linux** (tested on Ubuntu with kernel 6.8.0-86-generic)
- **Resolution**: 1920x1080 recommended

### Setup Instructions
1. Install Godot Engine 4.5+ from [godotengine.org](https://godotengine.org/download)
2. Clone or download this repository
3. Open Godot Engine
4. Click "Import" and navigate to the project folder
5. Select `project.godot`
6. Click "Import & Edit"
7. Press `F5` or click the "Play" button to start

### Command Line
```bash
cd /home/eyuhas2022/Documents/Claude/BalladOfTheSacredStrings
godot4  # Opens editor
# or
godot4 --run  # Runs directly
```

## Project Structure

```
BalladOfTheSacredStrings/
├── project.godot              # Main project configuration
├── icon.svg                   # Game icon
├── README.md                  # This file
│
├── assets/
│   └── sprites/
│       ├── Hero_001_Idle.png      # Player idle animation sprite sheet
│       ├── Hero_001_Walk.png      # Player walk animation sprite sheet
│       ├── Hero_001_Jump.png      # Player jump animation sprite sheet
│       ├── song_1.png             # Musical note sprite 1
│       ├── song_2.png             # Musical note sprite 2
│       ├── song_3.png             # Musical note sprite 3
│       └── song_4.png             # Musical note sprite 4
│
├── scenes/
│   ├── main.tscn              # Main game level with platforms and enemies
│   ├── player.tscn            # Player character with animations
│   ├── guitar_visual.tscn     # Detailed guitar sprite
│   ├── guitar_sprite.tscn     # Guitar particle effects
│   ├── sound_wave.tscn        # Musical note projectile
│   ├── silence_enemy.tscn     # Shadow enemy character
│   ├── silence_projectile.tscn # Enemy projectile
│   ├── silenced_area.tscn     # Restoration objective zones
│   ├── portal.tscn            # Victory portal
│   └── win_screen.tscn        # Victory screen UI
│
└── scripts/
    ├── player.gd              # Player movement, combat, sequence matching
    ├── sound_effects.gd       # Procedural audio generation
    ├── sound_wave.gd          # Musical note projectile behavior
    ├── silence_enemy.gd       # Enemy AI and behavior
    ├── silence_projectile.gd  # Enemy attack projectile
    ├── silenced_area.gd       # Restoration zone logic
    ├── parallax_bg.gd         # Background scrolling system
    ├── game_manager.gd        # Portal spawning and game state
    ├── portal.gd              # Portal interaction and win screen trigger
    └── win_screen.gd          # Victory screen and restart functionality
```

## Technical Details

### Engine & Framework
- **Engine**: Godot 4.5 (stable.official.876b29033)
- **Language**: GDScript
- **Platform**: Linux (compatible with Windows/Mac)
- **Resolution**: 1920x1080 (windowed mode)

### Physics & Gameplay
- **Physics Engine**: Godot 2D Physics
- **Gravity**: 980.0 units/s²
- **Player Speed**: 300.0 units/s
- **Jump Velocity**: -500.0 units
- **Projectile Speed**: 400.0 units/s (regular), 500.0 units/s (beam)
- **Damage**: 15 base damage, 37.5 damage for beam attack (2.5x multiplier)

### Visual Systems
- **Sprite Sheets**: AtlasTexture system for character animations
- **Particle Systems**: CPUParticles2D for effects
- **Camera**: Camera2D with 2.1x zoom and smooth following
- **Collision Layers**: Layer 1 (player), Layer 2 (enemies), Layer 3 (projectiles)
- **Z-Index**: Player at z=10, portals at z=0

### Audio
- **Sound Generation**: Procedural sine wave audio generation
- **Note System**: 4 distinct musical notes
- **Audio Node**: AudioStreamPlayer for sound playback

### Game State Management
- **Pause System**: Tree pause (get_tree().paused) for win screen
- **Process Modes**: PROCESS_MODE_ALWAYS (value 3) for UI during pause
- **Scene Management**: Scene reloading for restart functionality
- **Group System**: "player", "enemy", "silenced_area" groups for entity queries

## Development Notes

### Key Implementation Details

**Sequence Matching System** (`player.gd:136-154`):
- Generates random 4-note sequences
- Validates player input against required sequence
- Unlocks beam attack on successful match
- Provides visual feedback with color flashing

**Beam Attack** (`player.gd:155-214`):
- Spawns 20 projectiles over 2 seconds (0.1s intervals)
- Guitar orbits in circular path (40-pixel radius)
- Guitar rotates 3 full spins (TAU * 3)
- Each note uses random sprite (randi() % 4 + 1)

**Portal System** (`game_manager.gd` & `portal.gd`):
- Spawns at Vector2(1680, 740) after all enemies defeated
- CircleShape2D collision (50-pixel radius)
- Freezes game and shows win screen on entry
- Fade-in animation with rotating visual

**Win Screen** (`win_screen.gd` & `win_screen.tscn`):
- CanvasLayer for overlay rendering
- Dual-layer darkening (70% black + 85% purple)
- Fade-in animation (0.5s duration)
- Queue_free() cleanup before scene reload

**Guitar Visual** (`guitar_visual.tscn`):
- Polygon2D-based design with 12-sided body shape
- Visible strings, frets, tuning pegs, bridge, sound hole
- Scale: 0.6 (60% of original size)
- Position: 20 pixels to player's side based on facing direction

**Collision System** (`sound_wave.gd`):
- collision_mask = 7 (layers 1, 2, 3)
- Area2D with body_entered signal
- Sprite scale: 0.3 (30% of original)
- Random texture selection from 4 note sprites

## Credits & Inspiration

**Developed by**: Claude Code Assistant & User Collaboration

**Inspired by**:
- **Wandersong** - Musical combat and wholesome adventure
- **A Hat in Time** - Smooth platforming and vibrant worlds
- **Crypt of the Necrodancer** - Rhythm-based gameplay
- **Sayonara Wild Hearts** - Visual spectacle and music fusion
- **Hyper Light Drifter** - Atmospheric pixel art design

**Asset Sources**:
- Hero 001 Sprite Sheets - Custom pixel art
- Song Note Graphics - Custom musical note designs
- All code and game design created during development

---

## Tips for Players

💡 **Watch the Sequence**: The HUD shows which notes to play - memorize the pattern!

💡 **Timing Matters**: Wait for your guitar to disappear before playing the next note

💡 **Save Your Beam**: Use the beam attack when surrounded by multiple enemies

💡 **Explore Thoroughly**: Silenced areas contain secrets and restoration opportunities

💡 **Mind Your Health**: Enemy projectiles hurt - jump to dodge!

💡 **Portal Position**: The portal spawns to the right at ground level (1680, 740)

---

*🎵 "Where music fades, hope must sing louder." 🎵*

**Version**: 1.0
**Last Updated**: November 2025
**License**: Educational/Personal Project
