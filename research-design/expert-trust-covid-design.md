---
title: "Core Values, Trust in Experts, and COVID-19 — Research Design (VOTER Panel)"
type: research-design
created: 2026-10-01
updated: 2026-10-01
status: proposal for a separate project
data: "data/voter_panel.csv (Democracy Fund VOTER Survey)"
builds-on: ["research-design/voter-measurement-pass.md", "00-ct-democracy idea folder: voter-study-ct-democracy-items.md"]
tags: [trust-in-experts, science, covid-19, values, panel, cultural-theory, research-design]
---

# Core Values, Trust in Experts, and COVID-19

*A design for a separate paper. It uses the five value dimensions recovered in the [[voter-measurement-pass]] to explain (1) trust in scientists and experts before COVID-19, and (2) which values predict **change** in that trust across the pandemic.*

------------------------------------------------------------------------

## 1. Motivation and framing

Most work on pandemic-era trust in science uses partisanship or ideology as the explanatory variable. This project asks whether **pre-pandemic core values**, all measured 2011–2017, years before COVID, shaped how people's trust in experts moved once expert advice became costly, politicized and personally consequential.

[[nowlin-anderson-reedy-2026-deciding-who-decides-summary|Nowlin, Anderson & Reedy (2026)]] link cultural worldviews to trust in, and support for, expert decision-makers in a low-salience domain (nuclear waste). COVID-19 is the high-salience counterpart. It is the natural test of the open question in the wiki about whether culture–trust relationships hold, flip or intensify when an issue becomes polarized ([[nuclear-waste-risk-and-culture]]; Yuan et al. 2024).

**Descriptive starting point** (panel respondents present in both 2017 and 2020N, n = 2,544, unweighted, % agree):

| Item | 2017 | 2020N | Dem 2017→2020 | Rep 2017→2020 | Within-person r |
|---|---|---|---|---|---|
| "I'd rather trust the wisdom of ordinary people than … experts" | 45.5 | 37.7 | 26.4 → 16.9 | 67.5 → 62.7 | .61 |
| "When it comes to really important questions, scientific facts don't help very much" | 25.9 | 21.0 | 15.6 → 10.8 | 40.1 → 34.2 | .57 |
| "Ordinary people can really use the help of experts to understand … science and health" | 83.2 | 82.9 | 91.1 → 94.2 | 76.1 → 70.9 | .45 |

On average the public became *more* pro-expert, but the partisan gap widened, sharply so on the science-and-health item (from 15 to 23 points). Within-person stability is only moderate (r = .45–.61), so there is real individual-level change to explain. **The research question is therefore one of divergence: which values pulled people away from experts while the overall trend moved toward them?**

------------------------------------------------------------------------

## 2. Research questions and hypotheses

**RQ1 (baseline).** How do the five value dimensions relate to trust in experts in 2017, net of partisanship, ideology and demographics?

**RQ2 (change).** Which values predict *change* in expert trust from 2017 to late 2020?

**RQ3 (specificity).** Is the change specific to experts and science, or part of a general decline in institutional trust?

**RQ4 (mechanisms).** Does the change run through COVID-specific channels: partisan cues (approval of Trump's COVID handling), attitudes toward restrictions, or personal exposure and threat?

Hypotheses are directional where theory agrees and stated as competing pairs where it doesn't.

| Value dimension (measurement pass) | Baseline expectation (RQ1) | Change expectation (RQ2) | Reasoning |
|---|---|---|---|
| **ECON** (egalitarian + ↔ individualist −) | Egalitarian end more pro-expert | **H-ECON:** the individualist end declines most | COVID expertise meant collective restrictions on markets and personal choice, the risk type individualists discount in CT risk research ([[risk-perception-and-culture]], [[cultural-cognition-theory]]). *Competing:* Nowlin et al. (2026) find individualism supports *expert* influence even while distrusting government, which would predict a smaller decline if experts are seen as separate from government. |
| **AUTH** (authoritarian child-rearing) | Small positive or null (deference to authority) | **H-AUTH (conflicting authority):** declines, *because* authoritarians followed the partisan authority (Trump) when it broke with the expert authority (CDC) | This sorts deference-to-position from deference-to-in-group. It speaks to the CT-vs-RWA distinction in [[voter-measurement-pass]] §5.3 and to [[inclusive-vs-exclusive-hierarchy]]. *Competing:* if hierarchy-as-expertise dominates (Nowlin et al. 2026: hierarchy → expert trust), AUTH predicts stability or an increase. |
| **RELIG** | Lower trust in science (science–religion boundary) | **H-RELIG:** declines (closures of worship, faith-based exemptions) | Distinct from AUTH (r = .44 in the measurement model), so the two can be separated. |
| **DISTRUST** (low group) | Lower expert trust | **H-DIST:** further decline, *or* floor effects | Fatalism/low group: experts are one more "they." Verweij (2026): fatalists are receptive to populist anti-elite appeals. |
| **INEFF** (political powerlessness) | More populist ("ordinary people") preference | **H-INEFF:** decline, amplified by the anti-expert rhetoric that framed experts as unaccountable elites | Inefficacy is close to the anti-elitism dimension of populism ([[populism]]). |

**H-SPEC (specificity).** Value-based divergence is larger for expert and science trust than for general government trust (`trustgovt`) and non-health institutions over the same period.

**H-MECH (mediation).** The effects of ECON, AUTH and RELIG on change in expert trust are partly carried by approval of Trump's COVID handling and by opposition to restrictions (both measured Sept 2020, between the two expert-trust waves).

**H-EXPO (exposure).** Personal exposure (self or family sick) and higher local COVID burden *reduce* value-based divergence: direct threat pulls people toward expert advice regardless of values.

------------------------------------------------------------------------

## 3. Design

### 3.1 Panel structure

| Wave | Role | What it supplies |
|---|---|---|
| Dec 2011 | Values (pre) | `fatalism2` (loads on ECON); demographics |
| Dec 2016 | Values (pre) | AUTH (child-rearing), RELIG, DISTRUST, INEFF, the economic items in ECON; pre-trend items |
| **Jul 2017** | **Baseline outcome (T1)** + values | `expert_*` battery (T1); the egalitarianism scale and individualism items in ECON |
| 2018, Jan 2019, Nov 2019 | Pre-COVID trend | Institutional confidence, media trust, trust in government, climate acceptance |
| **Sep 2020** | **Mediators / exposure** | COVID concern, sickness, restriction attitudes, Trump COVID approval |
| **Nov 2020** | **Post outcome (T2)** | `expert_*` battery (T2); confidence in the CDC; institutional confidence |

**Analytic sample:** the 2,544 respondents present in both Jul 2017 and Nov 2020. All of them also completed Sep 2020, 2,539 completed Nov 2019, and 2,523 have valid `expert_trustordinary` in both waves. All value measures come before the pandemic, so they can't be consequences of COVID-era polarization. That temporal ordering is the design's main strength.

### 3.2 Identification

A two-wave pre/post comparison cannot by itself separate COVID from everything else that happened 2017–2020 (the Trump presidency, impeachment, the 2020 campaign). The design uses four layers to narrow that gap:

1. **Change models with pre-period values.** These answer which values predict change in expert trust across the pandemic period. That claim is defensible on its own; the COVID attribution comes from layers 2–4.
2. **Specificity / placebo outcomes (H-SPEC).** Run the same model on change in `trustgovt` (2017→2020N) and in confidence in non-health institutions (`inst_military`, `inst_court`, `inst_business`, 2019J→2020N). If value-based divergence is concentrated on expert and science trust, a general anti-institutional explanation is less likely.
3. **Pre-trends.** Expert items exist only in 2017 and 2020, but related epistemic-trust items have pre-COVID series: `beliefinmedia` (2016, 2019J, 2019N, 2020N), `trustgovt` (2016, 2017, 2018, 2019J, 2020N), and `envwarm` / `envcause` (2011, 2016, 2019N, as climate-science acceptance). Test whether value groups were already diverging *before* 2020 (2016→2019N slope vs. 2019N→2020N slope for media trust). Parallel pre-trends make a COVID-period break more credible.
4. **Dose-response (H-EXPO).** Interact values with COVID exposure:
   - individual: `covid_sick*`, `covid_concern`
   - optionally, local: state or congressional-district COVID death rates merged on `inputstate` / `cdid` from external sources (e.g., NYT or JHU county data aggregated to districts)

   Divergence that varies with local burden is harder to attribute to non-COVID events.

### 3.3 Measurement

- **Values:** the M6 model from the [[voter-measurement-pass]] (ECON, AUTH, RELIG, DISTRUST, INEFF), estimated on the full panel. Report a content-light ECON without the gender-role items as a robustness check. All value items come from 2011–2017.
- **Expert trust:** a latent factor from the three `expert_*` items (`trustordinary`, `facts` and `help`; the latter two are recoded so higher = more trust).
  - **Longitudinal invariance first.** Test configural, metric and scalar invariance across 2017 and 2020N. Latent change is interpretable only under at least partial scalar invariance.
  - If the items don't form an invariant factor, which is plausible since `help` is about deference and `trustordinary` is populist, analyze them **item by item**. The `help` item is the closest to "trust in scientists" and shows the strongest polarization, so it is the primary single-item outcome.
- **Exclude `expert_struggle`** ("politics is a struggle between good and evil") from the outcome. It is a Manichean-populism item, so use it as a covariate or moderator.

### 3.4 Models

| Model | Specification | Answers |
|---|---|---|
| **M-base** | Latent ExpertTrust(2017) on the five values + controls | RQ1 |
| **M-change (LDV)** | ExpertTrust(2020N) on ExpertTrust(2017) + values + controls | RQ2 (conditional change) |
| **M-change (LCS)** | Latent change score: ΔExpertTrust on values + controls, under invariance | RQ2 (absolute change). Report both, since LDV and change-score models answer different questions (Allison 1990) |
| **M-spec** | The same two change models with `trustgovt` and non-health `inst_*` as outcomes | RQ3 |
| **M-med** | Values → (Sep 2020) Trump COVID approval, restriction attitudes, concern → ExpertTrust(2020N), controlling ExpertTrust(2017) | RQ4, H-MECH. Three-wave ordering supports mediation, but it is not causal identification; report sensitivity analysis |
| **M-expo** | M-change with values × exposure interactions | H-EXPO |
| **M-CDC** | `inst_cdc_2020Nov` on values + ExpertTrust(2017) | External validity: do the same values predict confidence in the agency at the center of COVID? (post-only, quasi-change) |

**Controls:** party ID and ideology (both measured 2017, before the pandemic), education, age, gender, race/ethnicity, income, news interest.

**Partisanship.** Because values and party are correlated, report each model **with and without** `pid7_2017`. Also show how much of each value effect runs through party ID (decomposition / mediation). The paper's contribution depends on showing that values add explanation *beyond* party ID (cf. [[partisan-mediation]], [[nowlin-rabovsky-2020-summary|Nowlin & Rabovsky 2020]]).

**Optional moderator:** Jackson's ideologue/nonideologue split (`ideo5_2017`). Do value effects on expert trust change more among nonideologues, whose preferences form culturally rather than ideologically ([[ideologues-vs-nonideologues]])?

**Estimation:** lavaan, WLSMV with ordinal indicators for the latent models; ordinal logit for single-item robustness checks.

**Weights:** the codebook lists `weight_allpanel_2020Nov` for multi-wave analysis. In this subsample it is non-missing for all 2,544, but the codebook's definition (respondents to *every* prior wave) does not match the data (only 2,276 of the 2,544 completed 2018), so confirm the definition with Voter Study Group documentation before relying on it.

**Attrition:** about half of the 2017 respondents (2,456) did not complete Nov 2020. Compare returners and non-returners on 2017 values and expert trust, and consider inverse-probability-of-retention weights as a sensitivity check.

------------------------------------------------------------------------

## 4. Variables

### 4.1 Outcomes

| Variable | Waves | Wording | Role |
|---|---|---|---|
| `expert_trustordinary` | 2017, 2020N | "I'd rather put my trust in the wisdom of ordinary people than the opinions of experts and intellectuals." (4-pt, SA–SD) | Expert-trust indicator (higher after recode = pro-expert) |
| `expert_facts` | 2017, 2020N | "When it comes to really important questions, scientific facts don't help very much." | Expert-trust indicator (science) |
| `expert_help` | 2017, 2020N | "Ordinary people can really use the help of experts to understand complicated things like science and health." | Expert-trust indicator; **primary single item** |
| `inst_cdc` | 2020N only | Confidence in the Centers for Disease Control (4-pt) | Post-only COVID-agency trust (M-CDC) |

### 4.2 Core values (pre-COVID predictors; from the measurement pass)

| Factor | Items (wave) |
|---|---|
| ECON | `egalitarian_opportunities`, `_worryless`, `_chance`, `_fewerproblems`, `income_redistribution`, `govt_moreorless`, `govtreg_business`, `univhealthcov`, `class_manlymen` (2017); `wealth`, `economicbias`, `fairsociety`, `govt_econinvolve`, `sexism_roles` (2016); `fatalism2` (2011) |
| AUTH | `sc1_independent`, `sc2_curiosity`, `sc3_obedience`, `sc4_considerate` (2016) |
| RELIG | `religservice`, `religimp` (2016) |
| DISTRUST | `people_trust` (**2016 codes reversed vs. 2020N**), `people_helpful`, `people_fair` (2016) |
| INEFF | `nosay`, `electionsmatter` (2016) |

### 4.3 COVID mediators and exposure (Sep 2020 unless noted)

| Variable | Waves | Content | Role |
|---|---|---|---|
| `trumpapp_covid` | 2020S, 2020N | Approve of Trump's handling of the coronavirus | Partisan-cue mediator (use 2020S for temporal order) |
| `covid_restrict_gathering`, `_business`, `_school`, `_wfh`, `_travel`, `_stayhome`, `_test` | 2020S | Support for seven restrictions | Policy-cost mediator (scale) |
| `covid_endrestrictions` | 2020S, 2020N | Worry that states will lift restrictions too quickly vs. not quickly enough | Policy-cost mediator |
| `covid_concern` | 2020S, 2020N | Concern that self or family will get sick | Threat / exposure |
| `covid_sickyou`, `_sickfamily`, `_sickwork`, `_sickfriend` | 2020S, 2020N | Someone in that circle sick with COVID (yes / no / maybe) | Personal exposure (count index) |
| `govapp_covid` | 2020S, 2020N | Approve of the state governor's handling of COVID | State-level cue; robustness check |
| `issue_covid` | 2020N | Importance of the coronavirus as an issue | Salience |
| `covid_impact_*` | 2020S | Perceived impact on groups (older, working class, Black, etc.) | Optional: egalitarian concern for unequal harm |
| *External:* state / district COVID deaths per capita | merge on `inputstate`, `cdid` | — | Local burden (H-EXPO) |

### 4.4 Placebo and pre-trend outcomes

| Variable | Waves | Use |
|---|---|---|
| `trustgovt` | 2011, 2016, 2017, 2018, 2019J, 2020N | Specificity test; pre-trend |
| `beliefinmedia` | 2016, 2019J, 2019N, 2020N | Epistemic-trust pre-trend (the 2019N→2020N break is the key test) |
| `inst_military`, `inst_court`, `inst_business`, `inst_congress`, `inst_media`, `inst_church` | 2018, 2019J, 2020N | Non-health institution placebos; pre-trend 2018→2019J |
| `envwarm`, `envcause` | 2011, 2016, 2019N | Pre-COVID science-acceptance trend by values |
| `eliteunderstand` | 2016, 2020N | Anti-elite change (distinguishes anti-elite from anti-expert) |

### 4.5 Controls and moderators

| Variable | Waves | Use |
|---|---|---|
| `pid7`, `ideo5` | 2017 (pre); all waves available | Partisanship / ideology controls; ideologue split |
| `educ`, `birthyr`, `gender`, `race`, `faminc` | 2017 or latest pre-2020 | Demographics |
| `newsint` | 2017 | Political attention |
| `expert_struggle` | 2017, 2020N | Manichean populism covariate |
| `trumpapp`, `fav_trump` | 2017, 2020S | Separating general Trump support from COVID-specific cues |
| `inputstate`, `cdid` | 2020N | Merge keys for local COVID data; state fixed effects |

------------------------------------------------------------------------

## 5. Threats and how the design handles them

| Threat | Handling |
|---|---|
| Two-wave design can't isolate COVID from other 2017–2020 events | Placebo outcomes, pre-trends on related series, dose-response with local burden; frame claims as "across the pandemic period" unless the layers converge |
| Values are partisan proxies | Values measured 2011–2017; models with and without `pid7_2017`; decomposition of the share running through party |
| Expert items may not be measurement-invariant over time | Longitudinal invariance testing; item-level fallback |
| Panel attrition (≈ 49% of 2017 respondents missing in 2020N) | Attrition analysis; retention weights; compare to `weight_allpanel_2020Nov` results |
| Mediators measured only 6–10 weeks before T2 | Sensitivity analysis for unmeasured mediator–outcome confounding; describe as mechanisms consistent with, not proof of, mediation |
| Regression to the mean / ceiling (`expert_help` 83% agree) | Report both LDV and latent change models; ordinal models for skewed items |
| ECON's robust fit was mediocre in the measurement pass | Robustness: factor scores vs. unit-weighted scales; content-light ECON |

------------------------------------------------------------------------

## 6. Analysis roadmap

1. **Data build:** extract the analytic panel (n = 2,544); recode outcomes, values and mediators; document every recode against wave-specific codebook entries (see the `people_trust` reversal).
2. **Measurement:** refit M6 values on the full panel; longitudinal invariance of the expert-trust factor (2017 vs. 2020N).
3. **Descriptives:** weighted change in each expert item by value tercile and by party (figure: 2017→2020 slopes by value group).
4. **RQ1–RQ2:** baseline, LDV and LCS models, with and without party ID.
5. **RQ3:** placebo outcomes and pre-trend analysis.
6. **RQ4:** mediation (Sep 2020 mediators) and exposure interactions; merge local COVID data.
7. **Robustness:** weights, attrition, item-level ordinal models, ideologue moderation.

**Target venues** (to weigh): *Public Opinion Quarterly*, *Political Behavior*, *Risk Analysis* (CT-risk framing), *Public Understanding of Science*, *Review of Policy Research* (continuity with Nowlin et al. 2026).

------------------------------------------------------------------------

## 7. Project set-up note

This design is written for a **separate project**. When ready, say "set-up [project name]" (e.g., `values-expert-trust-covid`) to create the project from the template:
- the `.qmd` manuscript
- `scripts/analysis.R`
- `renv`
- git
- README and log

It would carry over:
- this design
- the analytic-panel build
- the measurement-pass value model
