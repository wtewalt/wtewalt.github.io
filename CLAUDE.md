# CLAUDE.md — Personal Profile Site

Read this file fully before writing any code. It contains all source content, design decisions, and a step-by-step implementation plan. Execute steps in order.

---

## Goal

Build a polished single-page personal profile site for **William Tewalt** hosted on GitHub Pages. The purpose is to get William hired into a senior leadership role in Data Engineering, Software Development, or Data. The site should feel professional, modern, and technically credible.

---

## Deliverables

- `index.html` — single file, no build step required, served directly by GitHub Pages
- `flake.nix` — Nix dev shell that serves the site locally (e.g., with `python3 -m http.server` or similar)

No bundler, no npm, no build step. All JS loaded from CDN or inlined.

---

## Tech Stack

- **Chart.js** (`https://cdn.jsdelivr.net/npm/chart.js`) — radar charts for skill domains
- **CSS** — custom, no framework. Use CSS variables for theming. No Tailwind, no Bootstrap.
- **HTML5** — semantic markup, `index.html` at repo root

---

## Site Structure

Three tabs, all rendered in the DOM simultaneously (no fetch needed), toggled with vanilla JS:

1. **About Me** — default/landing tab
2. **Work History** — employment timeline
3. **Skills** — radar charts per domain

---

## Design Requirements

- Light and dark mode toggle (CSS variables + vanilla JS, persisted to `localStorage`)
- Clean, minimal aesthetic — no excessive color, no gradients
- Profile photo (`self_pic.png`) displayed in the About Me tab
- Responsive: readable on mobile and desktop
- Tab navigation at the top, active tab highlighted
- No animations beyond simple CSS transitions on tab/theme toggle

### Color scheme (CSS variables)

```css
/* Light mode */
--bg: #f9f9f7;
--surface: #ffffff;
--border: #e0e0e0;
--text: #1a1a1a;
--text-muted: #666666;
--accent: #2c6fad;

/* Dark mode */
--bg: #111111;
--surface: #1e1e1e;
--border: #333333;
--text: #f0f0f0;
--text-muted: #999999;
--accent: #5b9bd5;
```

---

## Source Content

### Personal Info

| Field | Value |
|---|---|
| Name | William Tewalt |
| Location | Signal Mountain, Tennessee |
| Email | wtewalt@gmail.com |
| Phone | 301-991-4186 |
| LinkedIn | linkedin.com/in/william-tewalt |
| GitHub | github.com/wtewalt |
| GitHub (work) | github.com/WilliamTewaltEPL |

### About Me (compose from resume — do not copy verbatim)

William is a senior data and analytics leader with 10+ years of experience building production data infrastructure, ML systems, and AI-powered tools. He has led teams and initiatives spanning data engineering, data science, and full-stack software development across agency, startup, and enterprise environments. He builds things end-to-end: from Airflow pipelines and medallion architectures to recommendation systems, web apps, and LLM integrations. Currently targeting senior leadership roles in Data Engineering, Software Development, or Data.

### Skills

Radar chart data comes from `skills.yaml` in the repo root. Read that file at implementation time — do not hard-code the values here. The format is `domain: { skill: score }` where scores are out of 10. Each top-level key becomes its own radar chart.

Also surface these from the resume as text (not on radar charts — too many items):
- **Cloud & Infra**: AWS (Lambda, Redshift, S3), GCP (BigQuery, GCS), Docker, Terraform, CI/CD
- **Data Engineering**: Apache Airflow, SQLMesh, dbt, ETL/ELT, Medallion Architecture
- **Data Science & ML**: Recommendation Systems, Predictive Modeling, Media Attribution, NLP, Forecasting
- **AI & GenAI**: LLM Integration, Prompt Engineering, MCP Development
- **Databases**: PostgreSQL, AWS Redshift, Google BigQuery
- **Visualization**: Power BI, Tableau, Geospatial Visualization

### Work History (chronological, most recent first)

**EPL Digital + AttorneySync**
- Sr. Director of Data & Analytics — 2025–Present
- Director of Data & Analytics — 2020–2025
- Architected medallion data infrastructure; established IaC, version control, and system-as-code as core data strategy pillars
- Built custom ML-driven recommendation system optimizing ~$4M in annual advertising spend via automated bid/budget management (10% ROAS improvement)
- Built PII-safe proprietary data processing tools and internal APIs powering internally hosted ML/AI applications
- Launched a secure web app with cloud identity provider integration to expose internal ML/AI tools
- Used AWS Lambda for scheduled pipeline execution across AWS and GCP
- Consolidated siloed data into unified performance dashboards

**The Johnson Group**
- Director of Analytics — 2020
- Manager, Advanced Analytics — 2017–2020
- Built and orchestrated automated data pipelines in Python and Apache Airflow across all client accounts
- Developed media attribution models guiding optimization of millions in annual ad spend
- Designed and maintained PostgreSQL database as foundation for company-wide analytics
- Established scalable development guidelines enabling efficient cross-team support
- Built internal and client-facing dashboards for data visualization and performance reporting

**Bellhop**
- Data / Business Intelligence Analyst — 2016–2017
- Deployed order simulation methodology to AWS Lambda for financial goal modeling
- Integrated third-party APIs for digital campaign attribution data ingestion
- Analyzed census data in AWS Redshift to generate market expansion recommendations for C-suite
- Built interactive geospatial visualizations for identifying market hotspots
- Partnered with software engineers to design and deploy a platform gamification framework via AWS Lambda

**UNUM**
- Data Analytics Consultant, Enterprise Audit — 2016
- Metrics and Reporting Analyst — 2014–2016
- Built predictive models for forecasting, behavioral analysis, and risk scoring/clustering
- Applied statistical methods, simulation, and data mining techniques to complex business questions
- Designed staffing projection and service delivery estimation methodology
- Automated interactive reports and dashboards supporting contact center operations

### Projects (display as cards)

| Project | Tags | Duration | Description |
|---|---|---|---|
| Campaign Optimization | Data Science | 3 yr | Self-hosted recommendation system automating bid and budget management across ~$4M annual ad spend; increased client ROAS by 10% |
| Data Pipelines | Data Engineering | 5 yr | Apache Airflow orchestration ingesting data from dozens of sources (CRMs, ad platforms, SFTP, APIs); backed by custom Python packaging and cloud infra |
| Data Management | Data Engineering | 5 yr | Medallion architecture across AWS Redshift, PostgreSQL, and BigQuery; implemented SQLMesh org-wide for data lineage and isolated dev/prod environments |
| Web App | Software Engineering | 3 yr | Full-stack app in Django + Next.js for hosting internal data science tools; integrated with internal and external APIs |
| AI Chat Interface | GenAI · Data Engineering | 1 yr | MCP-based tool enabling Claude AI to directly query and interact with internal database tables |
| Ad Generation | GenAI · Data Engineering | 3 yr | LLM-driven generation of search ad copy using dynamic performance data; custom web UI with user-defined theme inputs |
| Geo-Targeting | Data Science · Data Engineering | 2 yr | Geospatial + Google Places API tool tracking business rankings across city subsections over time; cloud object storage for pipeline I/O |
| Timeo | Open Source | — | Python package published on PyPI |

---

## Implementation Plan

Execute each step fully before moving to the next.

### STEP-01 — HTML skeleton

Create `index.html` with:
- `<head>`: charset, viewport, title ("William Tewalt"), CDN link for Chart.js, inline `<style>` block (empty for now)
- `<body>` with vanilla JS handling tab state and dark mode
- Top nav bar: name/logo left, theme toggle button right
- Tab buttons: About Me, Work History, Skills — each sets `tab` signal on click
- Three `<section>` elements with `data-show` bound to the `tab` signal
- Footer with email and LinkedIn

Done when: page loads, tabs switch, no JS errors in console.

### STEP-02 — CSS (light + dark theme)

Fill the `<style>` block with:
- CSS variables for light mode (`:root`) and dark mode (`.dark` on `<body>`)
- Dark mode: `toggleDark()` adds/removes `.dark` class on `<body>`
- Base styles: body, fonts (system font stack), layout (max-width ~900px, centered)
- Nav bar styles
- Tab button styles with active state
- Section layout
- Responsive: single-column on mobile

Done when: light/dark toggle works; `localStorage` preference restored on page load.

### STEP-03 — About Me tab

Content:
- Profile photo (`self_pic.png`) — circular, ~120px, floated or flexed alongside intro text
- Name as `<h1>`, title as subtitle ("Sr. Director of Data & Analytics")
- Location, email (mailto link), LinkedIn, GitHub links with simple icons (use Unicode or inline SVG — no icon library)
- Bio paragraph (from About Me section above)
- A "Currently open to" callout box listing target roles

Done when: tab renders cleanly in both light and dark mode with photo.

### STEP-04 — Work History tab

Render as a vertical timeline:
- Each employer as a block with company name, title(s), and date range
- Bullet points for responsibilities (from Work History section above)
- If a person held multiple titles at one employer, show them stacked with their individual date ranges
- Project cards at the bottom of the tab (from Projects table above) — simple cards with title, tag pills, duration badge, and description

Done when: all employers and projects render, dates are correct, cards look clean.

### STEP-05 — Skills tab

Read `skills.yaml` and generate one radar chart per top-level domain key, displayed side by side (stacked on mobile). Each chart uses the skill names as labels and scores (out of 10) as values.

Each chart: Chart.js radar type, max scale 10, filled, uses accent color with 0.2 opacity fill and 1.0 border.

Below the charts: a grid of skill category pills from the resume (Cloud & Infra, Data Engineering, etc.) with the individual skills listed under each heading — text only, no scores.

Done when: both charts render correctly in light and dark mode (update Chart.js colors when theme toggles), skill pills display below.

### STEP-06 — Polish and Nix flake

- Audit all content for typos against source material
- Ensure dark/light transition is smooth (CSS `transition: background 0.2s, color 0.2s`)
- Ensure Chart.js legend and grid colors adapt to theme
- Check mobile layout on a narrow viewport
- Write `flake.nix` with a dev shell that runs `python3 -m http.server 8080` in the repo root when entering the shell (or provide a `serve` command)

Done when: `nix develop` drops into a shell with a `serve` command; site looks correct in both themes on desktop and mobile.

---

## Constraints

- No external fonts (use system font stack: `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`)
- No bundler, no build step, no npm
- All JS must be in `index.html` or loaded from CDN — no separate `.js` files
- `index.html` must be at repo root for GitHub Pages
- Do not invent or embellish resume content — use only what is in this file
- Do not include phone number on the page (keep it off the public web)
