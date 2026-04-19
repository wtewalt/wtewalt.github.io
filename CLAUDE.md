# CLAUDE.md — Personal Profile Site

Read this file fully before writing any code. It is the authoritative reference for content, design decisions, and current implementation state.

---

## Goal

A polished single-page personal profile site for **William Tewalt** hosted on GitHub Pages (`https://wtewalt.github.io`). Purpose: get William hired into a senior leadership role in Data Engineering, Software Development, or Data. Professional, modern, technically credible.

---

## Deliverables

- `index.html` — single file at repo root, no build step, served by GitHub Pages
- `flake.nix` — Nix dev shell with a `serve` command (`python3 -m http.server 8080`)
- `skills.yaml` — source of truth for Skills tab data (see below)

No bundler, no npm, no build step. All JS inlined or loaded from CDN.

---

## Tech Stack

- **Chart.js** (`https://cdn.jsdelivr.net/npm/chart.js`) — single radar chart on Skills tab
- **CSS** — custom, no framework. CSS variables for theming.
- **HTML5** — semantic markup, vanilla JS only
- **No icon library** — inline SVG only (heroicons outline style)

---

## Site Structure

Four tabs toggled with vanilla JS (`switchTab(name)`), all sections rendered in DOM simultaneously:

1. **About Me** — default tab
2. **Work History** — employment timeline
3. **Projects** — 2-column card grid
4. **Skills** — radar chart + sub-skill bar charts

Tab state is not persisted. Page always opens on About Me.

---

## Theme System

**Two themes only**, toggled with a CSS toggle switch (☀ / ☾) in the nav bar. Dark is the default.

| Theme | Class on `<body>` | Description |
|---|---|---|
| Tokyo Night Day | `theme-light` | Light mode |
| Catppuccin Mocha | `theme-dark` | Dark mode (default) |

Persisted to `localStorage` under key `'dark'` (string `'true'`/`'false'`). Default dark: `localStorage.getItem('dark') !== 'false'`.

### CSS Variables

```css
:root, body.theme-light {
  --bg: #e1e2e7;
  --surface: #d5d6db;
  --border: #c4c5d0;
  --text: #3760bf;
  --text-muted: #6172b0;
  --accent: #2496fe;
  --bar-gradient: linear-gradient(to right, #b3e5fc, #0d47a1);
}
body.theme-dark {
  --bg: #1e1e2e;
  --surface: #313244;
  --border: #45475a;
  --text: #cdd6f4;
  --text-muted: #6c7086;
  --accent: #cba6f7;
  --bar-gradient: linear-gradient(to right, #89dceb, #cba6f7);
}
```

### JS — Critical ordering constraint

`setDark(localStorage.getItem('dark') !== 'false')` **must be called after all `let` chart variable declarations** to avoid a temporal dead zone ReferenceError. It is placed at the very end of the `<script>` block.

```js
function setDark(dark) {
  document.body.classList.toggle('theme-dark', dark);
  document.body.classList.toggle('theme-light', !dark);
  document.getElementById('toggle-track').classList.toggle('on', dark);
  localStorage.setItem('dark', dark);
  updateChartColors();
}
function toggleTheme() { setDark(!document.body.classList.contains('theme-dark')); }
// ... all chart let declarations and functions must come before this line:
setDark(localStorage.getItem('dark') !== 'false');
```

---

## Source Content

### Personal Info

| Field | Value |
|---|---|
| Name | William Tewalt |
| Location | Signal Mountain, Tennessee |
| Email | wtewalt@gmail.com |
| LinkedIn | linkedin.com/in/william-tewalt |
| GitHub | github.com/wtewalt |
| GitHub (work) | github.com/WilliamTewaltEPL |

Both GitHub accounts are displayed in the About Me tab. Phone number is intentionally omitted from the page.

### About Me Bio

Senior data and analytics leader with 10+ years of experience building production data infrastructure, ML systems, and AI-powered tools. Has led teams and initiatives spanning data engineering, data science, and full-stack software development across agency, startup, and enterprise environments. Builds things end-to-end: from Airflow pipelines and medallion architectures to recommendation systems, web apps, and LLM integrations. Currently targeting senior leadership roles in Data Engineering, Software Development, or DevOps.

### Currently Open To (callout box)

- Sr. Director / VP of Data Engineering
- Sr. Director / VP of Software Development
- Head of Data / Chief Data Officer
- Principal Data Engineer

### Work History (most recent first)

**EPL Digital + AttorneySync**
- Sr. Director of Data & Analytics — 2025–Present
- Director of Data & Analytics — 2020–2025
- Manage a team of experts across multiple data domains.
- Architected medallion data infrastructure; established IaC, version control, and system-as-code as core data strategy pillars
- Built custom ML-driven recommendation system optimizing ~$4M in annual advertising spend via automated bid/budget management leading to a 20% increase in ROI
- Launched a secure web app with cloud identity provider integration to expose internal ML/AI tools
- Built PII-safe proprietary data processing tools and internal APIs powering internally hosted ML/AI applications
- Consolidated siloed data into unified performance dashboards

**The Johnson Group**
- Director of Analytics — 2020
- Manager, Advanced Analytics — 2017–2020
- Built and orchestrated automated data pipelines with Python and Apache Airflow
- Developed media attribution models guiding optimization of millions in annual ad spend
- Designed and maintained PostgreSQL database as foundation for company-wide analytics
- Established scalable development guidelines enabling efficient cross-team support
- Built internal and client-facing dashboards for data visualization and performance reporting

**Bellhop**
- Data / Business Intelligence Analyst — 2016–2017
- Developed the statistical models core to operational efficiency and growth
- Analyzed census data in AWS Redshift to generate market expansion recommendations for C-suite
- Developed operational models used as the basis for platform gamification
- Built interactive geospatial visualizations for identifying market hotspots
- Designed company-wide dashboards delivering cross-functional performance insights

**UNUM**
- Data Analytics Consultant, Enterprise Audit — 2016
- Metrics and Reporting Analyst — 2014–2016
- Built models used for forecasting and risk scoring/clustering
- Identified instances of double-billing resulting in a recovery of over $500k
- Applied statistical methods, simulation, and data mining techniques to complex business questions
- Designed staffing projection and service delivery estimation methodology
- Automated interactive reports and dashboards supporting contact center operations

### Projects (2-column card grid, no duration badges)

Each card has: inline SVG icon, title, tag pills, description.

| Project | Icon | Tags | Description |
|---|---|---|---|
| Campaign Optimization | trending-up | Data Science | Self-hosted recommendation system automating bid and budget management across ~$4M annual ad spend; increased client ROAS by 20% |
| Data Pipelines | arrows swap | Data Engineering | Apache Airflow orchestration. Data from dozens of sources (CRMs, ad platforms, SFTP, APIs). Custom Python packaging and cloud infra |
| Data Management | database cylinders | Data Engineering | Medallion architecture across AWS Redshift, PostgreSQL, and BigQuery; implemented SQLMesh org-wide for data lineage and isolated dev/prod environments |
| Web App | computer-desktop | Software Engineering | Full-stack app in Django + React for hosting internal data science tools; integrated with internal and external APIs |
| AI Chat Interface | chat bubble | GenAI, Data Engineering | MCP-based tool enabling Claude AI to directly query and interact with internal database tables |
| Ad Generation | sparkles | GenAI, Data Engineering | LLM-driven generation of search ad copy using dynamic performance data; custom web UI with user-defined theme inputs |
| Geo-Targeting | map pin | Data Science, Data Engineering | Geospatial + Google Places API tool tracking business rankings across city subsections over time; cloud object storage for pipeline I/O |
| Timeo | clock | Open Source | Python package published on PyPI. Link: https://pypi.org/project/timeo/ |

---

## Skills Tab

### skills.yaml — Source of Truth

`skills.yaml` defines all skills data. When it changes, update `index.html` manually in three places:

1. **`skillsData.labels`** — array of top-level domain names (must match yaml keys exactly)
2. **`skillsData.scores`** — array of domain scores (same order as labels)
3. **Sub-skill bar HTML** — each `<div class="skill-group">` block: the `<h4>` heading and each `bar-item`'s label, bar width (`style="width:X0%"`), and score

### Current skills.yaml values

Domains and scores (order matches radar chart labels):
- Programming: 8
- Leadership: 9.5
- Data Engr.: 8.5
- Cloud: 8
- Data Science: 7.5
- AI: 7.5

### Radar Chart

- Single Chart.js radar, `max: 10`, `responsive: true`, no legend
- Max-width 560px, centered above the sub-skill bars
- Colors read from CSS variables via `getComputedStyle` — updates on theme toggle
- `hexToRgba()` helper converts `--accent` hex to rgba for `backgroundColor`

### Sub-skill Bars

- Pure CSS horizontal bars — **no Chart.js** for sub-skills
- 3-column grid (`.skills-grid`), 1-column on mobile (≤700px)
- No "Sub-skills" section header
- Each group: `<h4>` domain name (uppercase via CSS), then bar items
- Bar structure: label above, bar track + score to the right on same row
- Bar height: 8px; label font-size: 0.775rem; `margin-bottom: 0.35rem` per item
- Bar fill uses `--bar-gradient`; score displayed outside the bar

---

## Constraints

- No external fonts — system font stack: `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`
- No bundler, no build step, no npm
- No icon libraries — inline SVG only
- All JS in `index.html` or from CDN — no separate `.js` files
- `index.html` at repo root for GitHub Pages
- Do not invent or embellish resume content — use only what is in this file
- Do not include phone number on the page
