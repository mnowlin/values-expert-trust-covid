# Core Values and Trust in Experts Before and After COVID-19

Manuscript and reproducible analysis examining how pre-pandemic core values
shape trust in scientists and experts, and which of them predicted change in
that trust across COVID-19. The predictors are:

- core values: economic egalitarianism–individualism, authoritarianism, religiosity
- civic orientations: social distrust, political inefficacy

The data come from the Democracy Fund Voter Study Group's VOTER Survey panel.
The analytic sample is the 2,544 respondents interviewed in both July 2017
(before COVID) and November 2020 (during COVID). Value and civic-orientation
measures come from the 2016 and 2017 waves. COVID exposure comes from the
September and November 2020 waves, and COVID attitudes from November 2020.

## Layout

```
values-expert-trust-covid.qmd        Manuscript source (renders to HTML, PDF, DOCX)
_quarto.yaml                         Quarto project config
custom-reference-doc.docx            Word reference template used for the DOCX output
LOG.md                               Running session log (newest entry first)
renv.lock, renv/, .Rprofile          renv package environment
scripts/
  analysis.R                         Sourced by the qmd: builds the analytic panel,
                                       recodes all variables, fits the SEMs, and builds
                                       the tables, figures, and inline numbers
  values-measurement-refit.R         Refit of the values measurement model (trimmed ECON)
  export-cited-refs.R                Pre-render step: trims the master .bib to cited keys
research-design/
  expert-trust-covid-design.md       Research design: RQs, hypotheses, identification,
                                       models, and variable list
  voter-measurement-pass.md          EFA/CFA that produced the value and civic-orientation
                                       factors (§7: trimmed refit)
output/
  model-results.rds                  Cached model results (tables only) used by analysis.R
  values-measurement-refit/          Fit, loadings, omega, and modification indices
data/                                VOTER Survey data, codebook, and item wording
                                       (value-construct-items.md) -- NOT in git, see below
literature/                          Background literature (NOT in git -- local only)
```

## Reproducing the analysis

R packages are managed with `renv`. Run `renv::restore()` once to install the
recorded versions.

- **Manuscript:** `quarto render` → outputs to `_output/`
  (HTML, PDF, and DOCX; the DOCX uses `custom-reference-doc.docx`)
- **Analysis only:** `Rscript -e 'source("scripts/analysis.R")'` builds the
  analytic panel and the manuscript objects without rendering.

## Data

The `data/` folder is **not tracked in git**. Restore it before running the analysis:

- `data/voter_panel.csv` — the Democracy Fund Voter Study Group VOTER Survey
  panel file (wide format; one row per respondent; variables suffixed by wave,
  e.g. `expert_help_2017`, `expert_help_2020Nov`). Available from
  voterstudygroup.org.
- `data/VOTER-Survey-Guide-2021Dec.pdf` — the codebook. Response codes can
  differ across waves for the same item; for example, `people_trust_2016` is
  reversed relative to `people_trust_2020Nov`. All recodes in
  `scripts/analysis.R` follow the wave-specific codebook entries.

## Notes

- `references.bib` and the local `.csl` are generated at render time by the
  pre-render step (`export-cited-refs.R`) from the master bibliography, so
  they are git-ignored.
- Quarto's freeze cache (`_freeze/`) is enabled (`execute: freeze: auto` in
  `_quarto.yaml`), so code chunks are only re-executed when the qmd or its
  upstream R sources change.
- Fitting the models takes about 5 minutes. `analysis.R` caches the results
  in `output/model-results.rds` and refits only when `analysis.R` or the data
  file is newer than the cache. Delete the file to force a refit.
- `LOG.md` records what changed and why for each work session; add a new
  entry at the top.
