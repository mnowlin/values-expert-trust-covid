# Session Log — values-expert-trust-covid Project

Paper title: **"Core Values and Trust in Experts Before and After COVID-19"**

This log records what has been done in each working session. Update it at the end of each session.

---

## Project Overview

A panel study of how pre-pandemic core values shape trust in scientists and experts, and which values predicted *change* in that trust across COVID-19. The five values are egalitarian–individualist economic values, authoritarianism, religiosity, social distrust, and political inefficacy. Data: Democracy Fund VOTER Survey panel. Values are measured in 2011, 2016, and 2017; expert trust in Jul 2017 and Nov 2020; COVID mediators in Sep 2020. Analytic n = 2,544.

**Key files:**
- `values-expert-trust-covid.qmd` — main manuscript (renders to HTML, PDF, DOCX)
- `scripts/analysis.R` — data build, recodes, and manuscript objects, sourced by the manuscript
- `scripts/export-cited-refs.R` — pre-render step that trims the master `.bib` to cited keys
- `research-design/expert-trust-covid-design.md` — research design (RQs, hypotheses, identification, models, variables)
- `research-design/voter-measurement-pass.md` — measurement model behind the five value dimensions
- `data/voter_panel.csv` — VOTER panel data (not in git)
- `README.md` — project structure and reproduction instructions

---

## Session History

### Session 1 — 2026-10-01 (Project set-up)

- Project originated in the `02-ideas/00-ct-democracy` idea folder:
  - An inventory of VOTER Survey items related to cultural theory.
  - A measurement pass (EFA then CFA on the 2011→2016→2017 linked panel). It did **not** recover the four or five cultural-theory factors. It recovered five value dimensions: a bipolar egalitarian–individualist ECON factor, authoritarian child-rearing (AUTH), religiosity (RELIG), social distrust (DISTRUST), and political inefficacy (INEFF).
  - A research design applying those values to trust in experts across COVID-19.
- Moved `expert-trust-covid-design.md` from the idea folder to `research-design/`. Copied (not moved, because the idea folder still uses them) the VOTER panel data and codebook to `data/`, and the measurement-pass report to `research-design/`.
- Ran set-up from `project-files`:
  - Renamed `template.qmd` → `values-expert-trust-covid.qmd` and set the title.
  - Pointed the manuscript's setup chunk at `scripts/analysis.R`; the template referenced `manuscript-setup.R`.
  - Updated `_quarto.yaml` and `export-cited-refs.R` with the new qmd file name.
  - Rewrote README and LOG for this project.
  - Added `.gitignore` (`/data`, `/literature`, `nowlin-style-profile.md`, generated bib/csl, Quarto/R artifacts).
- Created `scripts/analysis.R`:
  - Builds the analytic panel (respondents in both the 2017 and Nov 2020 waves, n = 2,544).
  - Recodes the 26 value items, the expert-trust outcomes, the Sep 2020 COVID mediators and exposure items, the placebo/pre-trend outcomes, and the pre-COVID controls. Every recode is checked against the wave-specific codebook.
  - Creates `expert_change`, a weighted (`weight_allpanel_2020Nov`) table of % pro-expert in 2017 vs. 2020 by party. Republicans fell on "experts can help ordinary people understand science and health" (74.0% → 70.0%) while Democrats rose (90.6% → 94.6%). On the other two items, both parties became more pro-expert.
- Initialized `renv` and wrote the lockfile (R 4.6.0).
- Fixed the template's PDF build error (`\normalem` undefined) by adding `\usepackage{ulem}` to the PDF header; this is the same fix as in cue-WTP Session 1. HTML, PDF, and DOCX all render.
- **Open items:**
  - Confirm the definition of `weight_allpanel_2020Nov`. The codebook says "every prior wave," but all 2,544 have the weight while only 2,276 completed the 2018 wave.
  - Next analysis steps are listed at the end of `analysis.R` and in design §6.
