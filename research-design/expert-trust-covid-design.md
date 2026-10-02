---
title: "Core Values, Trust in Experts, and COVID-19 — Research Design (VOTER Panel)"
type: research-design
created: 2026-10-01
updated: 2026-10-01
status: proposal for a separate project
data: "data/voter_panel.csv (Democracy Fund VOTER Survey)"
builds-on: ["research-design/voter-measurement-pass.md", "00-ct-democracy idea folder: voter-study-ct-democracy-items.md"]
tags: [trust-in-experts, science, covid-19, values, civic-orientations, panel, research-design]
---

# Core Values, Trust in Experts, and COVID-19

*A design for a separate paper. It uses three core values recovered in the [[voter-measurement-pass]] (economic egalitarianism–individualism, authoritarianism and religiosity) and two civic orientations (social distrust and political inefficacy) to explain (1) trust in scientists and experts before COVID-19, and (2) which values predict **change** in that trust across the pandemic.*

------------------------------------------------------------------------

## 1. Motivation and framing

Most work on pandemic-era trust in science uses partisanship or ideology as the explanatory variable. This project asks whether **pre-pandemic core values**, all measured 2016–2017, years before COVID, shaped how people's trust in experts moved once expert advice became costly, politicized and personally consequential.

[[nowlin-anderson-reedy-2026-deciding-who-decides-summary|Nowlin, Anderson & Reedy (2026)]] link values to trust in, and support for, expert decision-makers in a low-salience domain (nuclear waste). COVID-19 is the high-salience counterpart: a test of whether value–trust relationships hold, flip or intensify when an issue becomes polarized (Yuan et al. 2024).

**Descriptive starting point** (panel respondents present in both 2017 and 2020N, n = 2,544, unweighted, % agree):

| Item | 2017 | 2020N | Dem 2017→2020 | Rep 2017→2020 | Within-person r |
|---|---|---|---|---|---|
| "I'd rather trust the wisdom of ordinary people than … experts" | 45.5 | 37.7 | 26.4 → 16.9 | 67.5 → 62.7 | .61 |
| "When it comes to really important questions, scientific facts don't help very much" | 25.9 | 21.0 | 15.6 → 10.8 | 40.1 → 34.2 | .57 |
| "Ordinary people can really use the help of experts to understand … science and health" | 83.2 | 82.9 | 91.1 → 94.2 | 76.1 → 70.9 | .45 |

On average the public became *more* pro-expert, but the partisan gap widened, sharply so on the science-and-health item (from 15 to 23 points). Within-person stability is only moderate (r = .45–.61), so there is real individual-level change to explain. **The research question is therefore one of divergence: which values pulled people away from experts while the overall trend moved toward them?**

------------------------------------------------------------------------

## 2. Research questions and hypotheses

**RQ1 (baseline).** How do the three core values and the two civic orientations relate to trust in experts in 2017, net of demographics, and how much of each relationship runs through party and ideology?

**RQ2 (change).** Which values and civic orientations predict *change* in expert trust from 2017 to late 2020, in which direction, and by how much? This is the core question of the paper.

**RQ3 (specificity).** Is the change specific to experts and science, or part of a general decline in institutional trust?

**RQ4 (exposure).** Does value-based change in expert trust differ by personal exposure to COVID?

**RQ5 (consequences).** Does change in expert trust predict Nov 2020 views of Trump's and the governor's handling of COVID and of lifting restrictions, net of values and political identity?

**No mediators.** COVID is the period between the two expert-trust measurements, not a variable to be mediated. The question is which values and civic orientations moved across that period, not the channel through which they moved. Attributing the change to COVID rather than to other 2017–2020 events rests on the specificity, pre-trend and exposure tests (§3.2).

Hypotheses are directional where theory agrees and stated as competing pairs where it doesn't.

| Core value (measurement pass) | Baseline expectation (RQ1) | Change expectation (RQ2) | Reasoning |
|---|---|---|---|
| **ECON** (egalitarian + ↔ individualist −) | Egalitarian end more pro-expert | **H-ECON:** the individualist end declines most | COVID expertise meant collective restrictions on markets and personal choice, which economic individualists resist and egalitarians favor ([[risk-perception-and-culture]]). *Competing:* Nowlin et al. (2026) find individualism supports *expert* influence even while distrusting government, which would predict a smaller decline if experts are seen as separate from government. |
| **AUTH** (authoritarian child-rearing) | Small positive or null (deference to authority) | **H-AUTH (conflicting authority):** declines, *because* authoritarians followed the partisan authority (Trump) when it broke with the expert authority (CDC) | This separates deference to position (experts) from deference to the in-group's leader, a distinction in the authoritarianism literature ([[authoritarianism]], [[right-wing-authoritarianism]]). *Competing:* if deference to positional expertise dominates (Nowlin et al. 2026: hierarchical values → expert trust), AUTH predicts stability or an increase. |
| **RELIG** | Lower trust in science (science–religion boundary) | **H-RELIG:** declines (closures of worship, faith-based exemptions) | Distinct from AUTH (r = .44 in the measurement model), so the two can be separated. |

**Why ECON is one measure, not separate egalitarian and individualist measures.** In the analytic panel the latent correlation between the egalitarian and individualist items is −.94 (−.95 in the measurement pass). Entered together, each coefficient would be identified only from the small residual the two do not share, which the measurement pass traced to method variance in the binary government-role items. ECON is scored so that higher = more egalitarian; H-ECON is a test of its sign (a negative effect on change means the individualist end declined most). Separate E and I models are a robustness check (§3.4).

**Civic orientations.** Social distrust and political inefficacy are not core values. The core values are prescriptive commitments about how society *ought* to be organized (equality, authority, faith). The civic orientations are beliefs about how things *are*: whether other people can be trusted and whether the political system responds to people like the respondent. This follows the political-culture distinction between value commitments and civic orientations (generalized social trust, political efficacy). They are not controls either, since each carries a hypothesis. They are close to unrelated to ECON (r = −.05, .20) and only modestly related to AUTH (r = .30, .15), so the two sets do not compete for variance.

| Civic orientation (measurement pass) | Baseline expectation (RQ1) | Change expectation (RQ2) | Reasoning |
|---|---|---|---|
| **DISTRUST** (social distrust) | Lower expert trust | **H-DIST:** further decline, *or* floor effects | Generalized social trust is a consistent predictor of trust in science: experts are strangers whose claims must be taken on trust. Distrust of others also makes anti-elite appeals that cast experts as self-interested more persuasive. |
| **INEFF** (political inefficacy) | More populist ("ordinary people") preference | **H-INEFF:** decline, amplified by the anti-expert rhetoric that framed experts as unaccountable elites | Inefficacy is close to the anti-elitism dimension of populism ([[populism]]). |

*Cautions for the civic orientations.*
- **INEFF is the weakest measure** (two items, ω = .66). Null or weak effects may reflect measurement error; report item-level results as well.
- **Content overlap with the outcome.** INEFF is conceptually close to `expert_trustordinary` ("trust the wisdom of ordinary people"), which is itself a populist item. An INEFF effect on that item may partly reflect shared content; `expert_help` and `expert_facts` are the cleaner tests of H-INEFF.
- **Timing.** INEFF was measured in Dec 2016, right after the election, when efficacy can track winner/loser status. In these data INEFF barely correlates with party (latent r = −.12), so the concern is small, but it should be noted.

**H-SPEC (specificity).** Value-based divergence is larger for expert and science trust than for general government trust (`trustgovt`) and non-health institutions over the same period.

**Political identity.** Party and ideology are treated as political identities, not values, and enter as a second block (§3.4). *Expectation:* ECON's effects attenuate most when they are added, since ECON overlaps heavily with both (r = −.69 with party, −.70 with ideology); AUTH and RELIG attenuate less (r = .26–.44). How much each value effect survives the second block is a result in itself.

**H-EXPO (exposure).** Personal exposure (someone in one's circle sick with COVID) and higher local COVID burden *reduce* value-based divergence: direct threat pulls people toward expert advice regardless of values.

**H-CONS (consequences).** Respondents whose expert trust declined more from 2017 to Nov 2020 are more approving of Trump's handling of COVID, less approving of their governor's handling, and less worried that restrictions will be lifted too quickly (all Nov 2020), net of values, civic orientations and political identity. This follows the direction argued for restriction attitudes: expert trust shapes COVID attitudes, not the reverse. Two limits: (1) Trump's messaging plausibly *caused* some of the decline in expert trust, so the Trump-approval association runs both ways and is reported as an association, not an effect; the governor and lifting-restrictions outcomes are less exposed to this. (2) The seven Sep 2020 restriction-support items (`covid_restrict_*`) cannot be outcomes, because they were asked before the change in expert trust was complete.

------------------------------------------------------------------------

## 3. Design

### 3.1 Panel structure

| Wave | Role | What it supplies |
|---|---|---|
| Dec 2011 | Demographics | `birthyr`, `gender` |
| Dec 2016 | Values and civic orientations (pre) | AUTH (child-rearing), RELIG, the economic items in ECON; DISTRUST and INEFF; pre-trend items |
| **Jul 2017** | **Baseline outcome (T1)** + values | `expert_*` battery (T1); the egalitarianism scale and individualism items in ECON |
| 2018, Jan 2019, Nov 2019 | Pre-COVID trend | Institutional confidence, media trust, trust in government, climate acceptance |
| **Sep 2020** | **Exposure** | `covid_sick*` (first exposure measure) |
| **Nov 2020** | **Post outcome (T2)** + consequences | `expert_*` battery (T2); confidence in the CDC; institutional confidence; `covid_sick*` (second exposure measure); Trump and governor COVID approval, `covid_endrestrictions` (RQ5 outcomes) |

**Analytic sample:** the 2,544 respondents present in both Jul 2017 and Nov 2020. All of them also completed Sep 2020, 2,539 completed Nov 2019, and 2,523 have valid `expert_trustordinary` in both waves. All value measures come before the pandemic, so they can't be consequences of COVID-era polarization. That temporal ordering is the design's main strength.

### 3.2 Identification

A two-wave pre/post comparison cannot by itself separate COVID from everything else that happened 2017–2020 (the Trump presidency, impeachment, the 2020 campaign). The design uses four layers to narrow that gap:

1. **Change models with pre-period values.** These answer which values predict change in expert trust across the pandemic period. That claim is defensible on its own; the COVID attribution comes from layers 2–4.
2. **Specificity / placebo outcomes (H-SPEC).** Run the same model on change in `trustgovt` (2017→2020N) and in confidence in non-health institutions (`inst_military`, `inst_court`, `inst_business`, 2019J→2020N). If value-based divergence is concentrated on expert and science trust, a general anti-institutional explanation is less likely.
3. **Pre-trends.** Expert items exist only in 2017 and 2020, but related epistemic-trust items have pre-COVID series: `beliefinmedia` (2016, 2019J, 2019N, 2020N), `trustgovt` (2016, 2017, 2018, 2019J, 2020N), and `envwarm` / `envcause` (2011, 2016, 2019N, as climate-science acceptance). Test whether value groups were already diverging *before* 2020 (2016→2019N slope vs. 2019N→2020N slope for media trust). Parallel pre-trends make a COVID-period break more credible.
4. **Dose-response (H-EXPO).** Interact values with COVID exposure:
   - individual: `covid_exposure`, the number of circles (self, family, work, close friend) with a COVID case reported in Sep *or* Nov 2020 (0–4; Sep-only and Nov-only counts as robustness checks). Include its main effect: exposure may itself depend on values (e.g., individualists taking fewer precautions), so it is not as-if random
   - optionally, local: state or congressional-district COVID death rates merged on `inputstate` / `cdid` from external sources (e.g., NYT or JHU county data aggregated to districts)

   Divergence that varies with local burden is harder to attribute to non-COVID events.

### 3.3 Measurement

- **Values:** the M6 model from the [[voter-measurement-pass]], estimated on the full panel. It supplies the three core values (ECON, AUTH, RELIG) and the two civic orientations (DISTRUST, INEFF), with ECON restricted to its 12 economic items (8 egalitarian, 4 individualist). The two traditional gender-role items (`sexism_roles`, `class_manlymen`) and the fatalism item (`fatalism2`) are dropped: they are not economic content and loaded weakly on ECON (−.35, −.47, +.39). The trimmed model was refit on the same half-B sample (`scripts/values-measurement-refit.R`; [[voter-measurement-pass]] §7): χ² = 2,457 (222), scaled CFI .981, RMSEA .063, SRMR .058; robust CFI .870, RMSEA .117. Loadings, ω and factor correlations are essentially unchanged. All value items come from 2016–2017. The measurement pass was originally run to test cultural-theory structures, which it did not recover. This project uses only the empirically derived factors and does not adopt a cultural-theory framing.
- **Expert trust:** a latent factor from the three `expert_*` items (`trustordinary`, `facts` and `help`; the latter two are recoded so higher = more trust).
  - **Longitudinal invariance first.** Test configural, metric and scalar invariance across 2017 and 2020N. Latent change is interpretable only under at least partial scalar invariance.
  - If the items don't form an invariant factor, which is plausible since `help` is about deference and `trustordinary` is populist, analyze them **item by item**. The `help` item is the closest to "trust in scientists" and shows the strongest polarization, so it is the primary single-item outcome.
- **Change in expert trust as a predictor (RQ5):** use the latent change score from M-change (LCS), not observed difference scores or groups. A difference between two 4-point items with within-person r = .45–.61 is noisy; grouping respondents into decliners, stable and increasers adds error and regression to the mean. Groups defined by large moves (two or more categories) can be used in descriptive figures only.
- **Exclude `expert_struggle`** ("politics is a struggle between good and evil") from the outcome. It is a Manichean-populism item, so use it as a covariate or moderator.

### 3.4 Models

| Model | Specification | Answers |
|---|---|---|
| **M-base** | Latent ExpertTrust(2017) on the core values + civic orientations + controls (Block 1), then + political identity (Block 2) | RQ1 |
| **M-change (LDV)** | ExpertTrust(2020N) on ExpertTrust(2017) + core values + civic orientations + controls, Blocks 1 and 2 | RQ2 (conditional change) |
| **M-change (LCS)** | Latent change score: ΔExpertTrust on core values + civic orientations + controls, under invariance | RQ2 (absolute change). Report both, since LDV and change-score models answer different questions (Allison 1990) |
| **M-spec** | The same two change models with `trustgovt` and non-health `inst_*` as outcomes | RQ3 |
| **M-expo** | M-change with values × `covid_exposure` interactions, plus the exposure main effect | RQ4, H-EXPO |
| **M-cons** | Nov 2020 Trump COVID approval, governor COVID approval and `covid_endrestrictions` on latent ΔExpertTrust + core values + civic orientations + controls + political identity | RQ5, H-CONS (associations; ordinal / binary outcomes) |
| **M-CDC** | `inst_cdc_2020Nov` on values + ExpertTrust(2017) | External validity: do the same values predict confidence in the agency at the center of COVID? (post-only, quasi-change) |

**Specification.** M-base and the change models are estimated in two blocks (M-cons always includes Block 2):

| Block | Variables | Measured |
|---|---|---|
| **Core values** | ECON (egalitarian + ↔ individualist −), AUTH, RELIG | 2016–2017 |
| **Civic orientations** | DISTRUST, INEFF | 2016 |
| **Controls** (both blocks) | Age, gender, race/ethnicity, education, income; news interest | 2011 (age, gender), 2017 |
| **Block 2: political identity** | Party ID (`pid7_2017`), ideology (`ideo5_2017`) | 2017 |

Block 1 = core values + civic orientations + controls; Block 2 adds political identity. Party and ideology are not core values: they are 2017 political identities that overlap heavily with ECON (latent r = −.69 and −.70; with AUTH .28 and .44; with RELIG .26 and .43). Treating them as a separate block keeps the paper's claim, that pre-pandemic values explain change *beyond* partisanship, testable. Report the change in each value and civic-orientation coefficient from Block 1 to Block 2 and decompose the share running through party and ideology (cf. [[partisan-mediation]], [[nowlin-rabovsky-2020-summary|Nowlin & Rabovsky 2020]]). Party and ideology correlate .68, so report their joint contribution and do not interpret their separate coefficients strongly.

**Reporting change.** For each value and civic orientation, report the predicted change in expert trust at high vs. low levels (±1 SD), so the direction and size are in interpretable units. Report the latent factor and each item separately: direction can differ by item (`help` polarized while `trustordinary` rose for everyone).

**Robustness for ECON:** (a) the egalitarian and individualist items as separate factors, each in its own model, never together; (b) the original 15-item ECON with the gender-role and fatalism items.

**Optional moderator:** Jackson's ideologue/nonideologue split (`ideo5_2017`). Do value effects on expert trust change more among nonideologues, whose preferences form from values rather than ideology ([[ideologues-vs-nonideologues]])?

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

### 4.2 Core values and civic orientations (pre-COVID; from the measurement pass)

Core values: ECON, AUTH, RELIG. Civic orientations: DISTRUST, INEFF. Item wording is in `data/value-construct-items.md`.

| Factor | Items (wave) |
|---|---|
| ECON | `egalitarian_opportunities`, `_worryless`, `_chance`, `_fewerproblems`, `income_redistribution`, `govt_moreorless`, `govtreg_business`, `univhealthcov` (2017); `wealth`, `economicbias`, `fairsociety`, `govt_econinvolve` (2016) |
| *(robustness)* E / I | ECON split: the 8 egalitarian items vs. the 4 individualist items, in separate models |
| AUTH | `sc1_independent`, `sc2_curiosity`, `sc3_obedience`, `sc4_considerate` (2016) |
| RELIG | `religservice`, `religimp` (2016) |
| DISTRUST *(civic orientation)* | `people_trust` (**2016 codes reversed vs. 2020N**), `people_helpful`, `people_fair` (2016) |
| INEFF *(civic orientation)* | `nosay`, `electionsmatter` (2016) |

### 4.3 COVID exposure and COVID attitudes

| Variable | Waves | Content | Role |
|---|---|---|---|
| `covid_sickyou`, `_sickfamily`, `_sickwork`, `_sickfriend` | 2020S, 2020N | Someone in that circle sick with COVID (yes / no / maybe) | Exposure moderator: `covid_exposure` = circles with a case in either wave (0–4) |
| *External:* state / district COVID deaths per capita | merge on `inputstate`, `cdid` | — | Local burden (H-EXPO) |
| `trumpapp_covid` | 2020N | Approve of Trump's handling of the coronavirus | RQ5 outcome |
| `govapp_covid` | 2020N | Approve of the state governor's handling of COVID | RQ5 outcome |
| `covid_endrestrictions` | 2020N | Greater concern that states will lift restrictions too quickly vs. not quickly enough | RQ5 outcome |

Not used: the Sep 2020 versions of the approval items, `covid_concern`, and the seven `covid_restrict_*` items (Sep 2020 only). There are no mediators, and Sep 2020 attitudes precede the end of the change in expert trust, so they cannot be RQ5 outcomes.

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
| `pid7`, `ideo5` | 2017 (pre); all waves available | Political identity (Block 2); ideologue split |
| `educ`, `birthyr`, `gender`, `race`, `faminc` | 2011 (`birthyr`, `gender`), 2017 | Demographic controls (both blocks) |
| `newsint` | 2017 | Political attention |
| `expert_struggle` | 2017, 2020N | Manichean populism covariate |
| `trumpapp`, `fav_trump` | 2017 | Robustness for RQ5: separate general Trump support (pre-COVID) from approval of his COVID handling |
| `inputstate`, `cdid` | 2020N | Merge keys for local COVID data; state fixed effects |

------------------------------------------------------------------------

## 5. Threats and how the design handles them

| Threat | Handling |
|---|---|
| Two-wave design can't isolate COVID from other 2017–2020 events | Placebo outcomes, pre-trends on related series, dose-response with local burden; frame claims as "across the pandemic period" unless the layers converge |
| Values are partisan proxies | Values measured 2016–2017; two-block models (core values, then + party and ideology); decomposition of the share running through political identity |
| Expert items may not be measurement-invariant over time | Longitudinal invariance testing; item-level fallback |
| Panel attrition (≈ 49% of 2017 respondents missing in 2020N) | Attrition analysis; retention weights; compare to `weight_allpanel_2020Nov` results |
| RQ5: Trump COVID approval may cause, not follow, change in expert trust | Report as an association; control for political identity and pre-COVID Trump approval (`trumpapp_2017`); emphasize the governor and lifting-restrictions outcomes |
| RQ5: change in trust is measured with error | Latent change score as predictor; no grouping on observed differences |
| Exposure depends on values and behavior | Include the exposure main effect; interpret interactions as moderation, not as-if random dose; local death rates as an exposure measure independent of self-report |
| Regression to the mean / ceiling (`expert_help` 83% agree) | Report both LDV and latent change models; ordinal models for skewed items |
| INEFF is a weak two-item measure (ω = .66) and overlaps in content with `expert_trustordinary` | Item-level INEFF results; treat `expert_help` and `expert_facts` as the main tests of H-INEFF |
| ECON's robust fit was mediocre in the measurement pass | Gender-role and fatalism items dropped from ECON (scaled fit and SRMR improve; robust RMSEA stays ≈ .11); robustness: factor scores vs. unit-weighted scales |

------------------------------------------------------------------------

## 6. Analysis roadmap

1. **Data build:** extract the analytic panel (n = 2,544); recode outcomes, values, exposure and Nov 2020 COVID attitudes; document every recode against wave-specific codebook entries (see the `people_trust` reversal).
2. **Measurement:** refit M6 values on the full panel; longitudinal invariance of the expert-trust factor (2017 vs. 2020N).
3. **Descriptives:** weighted change in each expert item by value tercile and by party (figure: 2017→2020 slopes by value group).
4. **RQ1–RQ2:** baseline, LDV and LCS models, Block 1 (core values + civic orientations + controls) and Block 2 (+ party and ideology).
5. **RQ3:** placebo outcomes and pre-trend analysis.
6. **RQ4:** values × exposure interactions; merge local COVID data.
7. **RQ5:** latent change in expert trust → Nov 2020 Trump and governor COVID approval and `covid_endrestrictions`.
8. **Robustness:** weights, attrition, item-level ordinal models, ideologue moderation; separate E and I models; 15-item ECON.

**Target venues** (to weigh): *Public Opinion Quarterly*, *Political Behavior*, *Risk Analysis*, *Public Understanding of Science*, *Review of Policy Research* (continuity with Nowlin et al. 2026).

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
