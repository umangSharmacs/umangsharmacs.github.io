# Music Assets Directory

## MIDI Files Location

Place your MIDI files (.mid or .midi) in this directory.

### File Naming Convention
- Use descriptive names: `song-name.mid`
- Examples: `mary-had-a-little-lamb.mid`, `twinkle-twinkle.mid`

### Supported Features
- Single track or multi-track MIDI files (will use first track)
- Standard MIDI format (Type 0 or Type 1)
- Any tempo/BPM
- Notes in range C4-B4 (middle octave)

### How It Works
The piano game will:
1. Automatically detect all `.mid` files in this directory
2. Parse them using Tone.js MIDI parser
3. Display them in the song selection menu
4. Convert notes to the game format automatically

### Current Songs
(Place your MIDI files here)
