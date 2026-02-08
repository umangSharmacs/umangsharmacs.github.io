---
layout: invitation
title: Notes
permalink: /invitation/notes/
---

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

    .section-view {
        padding: 20px;
        max-width: 900px;
        margin: 0 auto;
    }

    .section-view h1 {
        font-size: 2.5rem;
        color: var(--color-primary);
        margin-bottom: 1.5rem;
    }

</style>

<div class="section-view">
    <h1>📝 Notes</h1>
    <p>Notes section coming soon...</p>
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
