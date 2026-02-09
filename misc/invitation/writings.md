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

    .section-description {
        text-align: center;
        color: var(--color-text-secondary);
        margin-bottom: 2rem;
        font-size: 1.1rem;
    }

    /* Writing Cards Grid */
    .writings-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 24px;
        margin-top: 2rem;
    }

    .writing-card {
        background: linear-gradient(135deg, #f5fdf8 0%, #edf9f1 100%);
        border: 2px solid var(--color-border-accent);
        border-radius: 16px;
        padding: 24px;
        cursor: pointer;
        transition: all 0.3s;
        box-shadow: 0 4px 12px rgba(18, 53, 36, 0.1);
        position: relative;
        overflow: hidden;
    }

    .writing-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 24px rgba(18, 53, 36, 0.2);
        border-color: var(--color-secondary);
    }

    .writing-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 4px;
        height: 100%;
        background: var(--color-secondary);
        transform: scaleY(0);
        transition: transform 0.3s;
    }

    .writing-card:hover::before {
        transform: scaleY(1);
    }

    .writing-card h3 {
        color: var(--color-primary);
        font-size: 1.5rem;
        margin-bottom: 0.75rem;
        font-family: 'Playfair Display', serif;
    }

    .writing-card .date {
        color: var(--color-text-muted);
        font-size: 0.85rem;
        margin-bottom: 1rem;
        font-style: italic;
    }

    .writing-card .preview {
        color: var(--color-text-secondary);
        line-height: 1.6;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .writing-card .read-more {
        color: var(--color-secondary);
        font-weight: 600;
        margin-top: 1rem;
        display: inline-block;
    }

    /* Empty State */
    .empty-writings {
        text-align: center;
        padding: 60px 20px;
        background: linear-gradient(135deg, #f5fdf8 0%, #edf9f1 100%);
        border-radius: 16px;
        border: 2px dashed var(--color-border-accent);
    }

    .empty-writings p {
        color: var(--color-text-secondary);
        font-size: 1rem;
    }

    /* Modal Styles */
    .writing-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        z-index: 2000;
        animation: fadeIn 0.3s;
        overflow-y: auto;
    }

    .writing-modal.active {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .modal-content {
        background: white;
        border-radius: 20px;
        max-width: 800px;
        width: 100%;
        max-height: 90vh;
        overflow-y: auto;
        padding: 40px;
        position: relative;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
        animation: slideUp 0.3s;
    }

    @keyframes slideUp {
        from {
            transform: translateY(30px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    .modal-close {
        position: absolute;
        top: 20px;
        right: 20px;
        font-size: 2rem;
        color: var(--color-text-muted);
        cursor: pointer;
        background: transparent;
        border: none;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
    }

    .modal-close:hover {
        background: rgba(18, 53, 36, 0.1);
        color: var(--color-primary);
    }

    .modal-content h2 {
        color: var(--color-primary);
        font-size: 2rem;
        margin-bottom: 0.5rem;
        font-family: 'Playfair Display', serif;
    }

    .modal-content .modal-date {
        color: var(--color-text-muted);
        font-size: 0.9rem;
        margin-bottom: 1.5rem;
        font-style: italic;
    }

    .modal-content .modal-body {
        color: var(--color-text-secondary);
        line-height: 1.8;
        font-size: 1.05rem;
    }

    .modal-content .modal-body p {
        margin-bottom: 1rem;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .writings-grid {
            grid-template-columns: 1fr;
        }

        .modal-content {
            padding: 30px 20px;
        }

        .modal-content h2 {
            font-size: 1.5rem;
        }
    }

</style>

<div class="section-view">
    <h1><span class="material-symbols-outlined">edit_note</span> Nosferatu's Musings</h1>

    <div class="writings-grid" id="writingsGrid">
        <!-- Writing cards will be loaded here -->
        <div class="empty-writings">
            <p>No writings yet. Start adding your thoughts...</p>
        </div>
    </div>

    <!-- Modal for full writing view -->
    <div class="writing-modal" id="writingModal">
        <div class="modal-content" onclick="event.stopPropagation();">
            <button class="modal-close" onclick="closeModal()" aria-label="Close">&times;</button>
            <h2 id="modalTitle"></h2>
            <div class="modal-date" id="modalDate"></div>
            <div class="modal-body" id="modalBody"></div>
        </div>
    </div>
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

        loadWritings();
    });

    // Sample writings data - Replace this with your actual writings
    const writings = [
        {
            id: 1,
            title: "The First One",
            date: "January 2025",
            preview: "She sits out in the patio,Under the glare of a white street light, Hidden.",
            content: `She sits out in the patio,
            Under the glare of a white street light,
            Hidden.
            
            The cold biting her hands,
            Her fingers clutching embers,
            Painful Relief
            I wonder, ponder,
            Words mix and tumble and evaporate,
            Gone in the wind. 
            I stare at the wooden ceiling,
            At the funny sign,
            At the illuminated wall behind her.
            I stare.
            Remnants of a white winter around us.
            Around her.
            I listen. I nod. I try to understand.
            I stare.
            Lost in her intricacies.
            If only I could stand and kiss her right now,
            If only sit beside her.
            Give her my warmth and take hers.
            The embers stop me
            And the thoughts float away in the wind.
            But she... she remains.`
        },
        {
            id: 2,
            title: "Rain 1",
            date: "December 2024",
            preview: "Listening to the sounds of rain outside my window...",
            content: `Listening to the sounds of rain outside my window,
            How lonely and beautiful,
            Dripping. Tip Tap tip.
            Shrouded in darkness
            Eyes closed
            The water flowing in me
            Hope the rain helps me sleep
            Hope it helps you sleep.
            Perhaps together, soonTM. `
        },
        {
            id: 3,
            title: "Library",
            date: "February, 2025",
            preview: "Sitting in the library, thinking...",
            content: `Sitting in the library, thinking
            Watching
            Winer leaves, surviving
            In the wind, rustling
            People, walking
            Cars, driving
            Thinking.
            My coffee, sipping
            It's too hot, fucking.
            Probably burnt my tongue..`
        },
        {
            id: 4,
            title: "High thoughts",
            date: "Evergreen",
            preview: "WEEEEEEEED...",
            content: `Grow up and put something up your ass like the rest of us. 
            
            Humour is not that serious. 
            
            Reasons you love her - debated High school musical while high. Fucking wifey material.`
        },
        {
            id: 5,
            title: "An ode to you",
            date: "January 2026",
            preview: "Wouldn't you like to know, lover girl...",
            content: `An ode to you

                        Loving you has made me realise, 
                        Why life is so wonderful. 
                        I thought i knew myself,
                        Knew that i was an atheist,
                        Knew that i didn't believe in fate,
                        Or destiny, 
                        Or magic. 
                        But you made me a believer, 
                        A devout. 
                        Yours. 
                        You made me believe that Goddesses exist. 
                        How else can i explain your being..
                        Your gentle, caring love. 
                        Your fierce thundering love. 
                        Your.. kind and warm eyes. 
                        Blue... 
                        My little blue... 

                        I'm utterly and irrevocably, 
                        Deeply and unconditionally, 
                        Fiercely and ravagely, 
                        Innocently and safely, 
                        In love with you.. 

                        Please don't get afraid.
                        I promise you i am my own man too. 
                        The one that you fell in love with. 
                        I contain multitudes. 
                        And now... 
                        My multitudes also contain you :) 

                        Please dont lose hope, 
                        For no love, 
                        However short 
                        Is wasted. 

                        Know that, 
                        No matter what, 
                        Theres another heart beating in this world,
                        Miles away perhaps 
                        Or .. i hope with all my being, right next to you,
                        A heart that beats with your love.. 
                        and a rejuvenated hope. 

                        I think I always knew, 
                        Your familiar presence,
                        My devotion and ... 
                        utter surrender 

                        I think i always knew, 
                        From the moment we met,
                        That i woild love you,
                        My little blue. `
        }



    ];

    function loadWritings() {
        const grid = document.getElementById('writingsGrid');

        if (writings.length === 0) {
            return; // Show empty state
        }

        // Clear empty state
        grid.innerHTML = '';

        writings.forEach(writing => {
            const card = document.createElement('div');
            card.className = 'writing-card';
            card.onclick = () => openWriting(writing.id);

            card.innerHTML = `
                <h3>${writing.title}</h3>
                <div class="date">${writing.date}</div>
                <div class="preview">${writing.preview}</div>
                <span class="read-more">Read more →</span>
            `;

            grid.appendChild(card);
        });
    }

    function openWriting(id) {
        const writing = writings.find(w => w.id === id);
        if (!writing) return;

        const modal = document.getElementById('writingModal');
        const modalTitle = document.getElementById('modalTitle');
        const modalDate = document.getElementById('modalDate');
        const modalBody = document.getElementById('modalBody');

        modalTitle.textContent = writing.title;
        modalDate.textContent = writing.date;

        // Convert content to HTML - preserve line breaks without excessive spacing
        // Replace newlines with <br> tags for poems
        const formattedContent = writing.content
            .split('\n')
            .map(line => line.trim())
            .filter(line => line !== '')
            .join('<br>');

        modalBody.innerHTML = `<p style="white-space: pre-line; line-height: 1.8;">${formattedContent}</p>`;

        modal.classList.add('active');

        // Close modal when clicking outside
        modal.onclick = closeModal;

        // Add keyboard support
        document.addEventListener('keydown', handleModalKeyboard);
    }

    function closeModal() {
        const modal = document.getElementById('writingModal');
        modal.classList.remove('active');
        modal.onclick = null;
        document.removeEventListener('keydown', handleModalKeyboard);
    }

    function handleModalKeyboard(event) {
        if (event.key === 'Escape') {
            event.preventDefault();
            closeModal();
        }
    }
</script>
