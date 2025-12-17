# Netflix Content Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

# 🎬 Netflix Data Analysis & ETL Pipeline

## 🚀 Project Overview
This project is a full-stack data analysis solution for the Netflix dataset. It moves beyond simple SQL queries by implementing a custom **Python ETL pipeline** to handle raw data inconsistencies (BOM encoding, ghost columns) that standard import tools failed to process. The analysis layer uses advanced SQL techniques to derive insights on content strategy, actor dominance, and release trends.

## 📂 Data Source
The dataset used for this project is sourced from **Kaggle**:
* **Dataset Name:** Netflix Movies and TV Shows
* **Author:** Shivam Bansal
* **Link:** [Netflix Movies and TV Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)

## 🏗️ Database Schema
The data is structured in a relational SQL table as follows:

```sql
CREATE TABLE netflix (
    show_id      VARCHAR(10) PRIMARY KEY,
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
