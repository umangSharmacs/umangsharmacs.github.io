---
layout: invitation
title: Music
permalink: /invitation/music/
---

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style>
    :root {
        /* Theme Colors */
        --color-primary: #123524;
        --color-secondary: #00a767;
        --color-accent: #eefdf4;
        --color-background: #e8f3f5;
        --color-white: #ffffff;
        --color-text-primary: #e8f3f5;
        --color-text-secondary: #eefdf4;;
        --color-text-muted: #718096;
        --color-border-accent: #a8d5ba;
        --color-note: #52a876;
        --color-judgment: #00a767;
        --color-miss: #c85a54;
    }

    .material-symbols-outlined {
        font-variation-settings:
        'FILL' 0,
        'wght' 400,
        'GRAD' 0,
        'opsz' 24
    }

    .section-view {
        padding: 20px;
        max-width: 900px;
        margin: 0 auto;
    }

    .section-view h1 {
        font-size: 2.5rem;
        color: var(--color-primary);
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .section-view h1 .material-symbols-outlined {
        font-size: 2.5rem;
    }

    /* Piano Game Styles */
    .piano-game {
        background: linear-gradient(135deg, #f5fdf8 0%, #edf9f1 100%);
        border-radius: 20px;
        padding: 30px;
        margin-top: 2rem;
        border: 2px solid var(--color-border-accent);
    }

    #pianoCanvas {
        display: block;
        margin: 2rem auto;
        border: 2px solid var(--color-border-accent);
        border-radius: 16px;
        background: linear-gradient(135deg, var(--color-background) 0%, var(--color-accent) 100%);
        box-shadow: 0 4px 12px rgba(18, 53, 36, 0.1);
    }

    .game-controls {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin: 20px 0;
        flex-wrap: wrap;
    }

    .control-btn {
        background: linear-gradient(135deg, var(--color-secondary) 0%, var(--color-primary) 100%);
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 12px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .control-btn:hover:not(:disabled) {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 167, 103, 0.4);
    }

    .control-btn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }

    .control-btn.secondary {
        background: linear-gradient(135deg, var(--color-border-accent) 0%, #7bb896 100%);
    }

    .song-selector {
        margin: 20px 0;
        text-align: center;
    }

    .song-selector label {
        font-weight: 600;
        color: var(--color-text-primary);
        margin-right: 10px;
        font-size: 1.1rem;
    }

    .song-selector select {
        padding: 8px 15px;
        border: 2px solid var(--color-border-accent);
        border-radius: 8px;
        font-size: 1rem;
        background: white;
        cursor: pointer;
        min-width: 200px;
    }

    .game-instructions {
        background: linear-gradient(135deg, #f5fdf8 0%, #edf9f1 100%);
        border: 1px solid var(--color-border-accent);
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 1rem;
        text-align: center;
    }

    .instruction-text {
        font-size: 1.1rem;
        color: var(--color-text-secondary);
        font-weight: 500;
        margin-bottom: 0.5rem;
    }

    .key-mapping {
        display: flex;
        justify-content: center;
        gap: 5px;
        margin-top: 1rem;
        flex-wrap: wrap;
    }

    .piano-key-indicator {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
    }

    .key-label {
        background: var(--color-primary);
        color: white;
        padding: 8px 12px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.9rem;
        min-width: 40px;
        text-align: center;
    }

    .note-label {
        font-size: 0.8rem;
        color: var(--color-text-muted);
        font-weight: 500;
    }

    .game-status {
        text-align: center;
        font-size: 1.2rem;
        font-weight: 600;
        color: var(--color-primary);
        margin: 15px 0;
        min-height: 30px;
    }

    .loading-message {
        text-align: center;
        padding: 20px;
        color: var(--color-text-secondary);
        font-size: 1.1rem;
    }

    .error-message {
        text-align: center;
        padding: 20px;
        color: var(--color-miss);
        font-size: 1.1rem;
        background: rgba(200, 90, 84, 0.1);
        border-radius: 8px;
        margin: 10px 0;
    }
</style>

<div class="section-view">
    <h1><span class="material-symbols-outlined">piano</span> Piano Hero</h1>

    <div class="piano-game">
        <div class="game-instructions">
            <div class="instruction-text">
                Press the keys when notes reach the judgment line!
            </div>
            <div class="key-mapping">
                <div class="piano-key-indicator">
                    <div class="key-label">A</div>
                    <div class="note-label">C</div>
                </div>
                <div class="piano-key-indicator">
                    <div class="key-label">S</div>
                    <div class="note-label">D</div>
                </div>
                <div class="piano-key-indicator">
                    <div class="key-label">D</div>
                    <div class="note-label">E</div>
                </div>
                <div class="piano-key-indicator">
                    <div class="key-label">F</div>
                    <div class="note-label">F</div>
                </div>
                <div class="piano-key-indicator">
                    <div class="key-label">G</div>
                    <div class="note-label">G</div>
                </div>
                <div class="piano-key-indicator">
                    <div class="key-label">H</div>
                    <div class="note-label">A</div>
                </div>
                <div class="piano-key-indicator">
                    <div class="key-label">J</div>
                    <div class="note-label">B</div>
                </div>
            </div>
        </div>

        <div class="song-selector">
            <label for="songSelect">Choose a Song:</label>
            <select id="songSelect">
                <option value="">Loading songs...</option>
            </select>
        </div>

        <div class="game-status" id="gameStatus">Select a song and click Start!</div>

        <div class="game-controls">
            <button class="control-btn" id="startBtn" onclick="startGame()">
                <span class="material-symbols-outlined">play_arrow</span>
                Start
            </button>
            <button class="control-btn secondary" id="stopBtn" onclick="stopGame()" disabled>
                <span class="material-symbols-outlined">stop</span>
                Stop
            </button>
        </div>

        <canvas id="pianoCanvas" width="800" height="600"></canvas>

        <div id="loadingMessage" class="loading-message">
            Loading MIDI file...
        </div>
        <div id="errorMessage" class="error-message" style="display: none;"></div>
    </div>
</div>

<!-- Audio Libraries -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/tone/14.7.77/Tone.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@tonejs/midi@2.0.28/build/Midi.js"></script>
<script>
/* =========================
   CONFIG
========================= */
const CONFIG = {
  LANES: ['C4','D4','E4','F4','G4','A4','B4'],
  KEY_MAP: {
    KeyA:'C4', KeyS:'D4', KeyD:'E4',
    KeyF:'F4', KeyG:'G4', KeyH:'A4', KeyJ:'B4'
  },
  NOTE_TO_KEY: {
    'C4':'A', 'D4':'S', 'E4':'D',
    'F4':'F', 'G4':'G', 'A4':'H', 'B4':'J'
  },
  KEY_TO_LANE: {
    'C4': 0, 'D4': 1, 'E4': 2, 'F4': 3, 'G4': 4, 'A4': 5, 'B4': 6
  },
  NOTE_FALL_TIME: 2.0, // Seconds for note to fall from top to judgment line
  HIT_WINDOW: 0.15, // Hit window in seconds (±0.15s = 300ms total)
  CANVAS_WIDTH: 800,
  CANVAS_HEIGHT: 600,
  JUDGMENT_LINE_Y: 500, // Y position of judgment line
  NOTE_SIZE: 40
};

/* =========================
   STATE
========================= */
let currentSong = null;
let allMidiNotes = []; // All notes from MIDI file
let gameNotes = []; // Notes to display in game (simplified from MIDI)

let gameStartTime = 0;
let currentTime = 0;
let animationId = null;

let isPlaying = false;
let score = 0;
let combo = 0;

/* =========================
   AUDIO
========================= */
// Piano sampler for playing MIDI notes
const piano = new Tone.Sampler({
  urls: {
    C4: "C4.mp3",
    "D#4": "Ds4.mp3",
    "F#4": "Fs4.mp3",
    A4: "A4.mp3",
  },
  baseUrl: "https://tonejs.github.io/audio/salamander/",
}).toDestination();

// Simple synth for keyboard feedback
const synth = new Tone.Synth().toDestination();

/* =========================
   INIT
========================= */
window.addEventListener("DOMContentLoaded", init);

async function init() {
  try {
    await loadMidiFile("RiverFlowsInYou.mid");
    setupInput();
    drawIdle();
  } catch (error) {
    console.error("Initialization failed:", error);
  }
}

/* =========================
   MIDI LOADING
========================= */
async function loadMidiFile(filename) {
  try {
    // Fetch MIDI file as ArrayBuffer
    const response = await fetch(`/misc/invitation/music-assets/${filename}`);
    if (!response.ok) throw new Error(`Failed to load ${filename}`);

    const arrayBuffer = await response.arrayBuffer();

    // Parse with @tonejs/midi
    const midi = new Midi(arrayBuffer);

    // Extract metadata
    currentSong = {
      title: filename.replace('.mid', ''),
      filename: filename,
      bpm: midi.header.tempos[0]?.bpm || 120,
      timeSignature: midi.header.timeSignatures[0] || [4, 4],
      duration: midi.duration,
      chunks: []
    };

    Tone.Transport.bpm.value = currentSong.bpm;

    // Extract all notes for continuous playback
    allMidiNotes = extractNotesFromMidi(midi);

    // Generate game notes (simplified prompts every 2 beats)
    gameNotes = generateGameNotes(currentSong.bpm, currentSong.duration);

    document.getElementById("gameStatus").textContent = `Ready: ${currentSong.title}`;
    document.getElementById("loadingMessage").style.display = "none";

    return currentSong;
  } catch (error) {
    console.error("Error loading MIDI:", error);
    document.getElementById("errorMessage").textContent = `Error loading ${filename}: ${error.message}`;
    document.getElementById("errorMessage").style.display = "block";
    document.getElementById("loadingMessage").style.display = "none";
    throw error;
  }
}

function extractNotesFromMidi(midi) {
  const notes = [];

  // Merge all tracks, filter to C4-B4 range (MIDI 60-71)
  midi.tracks.forEach(track => {
    track.notes.forEach(note => {
      if (note.midi >= 60 && note.midi <= 71) {
        notes.push({
          name: note.name,           // "C4", "D4", etc.
          time: note.time,           // absolute time in seconds
          duration: note.duration,
          velocity: note.velocity
        });
      }
    });
  });

  // Sort by time and remove duplicates
  notes.sort((a, b) => a.time - b.time);
  return removeDuplicateNotes(notes);
}

function removeDuplicateNotes(notes) {
  const unique = [];
  for (let i = 0; i < notes.length; i++) {
    const current = notes[i];
    const isDuplicate = unique.some(n =>
      n.name === current.name &&
      Math.abs(n.time - current.time) < 0.01
    );
    if (!isDuplicate) unique.push(current);
  }
  return unique;
}

function generateGameNotes(bpm, duration) {
  const beatDuration = 60 / bpm;
  const noteInterval = beatDuration * 2; // Every 2 beats
  const notes = [];

  for (let time = 2; time < duration; time += noteInterval) {
    // Generate random note
    const randomLane = CONFIG.LANES[Math.floor(Math.random() * CONFIG.LANES.length)];
    notes.push({
      time: time,
      note: randomLane,
      lane: CONFIG.KEY_TO_LANE[randomLane],
      hit: false,
      missed: false
    });
  }

  return notes;
}

/* =========================
   GAME START / STOP
========================= */
async function startGame() {
  if (!currentSong || !allMidiNotes.length) {
    document.getElementById("gameStatus").textContent = "No song loaded!";
    return;
  }

  await Tone.start();
  Tone.Transport.cancel();
  Tone.Transport.position = 0;

  isPlaying = true;
  score = 0;
  combo = 0;
  gameStartTime = Tone.now() + 0.1; // Small delay to sync

  // Reset all notes
  gameNotes.forEach(n => {
    n.hit = false;
    n.missed = false;
  });

  // Schedule all MIDI notes to play as background track
  allMidiNotes.forEach(note => {
    Tone.Transport.schedule((time) => {
      if (isPlaying) {
        piano.triggerAttackRelease(note.name, note.duration, time, note.velocity);
      }
    }, note.time);
  });

  // Schedule song completion
  Tone.Transport.schedule(() => {
    if (isPlaying) {
      stopGame();
      document.getElementById("gameStatus").textContent = `Song Complete! Score: ${score}`;
    }
  }, currentSong.duration);

  Tone.Transport.start();

  document.getElementById("startBtn").disabled = true;
  document.getElementById("stopBtn").disabled = false;

  // Start animation loop
  gameLoop();
}

function stopGame() {
  Tone.Transport.stop();
  Tone.Transport.cancel();
  isPlaying = false;

  if (animationId) {
    cancelAnimationFrame(animationId);
    animationId = null;
  }

  document.getElementById("startBtn").disabled = false;
  document.getElementById("stopBtn").disabled = true;
  drawIdle();
}

/* =========================
   GAME LOOP
========================= */
function gameLoop() {
  if (!isPlaying) return;

  currentTime = Tone.now() - gameStartTime;

  // Auto-miss notes that passed the judgment line
  gameNotes.forEach(note => {
    if (!note.hit && !note.missed) {
      const timeDiff = currentTime - note.time;
      if (timeDiff > CONFIG.HIT_WINDOW) {
        note.missed = true;
        combo = 0;
      }
    }
  });

  draw();
  animationId = requestAnimationFrame(gameLoop);
}

/* =========================
   INPUT
========================= */
function setupInput() {
  window.addEventListener("keydown", e => {
    const note = CONFIG.KEY_MAP[e.code];
    if (!note || !isPlaying) return;

    // Play feedback sound
    synth.triggerAttackRelease(note, "8n");

    // Find closest unhit note in this lane
    let closestNote = null;
    let closestDist = Infinity;

    gameNotes.forEach(n => {
      if (n.note === note && !n.hit && !n.missed) {
        const timeDiff = Math.abs(currentTime - n.time);
        if (timeDiff < closestDist && timeDiff < CONFIG.HIT_WINDOW) {
          closestNote = n;
          closestDist = timeDiff;
        }
      }
    });

    if (closestNote) {
      // Hit!
      closestNote.hit = true;
      score += 100;
      combo++;
      showJudgment("PERFECT");
    } else {
      // Wrong timing or wrong note
      combo = 0;
      showJudgment("MISS");
    }
  });
}

function showJudgment(text) {
  const status = document.getElementById("gameStatus");
  const oldText = status.textContent;
  status.textContent = text;
  status.style.color = text === "PERFECT" ? "var(--color-judgment)" : "var(--color-miss)";

  setTimeout(() => {
    if (isPlaying) {
      status.textContent = `Score: ${score} | Combo: ${combo}`;
      status.style.color = "var(--color-primary)";
    }
  }, 300);
}


/* =========================
   VISUALS
========================= */
const canvas = document.getElementById("pianoCanvas");
const ctx = canvas.getContext("2d");

function drawIdle() {
  ctx.clearRect(0, 0, CONFIG.CANVAS_WIDTH, CONFIG.CANVAS_HEIGHT);
  ctx.fillStyle = "#123524";
  ctx.font = "28px sans-serif";
  ctx.textAlign = "center";
  ctx.fillText("Press Start to Play", CONFIG.CANVAS_WIDTH / 2, CONFIG.CANVAS_HEIGHT / 2);
  ctx.textAlign = "left";
}

function draw() {
  // Clear canvas
  ctx.clearRect(0, 0, CONFIG.CANVAS_WIDTH, CONFIG.CANVAS_HEIGHT);

  drawLanes();
  drawJudgmentLine();
  drawNotes();
  drawKeyLabels();
}

function drawLanes() {
  const laneWidth = CONFIG.CANVAS_WIDTH / 7;

  for (let i = 0; i < 7; i++) {
    // Lane separator
    ctx.strokeStyle = "#a8d5ba";
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(i * laneWidth, 0);
    ctx.lineTo(i * laneWidth, CONFIG.CANVAS_HEIGHT);
    ctx.stroke();

    // Lane background (subtle)
    if (i % 2 === 0) {
      ctx.fillStyle = "rgba(232, 243, 245, 0.1)";
      ctx.fillRect(i * laneWidth, 0, laneWidth, CONFIG.CANVAS_HEIGHT);
    }
  }
}

function drawJudgmentLine() {
  ctx.strokeStyle = "#00a767";
  ctx.lineWidth = 4;
  ctx.beginPath();
  ctx.moveTo(0, CONFIG.JUDGMENT_LINE_Y);
  ctx.lineTo(CONFIG.CANVAS_WIDTH, CONFIG.JUDGMENT_LINE_Y);
  ctx.stroke();

  // Hit window indicator
  const windowSize = 20;
  ctx.fillStyle = "rgba(0, 167, 103, 0.2)";
  ctx.fillRect(0, CONFIG.JUDGMENT_LINE_Y - windowSize, CONFIG.CANVAS_WIDTH, windowSize * 2);
}

function drawNotes() {
  const laneWidth = CONFIG.CANVAS_WIDTH / 7;

  gameNotes.forEach(note => {
    if (note.hit || note.missed) return;

    // Calculate Y position based on time
    const timeUntilHit = note.time - currentTime;
    const fallProgress = 1 - (timeUntilHit / CONFIG.NOTE_FALL_TIME);

    if (fallProgress < 0 || fallProgress > 1.2) return; // Off screen

    const y = fallProgress * CONFIG.JUDGMENT_LINE_Y;
    const x = note.lane * laneWidth + laneWidth / 2;

    // Note circle
    ctx.fillStyle = "#52a876";
    ctx.strokeStyle = "#00a767";
    ctx.lineWidth = 3;

    ctx.beginPath();
    ctx.arc(x, y, CONFIG.NOTE_SIZE / 2, 0, Math.PI * 2);
    ctx.fill();
    ctx.stroke();

    // Key label on note
    ctx.fillStyle = "white";
    ctx.font = "bold 20px sans-serif";
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(CONFIG.NOTE_TO_KEY[note.note], x, y);
  });

  ctx.textAlign = "left";
  ctx.textBaseline = "alphabetic";
}

function drawKeyLabels() {
  const laneWidth = CONFIG.CANVAS_WIDTH / 7;
  const keys = ['A', 'S', 'D', 'F', 'G', 'H', 'J'];

  ctx.font = "bold 18px sans-serif";
  ctx.textAlign = "center";

  for (let i = 0; i < 7; i++) {
    const x = i * laneWidth + laneWidth / 2;
    const y = CONFIG.CANVAS_HEIGHT - 30;

    // Key background
    ctx.fillStyle = "#123524";
    ctx.fillRect(x - 20, y - 15, 40, 30);

    // Key text
    ctx.fillStyle = "white";
    ctx.fillText(keys[i], x, y + 5);
  }

  ctx.textAlign = "left";
}
</script>
