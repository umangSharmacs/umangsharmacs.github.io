---
layout: invitation
title: Writings
permalink: /invitation/writings/
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
        --color-text-primary: #123524;
        --color-text-secondary: #4a5568;
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

</style>

<div class="section-view">
    <h1><span class="material-symbols-outlined">edit_note</span> Writings</h1>
    <p>Writings section coming soon...</p>
</div>

<script>
    // Check authentication
    window.addEventListener('DOMContentLoaded', function() {
        if (sessionStorage.getItem('invitation_authenticated') !== 'true') {
            window.location.href = '/invitation/';
        }

        // Hide banner on section pages
        const banner = document.querySelector('.invitation-banner');
        if (banner) {
            banner.style.display = 'none';
        }
    });
</script>
