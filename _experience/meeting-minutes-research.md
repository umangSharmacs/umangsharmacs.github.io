---
layout: experience
title: Meeting Minutes Generation Research
start_date: 2021-09-01
end_date: 2021-09-30
technologies: TOPSIS, MCDA, BERT, T5, NLP
github_link: https://github.com/umangSharmacs/theTuringTestament
paper_link: https://www.isca-archive.org/automin_2021/sharma21_automin.html
---

## Overview

This research project, **The Turing TESTament**, was developed for the **AutoMin 2021 Shared Task** at INTERSPEECH. It introduced a **pipeline-based Multi-Criteria Decision Analysis (MCDA)** approach to generate readable and contextually accurate **meeting minutes from transcripts** using **TOPSIS**—a ranking algorithm typically used for decision-making problems.  

Unlike heavy pre-trained summarization systems such as BERT or T5, this system is **lightweight, training-free**, and flexible, using **feature engineering** and heuristic optimization to identify the most representative sentences.


## Key Contributions

- Designed a **TOPSIS-driven pipeline** analyzing over **2M data points** to summarize multiparty transcripts.  
- Achieved **128% higher performance efficiency** compared to BERT/T5 baselines.  
- Combined **linguistic features** (length, frequency, topics, entities, affirmations) with entropy-based feature weighting.  
- Implemented iterative **heuristic optimization** using ROUGE and METEOR for extractive summarization.


## Research Methodology

Each transcript sentence was scored across six engineered features and ranked via **TOPSIS**, which measured Euclidean distances from ideal solutions.  
Sentences were iteratively filtered to maximize a heuristic combining **ROUGE-1, ROUGE-2, ROUGE-L, and METEOR** metrics.  
This produced accurate, grammatically correct minutes with significantly lower computational cost.


## Technical Implementation

### TOPSIS Ranking System

The **Technique for Order of Preference by Similarity to Ideal Solution (TOPSIS)** was adapted for extractive summarization:

1. Compute the normalized feature matrix $r_{ij} = \dfrac{f_{ij}}{\sqrt{\sum f_{ij}^2}}$.  
2. Calculate **feature weights** $w_j$ using Shannon entropy.  
3. Derive **weighted normalized matrix** $v_{ij} = w_j \cdot r_{ij}$.  
4. Determine **Positive (PIS)** and **Negative Ideal Solutions (NIS)**, then compute Euclidean distances $S^+_i$ and $S^-_i$.  
5. Rank sentences by their TOPSIS score:  
   $$
   T_i = \dfrac{S^-_i}{S^+_i + S^-_i}
   $$
6. Iteratively optimize the selection by maximizing the heuristic function combining ROUGE-1, ROUGE-2, ROUGE-L, and METEOR.

This design enabled the system to flexibly generate summaries for varied meeting datasets (AMI, ICSI, and AutoMin) while maintaining computational efficiency.


### Model Comparison

To benchmark performance, the Turing TESTament pipeline was compared against **BERT**, **Pegasus**, and **T5** models using both **automatic metrics** and **human evaluations**:

| Model | ROUGE-1 | ROUGE-2 | ROUGE-L | METEOR |
|--------|----------|----------|----------|---------|
| **Turing TESTament** | 0.49 | 0.47 | 0.48 | 0.06 |
| BERT | 0.20 | 0.20 | 0.21 | 0.07 |
| Pegasus | 0.20 | 0.18 | 0.19 | 0.06 |
| T5 | 0.17 | 0.15 | 0.15 | 0.05 |

The system demonstrated superior transcript-based summarization, highlighting its strength in capturing meeting flow and adequacy despite lower fluency (expected from extractive summaries).


## Results

- **Automatic Evaluation:** ROUGE-1 = 0.157, ROUGE-2 = 0.046, ROUGE-L = 0.092 (comparable to average AutoMin submissions).  
- **Human Evaluation:** Adequacy = 2.75, Grammar = 2.79, Fluency = 2.21 (Likert 1–5 scale).  
- **Semantic Similarity Tasks (B & C):** Achieved accuracies of **41.1%** and **52.2%**, respectively, for predicting whether meeting summaries or transcripts matched.  

