---
layout: invitation
title: Games
permalink: /invitation/games/
---

<style>
    :root {
        /* Theme Colors */
        --color-primary: #123524;
        --color-secondary: #00a767;
        --color-accent: #eefdf4;
        --color-background: #e8f3f5;
        --color-white: #ffffff;
        --color-text-primary: #123524;
        --color-text-secondary: #4a5568;
        --color-text-muted: #718096;
        --color-border-accent: #a8d5ba;
    }

    .game-container {
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 20px;
    }

    .game-header {
        text-align: center;
        margin-bottom: 2rem;
    }

    .game-header h1 {
        font-family: 'Playfair Display', serif;
        font-size: 3rem;
        color: var(--color-primary);
        margin-bottom: 1rem;
    }

    .game-header p {
        font-size: 1.2rem;
        color: var(--color-text-secondary);
    }

    /* Game Wrapper */
    .game-wrapper {
        position: relative;
        width: 100%;
        height: calc(100vh - 200px);
        min-height: 600px;
        background: #000;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 8px 32px rgba(18, 53, 36, 0.3);
    }

    .game-wrapper iframe {
        width: 100%;
        height: 100%;
        border: none;
        display: block;
    }

    /* Loading Overlay */
    .loading-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, var(--color-primary) 0%, #0a1f16 100%);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        z-index: 10;
        transition: opacity 0.5s ease;
    }

    .loading-overlay.hidden {
        opacity: 0;
        pointer-events: none;
    }

    .loading-spinner {
        width: 60px;
        height: 60px;
        border: 4px solid rgba(238, 253, 244, 0.2);
        border-top-color: var(--color-accent);
        border-radius: 50%;
        animation: spin 1s linear infinite;
        margin-bottom: 1.5rem;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    .loading-text {
        color: var(--color-accent);
        font-size: 1.3rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .loading-hint {
        color: rgba(238, 253, 244, 0.7);
        font-size: 0.9rem;
        font-style: italic;
    }

    /* Error State */
    .error-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, #2d1b1b 0%, #1a0f0f 100%);
        display: none;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        z-index: 10;
        padding: 40px;
        text-align: center;
    }

    .error-overlay.visible {
        display: flex;
    }

    .error-icon {
        font-size: 4rem;
        margin-bottom: 1rem;
    }

    .error-text {
        color: #fed7d7;
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
    }

    .retry-button {
        background: linear-gradient(135deg, var(--color-secondary) 0%, #00875a 100%);
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 12px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
    }

    .retry-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 167, 103, 0.4);
    }

    /* Controls */
    .game-controls {
        display: flex;
        justify-content: center;
        gap: 1rem;
        margin-top: 1.5rem;
        flex-wrap: wrap;
    }

    .control-button {
        background: linear-gradient(135deg, var(--color-primary) 0%, #0a1f16 100%);
        color: var(--color-accent);
        border: 2px solid var(--color-border-accent);
        padding: 10px 24px;
        border-radius: 12px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .control-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(18, 53, 36, 0.3);
        background: linear-gradient(135deg, #0a1f16 0%, var(--color-primary) 100%);
    }

    .control-button svg {
        width: 20px;
        height: 20px;
        fill: currentColor;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .game-header h1 {
            font-size: 2rem;
        }

        .game-header p {
            font-size: 1rem;
        }

        .game-wrapper {
            height: calc(100vh - 250px);
            min-height: 400px;
        }

        .control-button {
            font-size: 0.9rem;
            padding: 8px 20px;
        }
    }

    @media (max-width: 480px) {
        .game-container {
            padding: 10px;
        }

        .game-wrapper {
            border-radius: 12px;
        }

        .game-header h1 {
            font-size: 1.5rem;
        }
    }
</style>

<div class="game-container">
    <div class="game-header">
        <h1>Elle and the Ice Caves</h1>
        <p>Enjoy the game!</p>
    </div>

    <div class="game-wrapper">
        <iframe
            id="gameFrame"
            src="/misc/invitation/elleATIC/export_test.html"
            allowfullscreen
            allow="autoplay; fullscreen; gamepad"
            onload="handleGameLoad()"
            onerror="handleGameError()">
        </iframe>

        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="loading-overlay">
            <div class="loading-spinner"></div>
            <div class="loading-text">Loading Game...</div>
            <div class="loading-hint">This may take a moment</div>
        </div>

        <!-- Error Overlay -->
        <div id="errorOverlay" class="error-overlay">
            <div class="error-icon">⚠️</div>
            <div class="error-text">Unable to load the game. Please try again.</div>
            <button class="retry-button" onclick="retryLoad()">Retry</button>
        </div>
    </div>

    <div class="game-controls">
        <button class="control-button" onclick="toggleFullscreen()">
            <svg viewBox="0 0 24 24">
                <path d="M7 14H5v5h5v-2H7v-3zm-2-4h2V7h3V5H5v5zm12 7h-3v2h5v-5h-2v3zM14 5v2h3v3h2V5h-5z"/>
            </svg>
            <span id="fullscreenText">Fullscreen</span>
        </button>
        <button class="control-button" onclick="reloadGame()">
            <svg viewBox="0 0 24 24">
                <path d="M17.65 6.35A7.958 7.958 0 0 0 12 4c-4.42 0-7.99 3.58-7.99 8s3.57 8 7.99 8c3.73 0 6.84-2.55 7.73-6h-2.08A5.99 5.99 0 0 1 12 18c-3.31 0-6-2.69-6-6s2.69-6 6-6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z"/>
            </svg>
            Reload
        </button>
    </div>
</div>

<script>
    let loadAttempts = 0;
    const MAX_ATTEMPTS = 3;

    function handleGameLoad() {
        setTimeout(() => {
            const loadingOverlay = document.getElementById('loadingOverlay');
            if (loadingOverlay) {
                loadingOverlay.classList.add('hidden');
            }
        }, 1500);
    }

    function handleGameError() {
        const loadingOverlay = document.getElementById('loadingOverlay');
        const errorOverlay = document.getElementById('errorOverlay');

        if (loadingOverlay) {
            loadingOverlay.style.display = 'none';
        }

        if (errorOverlay) {
            errorOverlay.classList.add('visible');
        }
    }

    function retryLoad() {
        if (loadAttempts >= MAX_ATTEMPTS) {
            alert('Unable to load game after multiple attempts. Please check your internet connection.');
            return;
        }

        loadAttempts++;

        const iframe = document.getElementById('gameFrame');
        const loadingOverlay = document.getElementById('loadingOverlay');
        const errorOverlay = document.getElementById('errorOverlay');

        if (errorOverlay) {
            errorOverlay.classList.remove('visible');
        }

        if (loadingOverlay) {
            loadingOverlay.classList.remove('hidden');
        }

        if (iframe) {
            iframe.src = iframe.src;
        }
    }

    function reloadGame() {
        const iframe = document.getElementById('gameFrame');
        const loadingOverlay = document.getElementById('loadingOverlay');

        if (loadingOverlay) {
            loadingOverlay.classList.remove('hidden');
        }

        if (iframe) {
            iframe.src = iframe.src;
        }
    }

    function toggleFullscreen() {
        const wrapper = document.querySelector('.game-wrapper');
        const fullscreenText = document.getElementById('fullscreenText');

        if (!document.fullscreenElement) {
            if (wrapper.requestFullscreen) {
                wrapper.requestFullscreen();
            } else if (wrapper.webkitRequestFullscreen) {
                wrapper.webkitRequestFullscreen();
            } else if (wrapper.msRequestFullscreen) {
                wrapper.msRequestFullscreen();
            }
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.webkitExitFullscreen) {
                document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            }
        }
    }

    // Update fullscreen button text
    document.addEventListener('fullscreenchange', function() {
        const fullscreenText = document.getElementById('fullscreenText');
        if (fullscreenText) {
            fullscreenText.textContent = document.fullscreenElement ? 'Exit Fullscreen' : 'Fullscreen';
        }
    });

    // Auto-hide loading overlay after timeout
    setTimeout(() => {
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay && !loadingOverlay.classList.contains('hidden')) {
            loadingOverlay.classList.add('hidden');
        }
    }, 10000);
</script>
