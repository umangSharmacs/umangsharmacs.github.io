---
layout: invitation
title: Hub
permalink: /invitation/hub/
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
        --color-text-secondary: #eefdf4;
        --color-text-muted: #718096;
        --color-border-accent: #a8d5ba;
    }

    .material-symbols-outlined {
        font-variation-settings:
        'FILL' 0,
        'wght' 400,
        'GRAD' 0,
        'opsz' 24
    }

    /* Hero Banner */
    .hub-banner {
        min-height: calc(100vh - 90px);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        padding: 0 5%;
        position: relative;
    }

    .hub-banner h1 {
        font-family: 'Playfair Display', serif;
        font-size: 5rem;
        font-weight: 700;
        color: var(--color-primary);
        margin-bottom: 1rem;
        letter-spacing: -0.02em;
        line-height: 1.2;
    }

    .hub-banner p {
        font-size: 2rem;
        color: var(--color-primary);
        font-weight: 400;
    }

    .scroll-down-btn {
        position: absolute;
        bottom: 40px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        flex-direction: column;
        align-items: center;
        text-decoration: none;
        color: var(--color-primary);
        cursor: pointer;
        transition: all 0.3s ease;
        animation: bounce 2s infinite;
    }

    .scroll-down-btn .material-symbols-outlined {
        font-size: 3rem;
    }

    .scroll-down-btn:hover {
        transform: translateX(-50%) translateY(5px);
        color: var(--color-secondary);
    }

    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% {
            transform: translateX(-50%) translateY(0);
        }
        40% {
            transform: translateX(-50%) translateY(-10px);
        }
        60% {
            transform: translateX(-50%) translateY(-5px);
        }
    }

    /* Hub Styles */
    .hub-view {
        padding: 20px;
        max-width: 1400px;
        margin: 0 auto;
    }

    .success-message {
        position: fixed;
        top: 100px;
        right: 20px;
        background: linear-gradient(135deg, #d4ede0 0%, #c8e6d3 100%);
        padding: 16px 20px;
        border-radius: 12px;
        text-align: left;
        max-width: 320px;
        box-shadow: 0 8px 24px rgba(18, 53, 36, 0.25);
        z-index: 1000;
        animation: slideIn 0.4s ease-out;
    }

    @keyframes slideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }

    .success-message.hidden {
        display: none;
    }

    .success-message h3 {
        color: var(--color-primary);
        margin-bottom: 0.3rem;
        font-size: 1rem;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .success-message p {
        color: #1a4a30;
        margin: 0;
        font-size: 0.9rem;
    }

    .close-notification {
        position: absolute;
        top: 8px;
        right: 8px;
        background: transparent;
        border: none;
        color: var(--color-primary);
        font-size: 1.3rem;
        cursor: pointer;
        width: 28px;
        height: 28px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        transition: all 0.2s;
        line-height: 1;
        padding: 0;
    }

    .close-notification:hover {
        background: rgba(18, 53, 36, 0.15);
        color: #1a4a30;
    }

    .hub-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 40px;
        margin-top: 2rem;
    }

    .hub-block {
        background: #174A5D;
        border-radius: 20px;
        padding: 20px 15px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        display: block;
    }

    .hub-block:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 32px rgba(18, 53, 36, 0.2);
        background: #174A5D;
    }

    .block-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
        filter: drop-shadow(0 2px 4px rgba(18, 53, 36, 0.2));
    }

    .block-icon .material-symbols-outlined {
        font-size: 3rem;
        color: #4D7B90;
    }

    .hub-block h3 {
        font-size: 1.3rem;
        color: white;
        margin-bottom: 0.5rem;
    }

    .hub-block p {
        color: white;
        font-size: 0.9rem;
        margin: 0;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .hub-banner h1 {
            font-size: 3.5rem;
        }

        .hub-banner p {
            font-size: 1.5rem;
        }
    }

    @media (max-width: 480px) {
        .hub-banner h1 {
            font-size: 2.5rem;
        }

        .hub-banner p {
            font-size: 1.2rem;
        }
    }
</style>

<!-- Hero Banner -->
<div class="hub-banner">
    <h1>Good girl.</h1>
    <p>You managed to get in</p>
    <a href="#hub-content" class="scroll-down-btn">
        <span class="material-symbols-outlined">keyboard_arrow_down</span>
    </a>
</div>

<div class="hub-view" id="hub-content">
    <!-- <div class="success-message" id="welcomeNotification">
        <button class="close-notification" onclick="closeNotification()" aria-label="Close notification">×</button>
        <h3>Hey Princess!</h3>
        <p>Choose a section to explore</p>
    </div> -->

    <div class="hub-grid">
        <a href="/invitation/music/" class="hub-block">
            <div class="block-icon"><span class="material-symbols-outlined">music_note</span></div>
            <h3>Music</h3>
            <p>My favorite tunes</p>
        </a>

        <a href="/invitation/memories/" class="hub-block">
            <div class="block-icon"><span class="material-symbols-outlined">photo_camera</span></div>
            <h3>Memories</h3>
            <p>Cherished moments</p>
        </a>

        <a href="/invitation/writings/" class="hub-block">
            <div class="block-icon"><span class="material-symbols-outlined">edit_note</span></div>
            <h3>Writings</h3>
            <p>Thoughts & stories</p>
        </a>

        <a href="/invitation/notes/" class="hub-block">
            <div class="block-icon"><span class="material-symbols-outlined">sticky_note_2</span></div>
            <h3>Notes</h3>
            <p>Quick thoughts</p>
        </a>

        <a href="/invitation/games/" class="hub-block">
            <div class="block-icon"><span class="material-symbols-outlined">stadia_controller</span></div>
            <h3>Games</h3>
            <p>Interactive fun</p>
        </a>

        <a href="/invitation/productivity/" class="hub-block">
            <div class="block-icon"><span class="material-symbols-outlined">eco</span></div>
            <h3>Productivity</h3>
            <p>Grow with focus</p>
        </a>
    </div>
</div>

<script>
    // Check authentication
    window.addEventListener('DOMContentLoaded', function() {
        if (sessionStorage.getItem('invitation_authenticated') !== 'true') {
            // Not authenticated, redirect to login
            window.location.href = '/invitation/';
        } else {
            // Start background thunderstorm audio after successful login (if not disabled)
            const musicDisabled = localStorage.getItem('invitation_disableBackgroundMusic') === 'true';

            if (!musicDisabled) {
                const backgroundAudio = new Audio('/misc/invitation/login_sounds/thunderstorm/masterandmargarita-rain-with-thunderstorm-420333.mp3');
                backgroundAudio.volume = 0.5; // 50% volume
                backgroundAudio.loop = true;
                backgroundAudio.play().catch(err => console.log('Background audio play failed:', err));
                console.log('Background thunderstorm audio started');
            } else {
                console.log('Background music disabled by user settings');
            }
        }
    });

    // Close notification
    // function closeNotification() {
    //     const notification = document.getElementById('welcomeNotification');
    //     if (notification) {
    //         notification.classList.add('hidden');
    //     }
    // }
</script>
