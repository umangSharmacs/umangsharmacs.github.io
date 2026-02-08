---
layout: invitation
title: Invitation
permalink: /invitation/
---

<style>
    :root {
        /* Theme Colors */
        --color-primary: #123524;
        --color-secondary: #00a767;
        --color-accent: #eefdf4;
        --color-background: #e8f3f5;
        --color-white: #ffffff;
        --color-border-accent: #a8d5ba;
        --color-error: #c85a54;
    }

    /* Solid Background */
    body {
        background: #F0FCF5;
        min-height: 100vh;
        position: relative;
    }

    body::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(255, 255, 255, 0.1);
        z-index: -1;
    }

    /* Hide banner and nav during login */
    body:has(#loginForm:not([style*="display: none"])) nav,
    body:has(#loginForm:not([style*="display: none"])) .invitation-banner {
        display: none !important;
    }

    .invitation-container {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        max-width: 500px;
        width: 90%;
        padding: 40px;
        background: #123524;
        backdrop-filter: blur(8px) saturate(180%);
        -webkit-backdrop-filter: blur(8px) saturate(180%);
        border-radius: 25px;
        box-shadow:
            0 8px 32px rgba(0, 0, 0, 0.4),
            inset 0 1px 0 rgba(255, 255, 255, 0.3),
            inset 0 -1px 0 rgba(255, 255, 255, 0.1);
        transition: top 0.3s ease-out, left 0.3s ease-out;
    }

    .login-form {
        text-align: center;
    }

    .login-form h1 {
        font-family: "Jacquard 24", system-ui;
        font-size: 5rem;
        margin-bottom: 2rem;
        color: #F0FCF5;
        font-weight: 400;
    }

    .password-input {
        width: 100%;
        padding: 12px 16px;
        border: none;
        border-radius: 25px;
        font-size: 1rem;
        margin-bottom: 0;
        transition: all 0.3s;
        background: var(--color-white);
        opacity: 1;
        font-family: "Quintessential", serif;
        cursor: text;
        color: #123524;
    }

    .password-input.game-active {
        opacity: 0;
        pointer-events: none;
        height: 0;
        padding: 0;
        margin: 0;
        overflow: hidden;
    }

    .password-input:focus {
        outline: none;
    }

    .submit-btn {
        display: none;
    }

    .error-message {
        color: #F0FCF5;
        margin-top: 1rem;
        font-size: 0.9rem;
        font-family: "Jacquard 24", system-ui;
        display: none;
    }

    .error-message.show {
        display: block;
    }

    .game-dialogue {
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
        height: 15vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        background: #123524;
        color: #F0FCF5;
        font-family: "Quintessential", serif;
        font-size: 1.2rem;
        opacity: 0;
        transition: opacity 0.5s ease;
        z-index: 2000;
        box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.5);
        text-align: center;
    }

    .game-dialogue.show {
        opacity: 1;
    }

    .timer-box {
        position: fixed;
        top: 20%;
        left: 50%;
        transform: translate(-50%, -50%);
        padding: 15px 30px;
        background: rgba(200, 90, 84, 0.95);
        color: var(--color-white);
        border-radius: 12px;
        font-family: "Jacquard 24", system-ui;
        font-size: 1.5rem;
        opacity: 0;
        transition: opacity 0.5s ease, top 0.3s ease-out, left 0.3s ease-out;
        z-index: 2001;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        pointer-events: none;
    }

    .timer-box.show {
        opacity: 1;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
        20%, 40%, 60%, 80% { transform: translateX(10px); }
    }

    .password-input.shake {
        animation: shake 0.5s;
    }
</style>

<div class="invitation-container" id="loginForm">
    <form class="login-form" onsubmit="checkPassword(event)">
        <h1>Welcome</h1>
        <input
            type="text"
            id="passwordInput"
            class="password-input"
            placeholder="Enter password"
            autocomplete="off"
        >
        <p class="error-message" id="errorMessage">Incorrect password. Please try again.</p>
    </form>
</div>

<div class="game-dialogue" id="gameDialogue"></div>
<div class="timer-box" id="timerBox"></div>

<script>
    // Store password hash (SHA-256 of "princess")
    const PASSWORD_HASH = '04e77bf8f95cb3e1a36a59d1e93857c411930db646b46c218a0352e432023cf2';

    // Track if this is the first password attempt
    let isFirstAttempt = true;
    let hintsDialogues = [];

    async function hashPassword(password) {
        const msgBuffer = new TextEncoder().encode(password);
        const hashBuffer = await crypto.subtle.digest('SHA-256', msgBuffer);
        const hashArray = Array.from(new Uint8Array(hashBuffer));
        const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
        return hashHex;
    }

    // Load hints from file
    async function loadHints() {
        try {
            const response = await fetch('/misc/invitation/login-hints.md');
            const text = await response.text();
            const lines = text.split('\n');
            for (let line of lines) {
                line = line.trim();
                if (line !== '' && !line.startsWith('#')) {
                    hintsDialogues.push(line);
                }
            }
            console.log('Loaded', hintsDialogues.length, 'hints');
        } catch (error) {
            console.error('Failed to load hints:', error);
            hintsDialogues = ['Wrong password. Please try again.'];
        }
    }

    // Show message in game dialogue box
    function showLoginMessage(message, duration = 3000) {
        const dialogue = document.getElementById('gameDialogue');
        dialogue.textContent = message;
        dialogue.classList.add('show');

        setTimeout(() => {
            dialogue.classList.remove('show');
        }, duration);
    }

    // Get random hint
    function getRandomHint() {
        if (hintsDialogues.length > 0) {
            const randomIndex = Math.floor(Math.random() * hintsDialogues.length);
            return hintsDialogues[randomIndex];
        }
        return 'Wrong password. Please try again.';
    }

    async function checkPassword(event) {
        event.preventDefault();

        const input = document.getElementById('passwordInput');

        // FIRST ATTEMPT MISDIRECTION (always, even if correct)
        if (isFirstAttempt) {
            isFirstAttempt = false;
            input.value = '';
            showLoginMessage('I love messing with you', 3000);
            setTimeout(() => input.focus(), 3500);
            return;
        }

        // SUBSEQUENT ATTEMPTS - Validate password
        const enteredHash = await hashPassword(input.value);

        if (enteredHash === PASSWORD_HASH) {
            // Correct password
            sessionStorage.setItem('invitation_authenticated', 'true');
            window.location.href = '/invitation/hub/';
        } else {
            // Wrong password - shake field and show hint
            input.value = '';
            input.classList.add('shake');
            setTimeout(() => input.classList.remove('shake'), 500);

            const hint = getRandomHint();
            showLoginMessage(hint, 3000);

            setTimeout(() => input.focus(), 3500);
        }
    }

    // Check if already authenticated and load hints
    window.addEventListener('DOMContentLoaded', async function() {
        if (sessionStorage.getItem('invitation_authenticated') === 'true') {
            // Already authenticated, redirect to hub
            window.location.href = '/invitation/hub/';
        } else {
            // Load hints for login attempts
            await loadHints();
        }
    });

    // ========== MINI-GAME: MOUSE EVASION ==========
    (function() {
        console.log('Game IIFE started');

        // Check if password game is disabled in settings
        const passwordGameDisabled = localStorage.getItem('invitation_disablePasswordGame') === 'true';
        if (passwordGameDisabled) {
            console.log('Game disabled: User settings');
            return;
        }

        // Check if mobile/touch device - disable game on mobile
        const isMobile = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
        console.log('Mobile detection:', isMobile, 'ontouchstart:', 'ontouchstart' in window, 'maxTouchPoints:', navigator.maxTouchPoints);

        if (isMobile) {
            console.log('Game disabled: Mobile device detected');
            return;
        }
        console.log('Mouse evasion game initialized');

        // Configuration
        const CONFIG = {
            detectionRadius: 400,    // Distance to trigger evasion (smaller = harder)
            moveDistance: 400,       // How far to move (bigger = harder to catch)
            gameDuration: 60000,     // 60 seconds in ms
            boundaryPadding: 50,     // Keep container away from edges
            movesTriggerDialogue: 2, // Show dialogue after 2nd move
            messageInterval: 2000,   // Update message every 3s
            timerDetectionRadius: 200, // Distance to trigger timer evasion
            timerMoveDistance: 300   // How far timer moves
        };

        // Game state
        let gameActive = true;
        let moveCount = 0;
        let dialogueVisible = false;
        let startTime = null;
        let gameStarted = false;
        let messageUpdater = null;
        let lastMoveTime = 0;
        let moveCooldown = 500; // Minimum 500ms between moves
        let currentTypewriterTimeout = null; // Track current typing animation
        let isTyping = false; // Track if typewriter is currently active
        let currentChoiceIndex = 0; // Track which choice group we're on
        let lingerTimeout = null; // Track linger period after typing
        let timerVisible = false; // Track if timer box is visible
        let timerUpdateInterval = null; // Track timer update interval
        let lastTimerMoveTime = 0; // Track last timer move

        // Sound effects
        const SOUNDS = {
            typing: [
                '/misc/invitation/login_sounds/typing/typing.mp3'
            ],
            blink: [
                '/misc/invitation/login_sounds/blink/dragon-studio-cartoon-blinking-372481.mp3'
            ],
            thunderstorm: [
                '/misc/invitation/login_sounds/thunderstorm/masterandmargarita-rain-with-thunderstorm-420333.mp3'
            ]
        };

        let typingAudio = null; // Track typing audio for looping
        let backgroundAudio = null; // Track background thunderstorm audio

        // Play random sound from a category
        function playSound(category, loop = false) {
            const sounds = SOUNDS[category];
            if (!sounds || sounds.length === 0) return null;

            const randomSound = sounds[Math.floor(Math.random() * sounds.length)];
            const audio = new Audio(randomSound);
            audio.volume = 0.3; // Set volume to 30%

            if (loop) {
                audio.loop = true;
            }

            audio.play().catch(err => console.log('Audio play failed:', err));
            return audio;
        }

        // Stop audio
        function stopSound(audio) {
            if (audio) {
                audio.pause();
                audio.currentTime = 0;
            }
        }

        // Elements
        const container = document.getElementById('loginForm');
        const dialogue = document.getElementById('gameDialogue');
        const passwordInput = document.getElementById('passwordInput');
        const timerBox = document.getElementById('timerBox');

        console.log('Elements found:', {container: !!container, dialogue: !!dialogue, passwordInput: !!passwordInput});

        // Dialogue choices will be loaded from file
        let dialogueChoices = [];
        let allMessages = [];

        // Get container center position
        function getContainerCenter() {
            const rect = container.getBoundingClientRect();
            return {
                x: rect.left + rect.width / 2,
                y: rect.top + rect.height / 2
            };
        }

        // Calculate distance between two points
        function distance(x1, y1, x2, y2) {
            return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
        }

        // Load dialogue from file
        async function loadDialogues() {
            try {
                const response = await fetch('/misc/invitation/game-dialogues.md');
                const text = await response.text();

                // Parse the file - one message per line format only
                const lines = text.split('\n');
                let currentChoiceMessages = [];

                for (let i = 0; i < lines.length; i++) {
                    const line = lines[i].trim();

                    if (line.startsWith('#Choice')) {
                        // Save previous choice if it exists
                        if (currentChoiceMessages.length > 0) {
                            dialogueChoices.push(currentChoiceMessages);
                            allMessages.push(...currentChoiceMessages);
                            currentChoiceMessages = [];
                        }
                    } else if (line !== '' && !line.startsWith('#')) {
                        // Each line is a single message
                        currentChoiceMessages.push(line);
                    }
                }

                // Don't forget the last choice
                if (currentChoiceMessages.length > 0) {
                    dialogueChoices.push(currentChoiceMessages);
                    allMessages.push(...currentChoiceMessages);
                }

                console.log('Loaded', dialogueChoices.length, 'dialogue choices with', allMessages.length, 'total messages');
                console.log('Sample messages:', allMessages.slice(0, 5));
            } catch (error) {
                console.error('Failed to load dialogues:', error);
                // Fallback messages
                allMessages = ['Keep trying!', 'So close!', 'Catch me if you can!', 'Nice try!'];
            }
        }

        // Get message from current choice (sequential selection)
        function getRandomMessage() {
            if (dialogueChoices.length === 0) {
                return allMessages[Math.floor(Math.random() * allMessages.length)];
            }

            // Get current choice group
            const choice = dialogueChoices[currentChoiceIndex];
            // Pick a random message from that choice
            const message = choice[Math.floor(Math.random() * choice.length)];

            // Check if we just finished Choice 6 (0-indexed, so index 5)
            if (currentChoiceIndex === 5 && !timerVisible) {
                // Show timer after this message is typed
                showTimer();
            }

            // Move to next choice for next time, but stop at Choice 6
            currentChoiceIndex = Math.min(currentChoiceIndex + 1, dialogueChoices.length - 1);

            console.log('Selected from Choice', currentChoiceIndex + 1, ':', message);

            return message;
        }

        // Typewriter effect for dialogue
        function typewriterEffect(text, element, speed = 100) {
            // Clear any existing typewriter animation and linger timeout
            if (currentTypewriterTimeout) {
                clearTimeout(currentTypewriterTimeout);
                currentTypewriterTimeout = null;
            }
            if (lingerTimeout) {
                clearTimeout(lingerTimeout);
                lingerTimeout = null;
            }

            // Stop any existing typing sound
            stopSound(typingAudio);

            isTyping = true;
            element.textContent = '';
            let charIndex = 0;

            // Start typing sound (looped)
            typingAudio = playSound('typing', true);

            function typeNextChar() {
                if (charIndex < text.length && dialogueVisible && gameActive) {
                    element.textContent += text.charAt(charIndex);
                    charIndex++;
                    currentTypewriterTimeout = setTimeout(typeNextChar, speed);
                } else {
                    // Typing finished - stop typing sound and set linger period (5 seconds)
                    stopSound(typingAudio);
                    isTyping = false;
                    console.log('Typing finished, starting 5s linger period');
                    lingerTimeout = setTimeout(() => {
                        console.log('Linger period ended, ready for next message');
                        lingerTimeout = null;
                    }, 5000);
                }
            }

            typeNextChar();
        }

        // Move container away from mouse
        function evadeContainer(mouseX, mouseY) {
            const center = getContainerCenter();
            const dist = distance(mouseX, mouseY, center.x, center.y);

            // Debug current state every few frames
            if (Math.random() < 0.05) { // Log 5% of the time to avoid spam
                console.log('Distance to container:', dist.toFixed(0), 'Detection radius:', CONFIG.detectionRadius);
            }

            // Check cooldown
            const now = Date.now();
            const timeSinceLastMove = now - lastMoveTime;
            if (timeSinceLastMove < moveCooldown) {
                return; // Too soon after last move
            }

            if (dist < CONFIG.detectionRadius) {
                console.log('🎯 EVADING! Distance:', dist.toFixed(0), 'Move count:', moveCount + 1);
                lastMoveTime = now; // Update last move time

                // Visual feedback - flash border
                container.style.borderColor = 'red';
                setTimeout(() => { container.style.borderColor = ''; }, 200);

                // Calculate angle away from mouse
                const angle = Math.atan2(center.y - mouseY, center.x - mouseX);

                // Calculate new position with larger movement
                let newX = center.x + Math.cos(angle) * CONFIG.moveDistance;
                let newY = center.y + Math.sin(angle) * CONFIG.moveDistance;

                console.log('Before bounds check:', {newX: newX.toFixed(0), newY: newY.toFixed(0)});

                // Get viewport bounds
                const rect = container.getBoundingClientRect();
                const halfWidth = rect.width / 2;
                const halfHeight = rect.height / 2;
                const maxY = window.innerHeight * 0.85; // Top 85% only

                // Constrain to bounds
                newX = Math.max(halfWidth + CONFIG.boundaryPadding,
                               Math.min(window.innerWidth - halfWidth - CONFIG.boundaryPadding, newX));
                newY = Math.max(halfHeight + CONFIG.boundaryPadding,
                               Math.min(maxY - halfHeight - CONFIG.boundaryPadding, newY));

                // Snap to corners if close to edges (within 30% of width/height from edge)
                const cornerThresholdX = window.innerWidth * 0.3;
                const cornerThresholdY = maxY * 0.3;

                if (newX < cornerThresholdX) {
                    newX = halfWidth + CONFIG.boundaryPadding; // Snap to left edge
                } else if (newX > window.innerWidth - cornerThresholdX) {
                    newX = window.innerWidth - halfWidth - CONFIG.boundaryPadding; // Snap to right edge
                }

                if (newY < cornerThresholdY) {
                    newY = halfHeight + CONFIG.boundaryPadding; // Snap to top edge
                } else if (newY > maxY - cornerThresholdY) {
                    newY = maxY - halfHeight - CONFIG.boundaryPadding; // Snap to bottom edge
                }

                console.log('After bounds check & corner snap:', {newX: newX.toFixed(0), newY: newY.toFixed(0)});
                console.log('Viewport:', {width: window.innerWidth, height: window.innerHeight, maxY: maxY});

                // Apply new position
                container.style.left = newX + 'px';
                container.style.top = newY + 'px';
                container.style.transform = 'translate(-50%, -50%)';

                console.log('✅ Applied position. Container should be at:', {left: newX.toFixed(0), top: newY.toFixed(0)});

                // Increment move counter
                moveCount++;

                // Show dialogue after 2nd move
                if (moveCount === CONFIG.movesTriggerDialogue && !dialogueVisible) {
                    showDialogue();
                }
            }
        }

        // Get timer box center position
        function getTimerCenter() {
            const rect = timerBox.getBoundingClientRect();
            return {
                x: rect.left + rect.width / 2,
                y: rect.top + rect.height / 2
            };
        }

        // Move timer box away from mouse
        function evadeTimer(mouseX, mouseY) {
            if (!timerVisible) return;

            const center = getTimerCenter();
            const dist = distance(mouseX, mouseY, center.x, center.y);

            // Check cooldown
            const now = Date.now();
            const timeSinceLastMove = now - lastTimerMoveTime;
            if (timeSinceLastMove < moveCooldown) {
                return;
            }

            if (dist < CONFIG.timerDetectionRadius) {
                console.log('🎯 TIMER EVADING! Distance:', dist.toFixed(0));
                lastTimerMoveTime = now;

                // Calculate angle away from mouse
                const angle = Math.atan2(center.y - mouseY, center.x - mouseX);

                // Calculate new position
                let newX = center.x + Math.cos(angle) * CONFIG.timerMoveDistance;
                let newY = center.y + Math.sin(angle) * CONFIG.timerMoveDistance;

                // Constrain to viewport bounds - timer can move in top 85% too
                const rect = timerBox.getBoundingClientRect();
                const halfWidth = rect.width / 2;
                const halfHeight = rect.height / 2;
                const maxY = window.innerHeight * 0.85;

                newX = Math.max(halfWidth + CONFIG.boundaryPadding,
                               Math.min(window.innerWidth - halfWidth - CONFIG.boundaryPadding, newX));
                newY = Math.max(halfHeight + CONFIG.boundaryPadding,
                               Math.min(maxY - halfHeight - CONFIG.boundaryPadding, newY));

                // Apply new position
                timerBox.style.left = newX + 'px';
                timerBox.style.top = newY + 'px';
                timerBox.style.transform = 'translate(-50%, -50%)';

                console.log('✅ Timer moved to:', {left: newX.toFixed(0), top: newY.toFixed(0)});
            }
        }

        // Show timer box
        function showTimer() {
            timerVisible = true;
            timerBox.classList.add('show');
            console.log('Timer box activated!');

            // Play blink sound
            playSound('blink');

            // Update timer every 100ms
            timerUpdateInterval = setInterval(() => {
                if (gameActive && gameStarted && startTime) {
                    const elapsed = Date.now() - startTime;
                    const remaining = Math.max(0, CONFIG.gameDuration - elapsed);
                    const seconds = Math.ceil(remaining / 1000);
                    timerBox.textContent = `${seconds}s`;
                }
            }, 100);
        }

        // Show dialogue with countdown
        function showDialogue() {
            dialogueVisible = true;
            dialogue.classList.add('show');
            updateDialogueMessage();
        }

        // Update dialogue message
        function updateDialogueMessage() {
            // Don't update if not visible, game ended, still typing, or in linger period
            if (!dialogueVisible || !gameActive || isTyping || lingerTimeout) return;

            // Get message from current choice (sequential)
            const message = getRandomMessage();
            // Use typewriter effect (100ms per character for slower typing)
            typewriterEffect(message, dialogue, 100);
        }

        // End game
        function endGame() {
            gameActive = false;

            // Stop any playing sounds
            stopSound(typingAudio);

            // Clear any ongoing typewriter animation and linger timeout
            if (currentTypewriterTimeout) {
                clearTimeout(currentTypewriterTimeout);
                currentTypewriterTimeout = null;
            }
            if (lingerTimeout) {
                clearTimeout(lingerTimeout);
                lingerTimeout = null;
            }
            if (timerUpdateInterval) {
                clearInterval(timerUpdateInterval);
                timerUpdateInterval = null;
            }

            // Hide timer box
            if (timerVisible) {
                timerBox.classList.remove('show');
            }

            // Return container to center with smooth animation
            container.style.transition = 'top 1s ease, left 1s ease';
            container.style.left = '50%';
            container.style.top = '50%';

            // Show password field again
            passwordInput.classList.remove('game-active');

            // Keep the last dialogue visible (don't change or fade it out)
            // The last Choice 6 message will remain on screen

            // Remove mouse listener
            document.removeEventListener('mousemove', handleMouseMove);
        }

        // Handle mouse movement
        function handleMouseMove(e) {
            if (!gameActive) return;

            // Start timer on first mouse movement
            if (!gameStarted) {
                gameStarted = true;
                startTime = Date.now();
                console.log('Game started! Timer begins now.');

                // Hide password field during game
                passwordInput.classList.add('game-active');

                // Start the game timer
                setTimeout(() => {
                    if (messageUpdater) clearInterval(messageUpdater);
                    endGame();
                }, CONFIG.gameDuration);
            }

            evadeContainer(e.clientX, e.clientY);
            evadeTimer(e.clientX, e.clientY);
        }

        // Initialize game
        async function initGame() {
            // Load dialogues first
            await loadDialogues();

            // Start game
            document.addEventListener('mousemove', handleMouseMove);
            console.log('Mouse event listener added');

            // Update dialogue messages periodically
            messageUpdater = setInterval(() => {
                if (gameActive && dialogueVisible) {
                    updateDialogueMessage();
                }
            }, CONFIG.messageInterval);
            console.log('Message updater interval started');
        }

        // Start initialization
        initGame();
    })();
</script>
