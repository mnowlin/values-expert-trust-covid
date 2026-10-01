---
title: "VOTER Survey Measurement Pass — Can Four (or Five) Cultural-Theory Factors Be Recovered?"
type: research-design
created: 2026-10-01
updated: 2026-10-01
data: "raw/voter_panel.csv (Democracy Fund VOTER Survey panel, wide format)"
script: "scripts/voter-measurement-pass.R"
outputs: "output/research-design/voter-measurement-pass/"
draws-on: ["output/research-design/voter-study-ct-democracy-items.md", "output/lit-review/cultural-theory-of-democracy-in-the-us-v2.md"]
tags: [measurement, factor-analysis, cultural-theory, voter-study-group, fatalism]
---

# VOTER Survey Measurement Pass

*Exploratory, then confirmatory, factor analysis of the Part A worldview proxies in [[voter-study-ct-democracy-items]], in the 2011→2016→2017 linked panel. The question: can the four grid-group cultures, or five with fatalism split into withdrawal and civilizational anxiety, be recovered from the VOTER items?*

**Short answer: no.** Neither the four-factor nor the five-factor cultural theory (CT) structure is recovered. The data instead support a different, reasonably clean **five-factor** structure:

- **one bipolar economic factor** (egalitarianism ↔ individualism)
- hierarchy split into **authoritarian child-rearing values** and **religiosity**
- withdrawal fatalism split into **social distrust** and **political inefficacy**

The civilizational-anxiety items do not form a factor at all. In 2017 they track which party is in power, not a worldview.

------------------------------------------------------------------------

## 1. Data and design

- **Sample.** All 5,000 respondents to the July 2017 wave. Every one also completed Dec 2016 and the Dec 2011 baseline, so the linked panel is the full 2017 wave. 2,019 have complete data on all 30 items; analyses use all available data (pairwise).
- **Split-sample design.** Respondents were randomly split (seed 20261001). Half A (n = 2,500) is used for the EFA and to specify data-driven models. Half B (n = 2,500) is used for every CFA. No case is used for both.
- **Items.** 30 proxies from Part A, restricted to the 2011, 2016 and 2017 waves:
  - 8 hierarchy
  - 8 egalitarianism
  - 4 individualism
  - 6 fatalism-withdrawal
  - 4 fatalism-anxiety

  Each was recoded so that higher = more of the hypothesized culture. "Don't know", "not sure", skipped and not-asked responses are treated as missing. Item list and recodes are in `scripts/voter-measurement-pass.R`; descriptives are in `item-descriptives.csv`.
- **Estimation.**
  - EFA: polychoric correlations, minres extraction, oblimin rotation. Parallel analysis, Velicer's MAP and Kaiser criteria for the number of factors. Solutions for k = 3–7, plus a target (Procrustes) rotation toward the hypothesized five-factor pattern.
  - CFA: lavaan, WLSMV, all items ordinal, latent variances fixed to 1.
- **Unweighted.** This is a measurement model; a weighted sensitivity check is listed under next steps.
- **Reproducibility.** `renv` was initialized in the project folder (`renv.lock`: R 4.6.0, lavaan 0.6-21, psych 2.6.5, semTools 0.5-8). The script reproduces identical results from the project library.

> **Coding note discovered during this pass.** `people_trust_2016` is coded **in reverse** of `people_trust_2020Nov`. In 2016, 1 = "Can't be too careful"; in 2020N, 1 = "Most people can be trusted." The item inventory used the 2020N wording, so any analysis pooling the two waves must reverse one of them. All other items match their wave-specific codebook entries.

------------------------------------------------------------------------

## 2. Exploratory factor analysis (half A)

**Number of factors.** Parallel analysis suggests 8 factors, MAP suggests 7, and Kaiser suggests 6. No criterion points to 4 or 5.

| k | RMSEA | TLI | BIC | Variance explained |
|---|---|---|---|---|
| 3 | .125 | .743 | 11,146 | .53 |
| 4 | .114 | .784 | 8,302 | .56 |
| 5 | .103 | .823 | 5,882 | .60 |
| 6 | .099 | .838 | 4,763 | .63 |
| 7 | .093 | .858 | 3,586 | .65 |

None of the solutions fits well by conventional standards.

**What the k = 5 oblimin solution recovers** (`efa-loadings-k5.csv`):

| EFA factor | Items (loading) | CT reading |
|---|---|---|
| **ECON** (bipolar) | All 8 egalitarian items +.65 to +.96; all 4 individualist items −.84 to −.95; `sexism_roles` −.35, `class_manlymen` −.47, `fatalism2` +.39 | Egalitarianism and individualism are **one dimension, at opposite ends** |
| **AUTH** | Child-rearing: respect elders .69, manners .73, obedience .84, well behaved .57 | Hierarchy as authoritarian disposition |
| **RELIG** | Service attendance .84, importance of religion .85 | Hierarchy as religious embeddedness |
| **DISTRUST** | People can't be trusted .85, look out for themselves .85, take advantage .97 | Low group (atomization) |
| **INEFF** | No say .67, elections don't matter .63 | Political powerlessness |

At k = 6, an "anxiety" factor appears, but only from `values_culture` (.68) and `track_moralclimate` (.60). At k = 7, a small residual factor collects the traditional gender-role items, the good-vs-evil item and two reverse-worded egalitarian items. That looks like a traditionalism and wording-method factor, not a culture.

**Target rotation toward the hypothesized 5-factor pattern** (`efa-target5-loadings.csv`). Even when the rotation is pushed toward CT:

- The **E** target factor absorbs the individualist items with negative loadings (−.65 to −.76).
- The **I** target factor is left without its own items (no individualist item above |.29|). It picks up religiosity instead (.39–.43).
- The **Fw** target factor is social distrust only. `fatalism2` does not load on it (−.07).
- The **Fa** target factor is weak (.32–.43) and shares its strongest loading with `nosay` (.43).

The hypothesized structure is not hiding behind an unfavorable rotation.

------------------------------------------------------------------------

## 3. Confirmatory factor analysis (half B)

| Model | Factors | χ²(df), scaled | CFI / TLI (scaled) | RMSEA (scaled) | CFI / TLI (robust) | RMSEA (robust) | SRMR | Admissible? |
|---|---|---|---|---|---|---|---|---|
| M1 | 1 general | 20,095 (405) | .842 / .830 | .139 | .606 / .576 | .162 | .133 | yes |
| **M4** | **4 CT: H, E, I, F** | 11,562 (399) | .911 / .902 | .106 | .688 / .660 | .145 | .132 | yes, but r(E,I) = −.95 |
| **M5** | **5 CT: H, E, I, Fw, Fa** | — | — | — | — | — | — | **no**: non-convergence, Fa factor collapses |
| M6 | EFA-derived: ECON, AUTH, RELIG, DISTRUST, INEFF | 4,016 (291) | .969 / .965 | .072 | .854 / .837 | .111 | .070 | yes |
| M7 | M6 with ECON split into E and I | 3,841 (286) | .970 / .966 | .071 | .875 / .858 | .104 | .069 | yes, but r(E,I) = −.95 |

M6 and M7 drop the four anxiety items (see §4). Their two-item factors (RELIG, INEFF) have equal loadings for identification. M4/M5 and M6/M7 use different item sets, so they are compared on fit indices only, not with χ² difference tests.

**Theory-driven models.**
- **M4** beats a single factor: Δχ² = 2,152, df = 6, p < .001. But it fits poorly by every index.
- **In M4, E and I correlate at −.95.**
- **M4's fatalism factor is incoherent.** It is driven by social distrust (.72–.80) and `values_culture` (.81). `nosay` loads .04, `stranger` −.03, and `fatalism2` loads *negatively* (−.33).
- **M5 does not converge.** The anxiety factor has near-zero variance, and its correlations with the other factors are not interpretable.

**Data-derived models.**
- **M6** fits acceptably on the scaled indices (CFI .97, RMSEA .07, SRMR .07) but not on the robust ones (CFI .85, RMSEA .11).
- Splitting ECON into E and I (**M7**) improves fit statistically (Δχ² = 86, df = 5, p < .001, approximate because it is a boundary test) and raises robust CFI by .02. But E and I still correlate −.95. **They are separable only in the narrow sense that the binary government-role items share a little method variance.** Substantively, they are one dimension.

**M6 standardized loadings** (`cfa-loadings-M6_efa_derived.csv`) and ordinal ω:

| Factor | Loadings | ω |
|---|---|---|
| ECON | egalitarian items .67–.97; individualist items −.87 to −.97; women's roles −.50; manly men −.61; `fatalism2` .36 | .96 |
| AUTH | .89, .81, .67, .64 | .85 |
| RELIG | .89, .89 (equal) | .89 |
| DISTRUST | .87, .87, .94 | .92 |
| INEFF | .70, .70 (equal) | .66 |

**M6 factor correlations:**

|  | ECON | AUTH | RELIG | DISTRUST |
|---|---|---|---|---|
| AUTH | −.45 | | | |
| RELIG | −.37 | .44 | | |
| DISTRUST | −.09 | .30 | −.01 | |
| INEFF | .14 | .19 | −.09 | .34 |

**Where M6 misfits** (`cfa-modindices-M6_efa_derived.csv`):
- The two gender-role items want to cross-load on AUTH (MI = 336 and 314; expected standardized loadings around .35–.38).
- `economicbias` cross-loads on INEFF (MI = 325) and has a residual correlation with `nosay`.
- Reverse-worded egalitarian items have residual correlations with each other.

These are the main sources of misfit on the robust indices. An ESEM or bifactor follow-up should be able to absorb them (§6).

------------------------------------------------------------------------

## 4. Why the "civilizational anxiety" items fail: they measure partisan position, not worldview

Polychoric correlations in the full linked panel (`anxiety-items-diagnostic.csv`):

| Item (2017) | r with party ID (Rep. high) | r with "wealth should be more evenly distributed" | r with "government doing too much" |
|---|---|---|---|
| Values of people like me becoming rarer | **+.35** | −.43 | +.48 |
| Moral climate on the wrong track | **−.32** | +.29 | −.27 |
| Feel like a stranger in my own country | **−.18** | +.24 | −.20 |
| Politics is a struggle between good and evil | +.10 | −.05 | +.14 |

In July 2017, six months into Trump's term, two of the four "anxiety" items were endorsed more by **Democrats** (moral climate, stranger) and one more by **Republicans** (values becoming rarer). Each item mixes a stable worldview component with a **winner/loser** component that depends on who holds power. Because the partisan pulls run in opposite directions, the items cannot share a common factor.

This bears directly on v2 §2.2 and H4/H11:

> **OPEN QUESTION.** The Foundation Defender / civilizational-anxiety form of fatalism may not be measurable with generic "decline" or "stranger" items in a polarized period. Those items pick up out-party status. A valid measure probably needs items that fix the *referent*, e.g. "*my* faith community / way of life is under attack," and should be checked for invariance across party.

> **CONTRADICTION** (with the item inventory's Part A4b assumption). Part A4b treated `values_culture`, `stranger` and `track_moralclimate` as markers of one mobilization-receptive fatalism construct. In the 2017 data they do not cohere, and two of them load in the liberal direction. They should be reclassified as **context-dependent political-threat items**, not fatalism proxies.

------------------------------------------------------------------------

## 5. What this means for the paper

1. **The VOTER proxies cannot carry a four-culture design.** The four-culture claim needs either the original survey with proper CT statement batteries (`survey-draft.md`) or a strong argument for why proxy-based factors stand in for grid-group positions. For Study 1, the honest framing is: "*cultural-theory-informed worldview dimensions*," measured by ECON, AUTH, RELIG, DISTRUST and INEFF.

2. **Egalitarianism and individualism collapse into one pole-to-pole dimension.** That has two possible explanations:
   - **The proxies.** Every egalitarian and individualist item here is about economic equality or the role of government, so they share left–right policy content.
   - **A real feature of US public opinion.** In the US, egalitarianism and individualism may genuinely sit at opposite ends of one dimension. That would be consistent with cultural cognition's bipolar axes and with [[swedlow-ripberger-yuan-2024-culture-wars-summary|Swedlow et al.'s]] finding that individualists anchor the right.

   These data cannot tell the two apart. Practically:
   - **H1's "net of individualism" becomes "net of the economic dimension."**
   - **H5 (cultural-balance index) cannot be built**, because there is no separable E and I to balance.

3. **Hierarchy has two empirically distinct components** (r = .44): authoritarian child-rearing values and religiosity. This makes the AUTH-vs-role-differentiation test proposed in the inventory's measurement note feasible. A version of it is in the data: do AUTH and RELIG predict democratic outcomes differently? That speaks to the CT-vs-RWA distinction ([[right-wing-authoritarianism]], [[authoritarianism]]).

4. **Withdrawal fatalism splits into social distrust (low group) and political inefficacy** (r = .34). This is a possible empirical counterpart to [[verweij-2026-populism-fatalism-summary|Verweij (2026)]]'s two-axis mechanism:
   - withdrawal along the low-group axis
   - delegation or powerlessness along the high-grid axis

   It is an interpretive hypothesis, not a finding. DISTRUST correlates .30 with AUTH, which fits a shared high-grid component. H4 should be tested with **DISTRUST and INEFF separately**.

5. **The single best fatalism item does not behave as fatalism.** `fatalism2` ("success in life is determined by forces outside our control", 2011) loads weakly on the *egalitarian* end of ECON (.36–.42) and has low communality (.18). In this sample, an external attribution for success reads as a structural, egalitarian critique, not resignation. It should not anchor a fatalism measure on its own.

------------------------------------------------------------------------

## 6. Caveats and next steps

**Caveats.**
- Robust fit indices for the best model are mediocre (CFI .85, RMSEA .11).
- Several binary items have very high tetrachoric correlations (.92–.97), which pushes some loadings close to 1.
- The items were measured across three waves (2011, 2016, 2017), so some covariance is attenuated by time.
- Results are unweighted and from one random split.

**Suggested next steps** (not run):
1. **Robustness:**
   - repeat the EFA on half B and the CFA on half A (swap the halves)
   - add the 2017 weights (`sampling.weights`)
   - drop the 2011 item to test whether wave spacing matters
2. **ESEM / bifactor model** for ECON + AUTH + RELIG + DISTRUST + INEFF, to absorb the gender-role cross-loadings and the reverse-wording residuals.
3. **Measurement invariance** of M6 across Jackson's ideologue/nonideologue split (`ideo5`) and across party. This is a prerequisite for H8.
4. **Extended item set:** add the exclusive-hierarchy items (`usa_being_*`, `culture_pref`, `immi_muslim`) and test whether an inclusive/exclusive hierarchy factor separates from AUTH and RELIG. That is the measurement half of H6.
5. **Decide on scoring**: factor scores from M6 vs. unit-weighted scales. Either way, report a content-light variant without the gender-role items.

**Wiki links:** [[cultural-statement-measures]], [[continuous-cultural-types]], [[grid-group-typology]], [[fatalism]], [[egalitarianism]], [[individualism]], [[hierarchy]], [[hypotheses-testing]].
