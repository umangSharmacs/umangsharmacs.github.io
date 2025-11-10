---
layout: project
title: Autonomous Zooming Cameraman
permalink: /projects/autonomous-zooming-cameraman/
date: August 2024 - December 2024
technologies: YOLOv11, CSRT, Computer Vision, OpenAI GPT-Vision API
featured: true
github_link: https://github.com/VedantZope/CIS-5810---Auto-Zooming-Cameraman
paper_link: /data/Computer_Vision_Project_Final_Report_Group_30.pdf
---

## Overview

Developed an **AI-powered autonomous camera system** capable of tracking basketball gameplay, automatically adjusting zoom and focus, and generating post-game commentary and analytics.  
The system combines **real-time object detection, temporal smoothing, and GPT-based commentary generation**, offering a cost-effective alternative to professional sports videography.


## Key Contributions

- Built a **YOLOv11 + CSRT tracking pipeline** to detect and track the basketball and players across frames, maintaining smooth 30-frame tracking.
- Implemented **temporal smoothing and Gaussian-based heatmaps** to reduce jitter and ensure seamless camera transitions.
- Designed an **interactive post-game analysis dashboard** with team heatmaps, possession stats, and frame-by-frame movement visualizations.
- Integrated **GPT-Vision API** to automatically generate contextual commentary and highlights with speech synthesis.


## Technical Architecture

The pipeline follows a **five-stage process**:
1. **YOLOv11 Detection** — Identifies and segments players, ball, and referees per frame.  
2. **Heatmap Generation** — Combines bounding boxes and applies Gaussian blur to highlight active regions.  
3. **Region of Interest (ROI) Selection** — Dynamically centers the camera on the highest-intensity areas.  
4. **Temporal Smoothing** — Uses a 30-frame rolling buffer to prevent abrupt zoom or camera motion.  
5. **Commentary Generation** — Processes every 11th frame via GPT-Vision for highlight summarization and converts text to audio commentary.


## Ball Detection and Tracking

### YOLOv11 Implementation
Fine-tuned **YOLOv11-m** on a labeled basketball dataset from Roboflow (classes: *basketball*, *made basket*).  
- **Epochs:** 100 | **Image Size:** 1280 | **Batch Size:** 4 | **Environment:** Kaggle (T4 GPU)  
This improved detection accuracy for small-scale basketball objects, significantly outperforming earlier 640×640 runs.

### CSRT Tracking
After detection, a **CSRT tracker** maintains object tracking for up to **30 frames** between detections, ensuring continuous following of the ball and preventing loss from motion blur or occlusion.

## Post-Game Analysis

### Heatmap Visualization
Generated player and team movement heatmaps via Gaussian blurring to visualize spatial dominance and strategic zones throughout gameplay.

### GPT-Vision API Integration
Summarized key highlights and play strategies from sampled frames using **OpenAI GPT-Vision**, creating natural-language commentary.  
The commentary was then converted to audio via **OpenAI TTS** and synced to the final match footage.

## Results and Performance

- Achieved **stable zooming and tracking** across 1080p/30 FPS videos with smooth transitions.  
- Fine-tuned YOLOv11 model demonstrated improved **precision-recall balance** at higher resolutions.  
- Post-game module delivered clear team possession analytics and trajectory visualizations.

## Challenges and Solutions

- **Issue:** Over-zooming or jittery transitions.  
  **Fix:** Implemented weighted temporal smoothing with dynamic buffer scaling.  
- **Issue:** Player clustering errors due to variable jersey colors.  
  **Fix:** Added **manual color calibration** in UI for flexible team identification.  
- **Issue:** High processing latency using SAM2 segmentation.  
  **Fix:** Switched to YOLOv11 for faster inference with minimal accuracy loss.

## Future Improvements

- Integrate **3D CNN or MMAction2** for player action recognition to improve event-based zooming.  
- Automate team color clustering and multi-view (split-screen) visualizations.  
- Enhance real-time inference using **parallelized processing** and **GPU-based pipelines** for live deployment.
