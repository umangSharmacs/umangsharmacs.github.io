---
layout: invitation
title: Memories
permalink: /invitation/memories/
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

    /* Photo Gallery Styles */
    .section-description {
        text-align: center;
        color: var(--color-text-secondary);
        margin-bottom: 2rem;
    }

    .photo-gallery {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 2rem;
    }

    .photo-item {
        position: relative;
        aspect-ratio: 1;
        border-radius: 16px;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.3s;
        box-shadow: 0 4px 12px rgba(18, 53, 36, 0.15);
    }

    .photo-item:hover {
        transform: translateY(-5px) scale(1.02);
        box-shadow: 0 8px 24px rgba(18, 53, 36, 0.25);
    }

    .photo-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s;
    }

    .photo-item:hover img {
        transform: scale(1.1);
    }

    .empty-gallery {
        grid-column: 1 / -1;
        text-align: center;
        padding: 60px 20px;
        background: linear-gradient(135deg, #f5fdf8 0%, #edf9f1 100%);
        border-radius: 16px;
        border: 2px dashed var(--color-border-accent);
    }

    .empty-gallery p {
        color: var(--color-text-secondary);
        font-size: 1rem;
    }

    .empty-gallery code {
        background: rgba(18, 53, 36, 0.1);
        padding: 2px 8px;
        border-radius: 4px;
        font-size: 0.9rem;
        color: var(--color-primary);
    }

    /* Lightbox Styles */
    .lightbox {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.9);
        z-index: 2000;
        cursor: pointer;
        animation: fadeIn 0.3s;
    }

    .lightbox.active {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .lightbox-close {
        position: absolute;
        top: 20px;
        right: 30px;
        font-size: 3rem;
        color: white;
        cursor: pointer;
        transition: color 0.3s;
    }

    .lightbox-close:hover {
        color: var(--color-border-accent);
    }

    .lightbox-image {
        max-width: 90%;
        max-height: 80vh;
        object-fit: contain;
        border-radius: 8px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
    }

    .lightbox-caption {
        color: white;
        margin-top: 20px;
        font-size: 1.1rem;
        text-align: center;
        max-width: 80%;
    }

    .lightbox-arrow {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(10px);
        border: 2px solid rgba(255, 255, 255, 0.3);
        color: white;
        font-size: 3rem;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 2001;
    }

    .lightbox-arrow:hover {
        background: rgba(168, 213, 186, 0.3);
        border-color: var(--color-border-accent);
        transform: translateY(-50%) scale(1.1);
    }

    .lightbox-arrow-left {
        left: 30px;
    }

    .lightbox-arrow-right {
        right: 30px;
    }

    @media (max-width: 768px) {
        .lightbox-arrow {
            width: 45px;
            height: 45px;
            font-size: 2rem;
        }

        .lightbox-arrow-left {
            left: 15px;
        }

        .lightbox-arrow-right {
            right: 15px;
        }
    }
</style>

<div class="section-view">
    <h1><span class="material-symbols-outlined">photo_camera</span> Lord Ugg's Paintings</h1>
    

    <div class="photo-gallery" id="photoGallery">
        <!-- Photos will be loaded here -->
        <div class="empty-gallery">
            <p>No photos yet. Add images to <code>misc/invitation/memories/</code> folder.</p>
        </div>
    </div>

    <!-- Lightbox for full-size images -->
    <div class="lightbox" id="lightbox" onclick="closeLightbox()">
        <span class="lightbox-close">&times;</span>
        <button class="lightbox-arrow lightbox-arrow-left" onclick="event.stopPropagation(); previousPhoto();" aria-label="Previous photo">‹</button>
        <button class="lightbox-arrow lightbox-arrow-right" onclick="event.stopPropagation(); nextPhoto();" aria-label="Next photo">›</button>
        <img class="lightbox-image" id="lightboxImage" src="" alt="" onclick="event.stopPropagation();">
        <div class="lightbox-caption" id="lightboxCaption"></div>
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

        loadPhotoGallery();
    });

    // Photo Gallery - Automatically generated from misc/invitation/memories folder
    const photos = [
        {% assign image_files = site.static_files | where_exp: "file", "file.path contains '/misc/invitation/memories/'" %}
        {% for file in image_files %}
            {% assign extension = file.path | split: '.' | last | downcase %}
            {% if extension == 'jpg' or extension == 'jpeg' or extension == 'png' or extension == 'gif' or extension == 'webp' or extension == 'svg' %}
                {% assign filename = file.path | split: '/' | last | split: '.' | first %}
                {
                    src: '{{ file.path }}',
                    caption: '{{ filename | replace: "-", " " | replace: "_", " " | capitalize }}'
                }{% unless forloop.last %},{% endunless %}
            {% endif %}
        {% endfor %}
    ];

    function loadPhotoGallery() {
        const gallery = document.getElementById('photoGallery');

        if (photos.length === 0) {
            return; // Show empty state
        }

        // Clear empty state
        gallery.innerHTML = '';

        photos.forEach((photo, index) => {
            const photoItem = document.createElement('div');
            photoItem.className = 'photo-item';
            photoItem.onclick = () => openLightbox(index);

            const img = document.createElement('img');
            img.src = photo.src;
            img.alt = photo.caption || 'Memory';
            img.loading = 'lazy';

            photoItem.appendChild(img);
            gallery.appendChild(photoItem);
        });
    }

    let currentPhotoIndex = 0;

    function openLightbox(index) {
        if (photos.length === 0) return;

        currentPhotoIndex = index;
        const lightbox = document.getElementById('lightbox');
        const lightboxImage = document.getElementById('lightboxImage');
        const lightboxCaption = document.getElementById('lightboxCaption');

        lightbox.classList.add('active');
        updateLightboxImage();

        // Add keyboard navigation
        document.addEventListener('keydown', handleLightboxKeyboard);
    }

    function updateLightboxImage() {
        const lightboxImage = document.getElementById('lightboxImage');
        const lightboxCaption = document.getElementById('lightboxCaption');

        lightboxImage.src = photos[currentPhotoIndex].src;
        lightboxCaption.textContent = photos[currentPhotoIndex].caption || '';
    }

    function nextPhoto() {
        if (photos.length === 0) return;
        currentPhotoIndex = (currentPhotoIndex + 1) % photos.length;
        updateLightboxImage();
    }

    function previousPhoto() {
        if (photos.length === 0) return;
        currentPhotoIndex = (currentPhotoIndex - 1 + photos.length) % photos.length;
        updateLightboxImage();
    }

    function handleLightboxKeyboard(event) {
        if (event.key === 'ArrowRight') {
            event.preventDefault();
            nextPhoto();
        } else if (event.key === 'ArrowLeft') {
            event.preventDefault();
            previousPhoto();
        } else if (event.key === 'Escape') {
            event.preventDefault();
            closeLightbox();
        }
    }

    function closeLightbox() {
        const lightbox = document.getElementById('lightbox');
        lightbox.classList.remove('active');

        // Remove keyboard navigation
        document.removeEventListener('keydown', handleLightboxKeyboard);
    }
</script>
