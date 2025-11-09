---
layout: default
title: Home
---

<section class="hero-combined">
    <div class="hero-container">
        <div class="hero-image-section">
            <img src="/data/umang_potrait.jpeg" alt="Umang Sharma" class="hero-profile-image">
        </div>
        <div class="hero-text-section">
            <h1>Umang Sharma</h1>
            <p class="hero-subtitle">Software Developer</p>
            <p class="hero-description">I'm a Master's student at the University of Pennsylvania, specializing in Computer Science and Artificial Intelligence, with graduation expected in Spring 2026. I worked at ZS Associates, where I used Deep learning models such as DeepAR and TFT to predict market trends, forecast sales, and tackle supply challenges. I am passionate about solving real-world problems through technology, with a focus on machine learning, computer vision, and game analytics.</p>
        </div>
    </div>
    <div class="hero-buttons-wrapper">
        <div class="hero-buttons">
            <a href="#projects" class="btn-primary">View My Work</a>
            <a href="/data/Umang_CV_Final.pdf" target="_blank" class="btn-primary">Resume</a>
            <div class="contact-expandable">
                <a href="mailto:umangsharma.cs@gmail.com" class="btn-secondary btn-contact-main">Get In Touch</a>
                <div class="contact-icons">
                    <a href="https://github.com/umangSharmacs" target="_blank" class="contact-icon" aria-label="GitHub">
                        <img src="/icons/github.png" alt="GitHub">
                    </a>
                    <a href="mailto:umangsharma.cs@gmail.com" class="contact-icon" aria-label="Email">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
                        </svg>
                    </a>
                    <a href="https://www.linkedin.com/in/umangsharmacs/" target="_blank" class="contact-icon" aria-label="LinkedIn">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.79M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="projects" id="projects">
    <h2>Featured Projects</h2>
    <p class="section-subtitle">Some of my recent work showcasing different skills and technologies</p>
    
    <div class="carousel-container">
        <button class="carousel-arrow carousel-arrow-left" aria-label="Previous project">‹</button>
        
        <div class="carousel-wrapper">
            <div class="carousel-track">
                {% assign featured_projects = site.projects | where: "featured", true | sort: "date" | reverse %}
                {% assign slides_count = featured_projects.size | divided_by: 3.0 | ceil %}
                {% assign max_index = slides_count | minus: 1 %}
                
                {% for i in (0..max_index) %}
                    {% assign offset = i | times: 3 %}
                    {% assign slide_projects = featured_projects | offset: offset | limit: 3 %}
                    {% if slide_projects.size > 0 %}
                <div class="carousel-slide">
                    {% for project in slide_projects %}
                    <a href="{{ project.url }}" class="card-link">
                        <div class="project-card">
                            <h3>{{ project.title }}</h3>
                            <p class="project-subtitle">{{ project.technologies }}</p>
                        </div>
                    </a>
                    {% endfor %}
                </div>
                    {% endif %}
                {% endfor %}
            </div>
        </div>
        
        <button class="carousel-arrow carousel-arrow-right" aria-label="Next project">›</button>
    </div>
    
    <div class="carousel-dots">
        {% for i in (1..slides_count) %}
        <button class="carousel-dot {% if forloop.first %}active{% endif %}" aria-label="Go to slide {{ i }}"></button>
        {% endfor %}
    </div>
</section>

<section class="experience" id="experience">
    <h2>Work & Research Experience</h2>

    {% assign sorted_cards = site.cards | sort: "start_date" | reverse %}
    {% for card in sorted_cards %}
    <a href="/experience/{{ card.experience_slug }}/" class="card-link">
        <div class="experience-item">
            <div class="heading-with-icons">
                <h3>{{ card.title }}</h3>
                {% if card.github_link or card.paper_link or card.kaggle_link %}
                <div class="icons">
                    {% if card.github_link %}
                    <a href="{{ card.github_link }}" onclick="event.stopPropagation();">
                        <img src="/icons/github.png" alt="GitHub" class="icon">
                    </a>
                    {% endif %}
                    {% if card.kaggle_link %}
                    <a href="{{ card.kaggle_link }}" onclick="event.stopPropagation();">
                        <img src="/icons/kaggle-logo-transparent.svg" alt="Kaggle" class="icon">
                    </a>
                    {% endif %}
                    {% if card.paper_link %}
                    <a href="{{ card.paper_link }}" onclick="event.stopPropagation();">
                        <img src="/icons/pdf.png" alt="PDF" class="icon">
                    </a>
                    {% endif %}
                </div>
                {% endif %}
            </div>
            <p class="date">{{ card.start_date | date: "%B %Y" }} - {% if card.end_date == "Present" %}{{ card.end_date }}{% else %}{{ card.end_date | date: "%B %Y" }}{% endif %}</p>
            <p class="skills">Technologies: {{ card.technologies }}</p>
            <ul>
                {% for bullet in card.bullet_points %}
                <li>{{ bullet }}</li>
                {% endfor %}
            </ul>
        </div>
    </a>
    {% endfor %}
</section>
