# Session Log — values-expert-trust-covid Project

Paper title: **"Core Values and Trust in Experts Before and After COVID-19"**

This log records what has been done in each working session. Update it at the end of each session.

---

## Project Overview

A panel study of how pre-pandemic core values and civic orientations shape trust in scientists and experts, and which of them predicted *change* in that trust across COVID-19. The three core values are economic egalitarianism–individualism (ECON), authoritarianism (AUTH) and religiosity (RELIG). The two civic orientations are social distrust (DISTRUST) and political inefficacy (INEFF). Data: Democracy Fund VOTER Survey panel. Values and civic orientations are measured in 2016 and 2017; expert trust in Jul 2017 and Nov 2020; COVID exposure in Sep and Nov 2020; COVID attitudes (outcomes of change in trust) in Nov 2020. No mediators. Analytic n = 2,544.

**Key files:**
- `values-expert-trust-covid.qmd` — main manuscript (renders to HTML, PDF, DOCX)
- `scripts/analysis.R` — data build, recodes, SEMs, tables, figures and inline numbers, sourced by the manuscript (model results cached in `output/model-results.rds`)
- `scripts/values-measurement-refit.R` — refit of the values measurement model without the gender-role and fatalism items
- `data/value-construct-items.md` — question wording and recodes for every model variable (not in git)
- `scripts/export-cited-refs.R` — pre-render step that trims the master `.bib` to cited keys
- `research-design/expert-trust-covid-design.md` — research design (RQs, hypotheses, identification, models, variables)
- `research-design/voter-measurement-pass.md` — measurement model behind the values and civic orientations (§7: trimmed refit)
- `data/voter_panel.csv` — VOTER panel data (not in git)
- `README.md` — project structure and reproduction instructions

---

## Session History

### Session 2 — 2026-10-01 (Measurement decisions, design revisions, first full analysis)

- **Item documentation.** Created `data/value-construct-items.md` (git-ignored with `/data`) with codebook wording and recodes for every model variable: core values, civic orientations, expert trust, CDC confidence, COVID exposure and Nov 2020 COVID attitudes.
- **Trimmed ECON.** Dropped the two gender-role items (`sexism_roles_2016`, `class_manlymen_2017`) and `fatalism2_2011`; ECON is now 12 economic items. New `scripts/values-measurement-refit.R` reproduces the measurement-pass half-B split (checks the published M6 χ² = 4,016 on 291 df) and refits: χ² = 2,457 (222), scaled CFI .981, RMSEA .063; robust RMSEA unchanged (≈ .11). Added as §7 of the measurement-pass report. Values now come only from 2016–2017.
- **Construct framing.**
  - ECON kept as one bipolar measure: latent r(E, I) = −.94 in the analytic panel. Separate E and I models are a planned robustness check.
  - DISTRUST and INEFF reclassified as *civic orientations* (beliefs about how things are), separate from the core values (how society ought to be organized), with their own hypotheses (H-DIST, H-INEFF).
  - Party ID and ideology are political identity, entered as Block 2.
  - Dropped the cultural-theory framing from the design and item documents. Renamed variable prefixes (`h_`/`fw_` → `auth_`, `relig_`, `dist_`, `ineff_`).
- **No mediators.** Restriction attitudes excluded as endogenous to expert trust; Trump COVID approval and concern no longer mediators. COVID is the period between waves; attribution rests on specificity, pre-trends and exposure. Added RQ5 (consequences): latent change in expert trust → Nov 2020 Trump and governor COVID approval and `covid_endrestrictions`. Exposure = circles with a case in Sep *or* Nov 2020.
- **Analysis** (all in `analysis.R`; lavaan WLSMV, theta, latent values and expert trust, conditional covariates, unweighted):
  - Expert trust is invariant across waves (thresholds, loadings, intercepts; CFI .998, RMSEA .034). Mean latent change +0.32 SD; SD grows to 1.28.
  - ECON is the main predictor of change: +0.33 SD per SD (Block 1), +0.17 with party and ideology. Religiosity small positive in latent change only. AUTH, DISTRUST, INEFF null for change. Party negative (−0.09).
  - Specificity: ECON effects larger for expert items (β .38–.52) than for federal government (.23) and other institutions (negative/null). **But ECON predicts media-trust change about equally before (Jan–Nov 2019, .35) and during the pandemic (.41)**, so part of the divergence likely predates COVID.
  - Exposure: ECON effect smaller among exposed (.34 vs .58, p = .059); religiosity positive only among exposed (p = .015).
  - Consequences: decline in trust → more Trump COVID approval (β −.20); gain → more governor approval (.18) and more worry about lifting restrictions early (.31).
  - An earlier specification (random covariates) produced spurious sign flips when ideology was added; the final conditional-covariate specification does not, so ideology stays in Block 2.
- **Fixes.** `trustgovt` recoded as 3 categories (was treated as 4). Added race dummies, missing-income indicator, 2017 Trump approval.
- **Manuscript.** Results section now has the figures and tables (descriptives by party, invariance, main models, change figure, specificity, exposure, consequences, robustness) and a drafted results text using inline R numbers (styled per `nowlin-style-profile.md`).
- `renv.lock` updated (lavaan 0.6-21, semTools 0.5-8).
- **Open items:**
  - Robustness not yet run: weights and attrition, local COVID death rates, separate E and I models, 15-item ECON, ideologue moderation.
  - Block 2 and RQ5 models fit less well (CFI .906 and .877; RMSEA ≤ .05), likely from direct effects of party/ideology on value items.
  - Confirm the definition of `weight_allpanel_2020Nov` (still open from Session 1).
  - Discuss the media-trust pre-trend in the Discussion.

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
