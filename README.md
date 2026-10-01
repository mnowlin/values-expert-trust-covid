# Core Values and Trust in Experts Before and After COVID-19

Manuscript and reproducible analysis examining how pre-pandemic core values
shape trust in scientists and experts, and how COVID-19 changed those
relationships. The five values are:

- egalitarian–individualist economic values
- authoritarianism
- religiosity
- social distrust
- political inefficacy

The data come from the Democracy Fund Voter Study Group's VOTER Survey panel.
The analytic sample is the 2,544 respondents interviewed in both July 2017
(before COVID) and November 2020 (during COVID). Value measures come from the
2011, 2016, and 2017 waves. COVID-era mediators and exposure measures come
from the September 2020 wave.

## Layout

```
values-expert-trust-covid.qmd        Manuscript source (renders to HTML, PDF, DOCX)
_quarto.yaml                         Quarto project config
custom-reference-doc.docx            Word reference template used for the DOCX output
LOG.md                               Running session log (newest entry first)
renv.lock, renv/, .Rprofile          renv package environment
scripts/
  analysis.R                         Sourced by the qmd: builds the analytic panel,
                                       recodes values, outcomes, mediators, and controls,
                                       and creates the objects used in the manuscript
  export-cited-refs.R                Pre-render step: trims the master .bib to cited keys
research-design/
  expert-trust-covid-design.md       Research design: RQs, hypotheses, identification,
                                       models, and variable list
  voter-measurement-pass.md          EFA/CFA that produced the five value dimensions
data/                                VOTER Survey data and codebook (NOT in git -- see below)
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
- `LOG.md` records what changed and why for each work session; add a new
  entry at the top.
