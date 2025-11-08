---
layout: default
title: Projects
permalink: /projects/
---

<style>
    body {
        background: #f8f9fa !important;
    }

    .projects-page {
        max-width: 1200px;
        margin: 0 auto;
        padding: 120px 20px 80px;
    }

    .projects-page h1 {
        font-size: 3rem;
        font-weight: 700;
        color: #1a1a1a;
        text-align: center;
        margin-bottom: 1rem;
    }

    .page-subtitle {
        text-align: center;
        color: #718096;
        font-size: 1.2rem;
        margin-bottom: 4rem;
        max-width: 800px;
        margin-left: auto;
        margin-right: auto;
    }

    .projects-list {
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    .project-card-wrapper {
        background: #ffffff;
        border-radius: 16px;
        padding: 40px;
        border: 1px solid #e2e8f0;
        transition: all 0.3s ease;
        position: relative;
    }

    .project-card-wrapper:hover {
        transform: translateY(-5px);
        border-color: #cbd5e0;
    }

    .project-card-link {
        text-decoration: none;
        color: inherit;
    }

    .project-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 15px;
    }

    .project-title {
        font-size: 1.6rem;
        font-weight: 700;
        color: #1a1a1a;
        margin: 0;
        flex: 1;
        padding-right: 20px;
    }

    .project-icons {
        display: flex;
        gap: 12px;
        flex-shrink: 0;
    }

    .project-icon-link {
        opacity: 0.6;
        transition: opacity 0.3s;
    }

    .project-icon-link:hover {
        opacity: 1;
    }

    .project-icon-link img {
        width: 24px;
        height: 24px;
        display: block;
    }

    .project-date {
        color: #718096;
        font-size: 0.95rem;
        font-style: italic;
        margin: 0 0 20px 0;
    }

    .project-description {
        color: #4a5568;
        line-height: 1.7;
        margin: 0 0 20px 0;
        font-size: 1rem;
    }

    .project-tech {
        color: #718096;
        font-size: 0.9rem;
        font-weight: 500;
        border-top: 1px solid #e2e8f0;
        padding-top: 15px;
        margin: 0;
    }

    @media (max-width: 768px) {
        .projects-page {
            padding: 100px 20px 60px;
        }

        .projects-page h1 {
            font-size: 2.2rem;
        }

        .project-card-wrapper {
            padding: 30px 25px;
        }

        .project-title {
            font-size: 1.3rem;
        }

        .project-header {
            flex-direction: column;
            gap: 15px;
        }

        .project-icons {
            align-self: flex-end;
        }
    }
</style>

<div class="projects-page">
    <h1>All Projects</h1>
    <p class="page-subtitle">A comprehensive collection of my work in AI, Machine Learning, and Data Science</p>

    <div class="projects-list">
        <div class="project-card-wrapper">
            <a href="/projects/Email_CRM_System/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Email CRM System</h3>
                </div>
                <p class="project-date">August 2025 - December 2025</p>
                <p class="project-description">Scalable B2B email outreach management platform with automated follow-up sequences and reply tracking. Reduced manual outreach management time by 90% with intelligent 4-stage email automation and response monitoring.</p>
                <p class="project-tech">React • PHP • n8n • RAG</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/chord/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">CHORD - Collaborative Healthcare Operations Research Dashboard</h3>
                    <div class="project-icons">
                        <a href="https://github.com/umangSharmacs/chord" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/github.png" alt="GitHub">
                        </a>
                    </div>
                </div>
                <p class="project-date">September 2024 - December 2024</p>
                <p class="project-description">Comprehensive analytics platform designed to optimize healthcare operations through data-driven insights and predictive modeling. Features real-time operational metrics, predictive analytics for patient flow, and resource allocation algorithms.</p>
                <p class="project-tech">Python • Flask • PostgreSQL • D3.js • React</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/autonomous-zooming-cameraman/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Autonomous Zooming Cameraman</h3>
                    <div class="project-icons">
                        <a href="https://github.com/VedantZope/CIS-5810---Auto-Zooming-Cameraman" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/github.png" alt="GitHub">
                        </a>
                        <a href="/data/Computer_Vision_Project_Final_Report_Group_30.pdf" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/pdf.png" alt="PDF">
                        </a>
                    </div>
                </div>
                <p class="project-date">August 2024 - December 2024</p>
                <p class="project-description">Developed YOLOv11 model for basketball detection with CSRT tracking for continuous 30-frame ball tracking. Created post-game analysis system with heatmap visualization and automated commentary using GPT-Vision API.</p>
                <p class="project-tech">YOLOv11 • CSRT • Computer Vision • OpenAI GPT-Vision API</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/irrigation-water-quality/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Irrigation Water Quality Classifier</h3>
                    <div class="project-icons">
                        <a href="https://github.com/umangSharmacs/capstone" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/github.png" alt="GitHub">
                        </a>
                    </div>
                </div>
                <p class="project-date">January 2021 - January 2022</p>
                <p class="project-description">Led development of novel dataset and Random Forest classifier achieving 83% accuracy. Enhanced model using randomized value correlation techniques and reinforced learning.</p>
                <p class="project-tech">Random Forest • Python • Machine Learning</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/needlespotter-intern/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">AI and Data Systems Intern - NeedleSpotter Inc</h3>
                    <div class="project-icons">
                        <a href="https://github.com/umangSharmacs/contentgen" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/github.png" alt="GitHub">
                        </a>
                    </div>
                </div>
                <p class="project-date">June 2025 - August 2025</p>
                <p class="project-description">Built an interactive dashboard for editing AI-generated medical tweets. Developed RLHF pipelines, LLM fine-tuning loops, and GPT-based article rewriting tools tailored for clinical audiences.</p>
                <p class="project-tech">Javascript • PHP • Python • AI</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/upenn-research/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Research Assistant - University of Pennsylvania</h3>
                    <div class="project-icons">
                        <a href="https://www.kaggle.com/code/umangsharmacs/roberta-predictions-analysis" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/kaggle-logo-transparent.svg" alt="Kaggle">
                        </a>
                    </div>
                </div>
                <p class="project-date">August 2024 - Present</p>
                <p class="project-description">Email classification using RoBERTa, achieving 81% F1 score, and developed multi-class classification pipeline using T5. Automated classification for 200,000+ emails, enabling behavioral pattern analysis.</p>
                <p class="project-tech">RoBERTa • T5 • Python • NLP • Machine Learning</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/zs-associate/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Decision Analytics Associate - ZS Associates</h3>
                </div>
                <p class="project-date">July 2022 - April 2024</p>
                <p class="project-description">Led market analysis using Random Forest Classifiers, optimizing budgets by 15% and increasing sales by 20%. Developed Deep learning applications using TFT, DeepAR and LSTMs with 80% prediction accuracy.</p>
                <p class="project-tech">Python • Deep Learning • TFT • DeepAR • LSTM • Tableau • Random Forest</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/zs-intern/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Decision Analytics Associate Intern - ZS Associates</h3>
                </div>
                <p class="project-date">January 2022 - June 2022</p>
                <p class="project-description">Implemented Bayesian Regression for market trend analysis, improving budget efficiency by 27%. Designed ETL pipelines reducing processing time by 30% and developed visualization dashboards.</p>
                <p class="project-tech">Python • SQL • Tableau • Plotly • Bayesian Regression • ETL</p>
            </a>
        </div>

        <div class="project-card-wrapper">
            <a href="/projects/meeting-minutes-research/" class="project-card-link">
                <div class="project-header">
                    <h3 class="project-title">Meeting Minutes Generation Research</h3>
                    <div class="project-icons">
                        <a href="https://github.com/umangSharmacs/theTuringTestament" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/github.png" alt="GitHub">
                        </a>
                        <a href="https://www.isca-archive.org/automin_2021/sharma21_automin.html" class="project-icon-link" onclick="event.stopPropagation();" target="_blank">
                            <img src="/icons/pdf.png" alt="PDF">
                        </a>
                    </div>
                </div>
                <p class="project-date">September 2021</p>
                <p class="project-description">Developed MCDA pipeline analyzing 2M+ data points for meeting minutes generation. Achieved 128% better performance than BERT and T5 models using TOPSIS ranking.</p>
                <p class="project-tech">TOPSIS • MCDA • BERT • T5 • NLP</p>
            </a>
        </div>
    </div>
</div>
