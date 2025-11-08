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
            <a href="mailto:umangsharma.cs@gmail.com" class="btn-secondary">Get In Touch</a>
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
                {% assign slides_count = featured_projects.size | divided_by: 4.0 | ceil %}
                
                {% for i in (0..slides_count) %}
                    {% assign offset = i | times: 4 %}
                    {% assign slide_projects = featured_projects | offset: offset | limit: 4 %}
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

    <a href="/projects/needlespotter-intern/" class="card-link">
        <div class="experience-item">
            <div class="heading-with-icons">
                <h3>AI and Data Systems Intern - NeedleSpotter Inc</h3>
                <div class="icons">
                    <a href="https://github.com/umangSharmacs/contentgen" onclick="event.stopPropagation();">
                        <img src="/icons/github.png" alt="GitHub" class="icon">
                    </a>
                </div>
            </div>
            <p class="date">June 2025 - August 2025</p>
            <p class="skills">Technologies: Javascript, PHP, Python, AI</p>
            <ul>
                <li>Built an interactive dashboard for editing AI-generated medical tweets.</li>
                <li>Developed RLHF pipelines, LLM fine-tuning loops, and GPT-based article rewriting tools tailored for clinical audiences.</li>
            </ul>
        </div>
    </a>

    <a href="/projects/upenn-research/" class="card-link">
        <div class="experience-item">
            <div class="heading-with-icons">
                <h3>Research Assistant - University of Pennsylvania</h3>
                <div class="icons">
                    <a href="https://www.kaggle.com/code/umangsharmacs/roberta-predictions-analysis" onclick="event.stopPropagation();">
                        <img src="/icons/kaggle-logo-transparent.svg" alt="Kaggle" class="icon">
                    </a>
                </div>
            </div>
            <p class="date">August 2024 - Present</p>
            <p class="skills">Technologies: RoBERTa, T5, Python, NLP, Machine Learning</p>
            <ul>
                <li>Email classification using RoBERTa, achieving 81% F1 score, and developed multi-class classification pipeline using T5.</li>
                <li>Automated classification for 200,000+ emails, enabling behavioral pattern analysis.</li>
            </ul>
        </div>
    </a>

    <a href="/projects/zs-associate/" class="card-link">
        <div class="experience-item">
            <div class="heading-with-icons">
                <h3>Decision Analytics Associate - ZS Associates</h3>
            </div>
            <p class="date">July 2022 - April 2024</p>
            <p class="skills">Technologies: Python, Deep Learning, TFT, DeepAR, LSTM, Tableau, Random Forest</p>
            <ul>
                <li>Led market analysis using Random Forest Classifiers, optimizing budgets by 15% and increasing sales by 20%.</li>
                <li>Developed Deep learning applications using TFT, DeepAR and LSTMs with 80% prediction accuracy.</li>
            </ul>
        </div>
    </a>

    <a href="/projects/zs-intern/" class="card-link">
        <div class="experience-item">
            <div class="heading-with-icons">
                <h3>Decision Analytics Associate Intern - ZS Associates</h3>
            </div>
            <p class="date">January 2022 - June 2022</p>
            <p class="skills">Technologies: Python, SQL, Tableau, Plotly, Bayesian Regression, ETL</p>
            <ul>
                <li>Implemented Bayesian Regression for market trend analysis, improving budget efficiency by 27%.</li>
                <li>Designed ETL pipelines reducing processing time by 30% and developed visualization dashboards.</li>
            </ul>
        </div>
    </a>

    <a href="/projects/meeting-minutes-research/" class="card-link">
        <div class="experience-item">
            <div class="heading-with-icons">
                <h3>Meeting Minutes Generation Research</h3>
                <div class="icons">
                    <a href="https://github.com/umangSharmacs/theTuringTestament" onclick="event.stopPropagation();">
                        <img src="/icons/github.png" alt="GitHub" class="icon">
                    </a>
                    <a href="https://www.isca-archive.org/automin_2021/sharma21_automin.html" onclick="event.stopPropagation();">
                        <img src="/icons/pdf.png" alt="PDF" class="icon">
                    </a>
                </div>
            </div>
            <p class="date">September 2021</p>
            <p class="skills">Technologies: TOPSIS, MCDA, BERT, T5, NLP</p>
            <ul>
                <li>Developed MCDA pipeline analyzing 2M+ data points for meeting minutes generation.</li>
                <li>Achieved 128% better performance than BERT and T5 models using TOPSIS ranking.</li>
            </ul>
        </div>
    </a>
</section>
