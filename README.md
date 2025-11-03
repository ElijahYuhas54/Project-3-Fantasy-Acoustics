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
